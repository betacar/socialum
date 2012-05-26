class Buque < ActiveRecord::Base
  belongs_to :tipo_materia
  has_one :ArriboBuque
  has_many :DescargaBauxitas, :as => :arribo
  stampable
  validates_presence_of :tipo_materia_id, :nombre_buque, :tonelaje_buque, :origen_buque, :fecha_zarpe_buque, :message => 'El campo no puede estar vacio'
  attr_accessor :tipos_materiales, :gabarras, :descargas, :equipos, :paises, :atraque_fecha, :atraque_hora, :inicio_fecha, :inicio_hora, :fin_fecha, :fin_hora, :desatraque_fecha, :desatraque_hora, :equipo_id, :novedades

  # Retorna un hash con los atributos del modelo, incluyendo un array con los tipos de materiales.
  def self.nuevo
    buque = self.new
    buque.tipos_materiales = TipoMateria.all
    buque.paises = self.paises

    buque
  end

  # Almacena o actualiza la data de un buque. Formatea las fechas de zarpe, eta, tiempo permitido, rata permitida, pago por demora y tonelaje.
  def self.guardar(params)
    params[:buque][:tiempo_permitido_buque] = params[:buque][:tiempo_permitido_buque].gsub(',', '.') unless params[:buque][:tiempo_permitido_buque].nil? || params[:buque][:tiempo_permitido_buque] == 'null'
    params[:buque][:rata_permitida_buque] = params[:buque][:rata_permitida_buque].gsub(',', '.') unless params[:buque][:rata_permitida_buque].nil? || params[:buque][:rata_permitida_buque] == 'null'
    params[:buque][:pago_demora_buque] = params[:buque][:pago_demora_buque].gsub(',', '.') unless params[:buque][:pago_demora_buque].nil? || params[:buque][:pago_demora_buque] == 'null'
    params[:buque][:tonelaje_buque] = params[:buque][:tonelaje_buque].gsub(',', '.')

    params[:buque][:fecha_zarpe_buque] = DateTime.strptime(params[:buque][:fecha_zarpe_buque], '%d/%m/%Y').to_datetime.to_s(:db)
    params[:buque][:eta_mtz_buque] = DateTime.strptime(params[:buque][:eta_mtz_buque], '%d/%m/%Y').to_datetime.to_s(:db) unless params[:buque][:eta_mtz_buque].nil? || params[:buque][:eta_mtz_buque] == 'null'

    if params[:action] == 'create' then
      buque = Buque.new(params[:buque])
    elsif params[:action] == 'update' then
      buque = self.find(params[:id])
      buque.update_attributes(params[:buque])
    end

    buque.save
  end

  # Busca y retorna la data de un buque particular, incluyendo un array con los tipos de materiales.
  def self.buscar_editar(id)
    buque = self.find(id)
    buque.tipos_materiales = TipoMateria.all
    buque.paises = self.paises.gsub(/(value="#{buque.origen_buque}")/, 'selected="selected" \1') # Selecciono el buque del string y hago match con lo que ya esta guardado

    buque
  end

  # Reporta el arribo de un buque
  def self.reportar(id)
    buque = self.find(id)
    buque.update_attribute(:fecha_arribo_buque, Time.now)
  end

  def self.info(id)
    buque = self.find(id)

    if buque.tipo_materia_id == 1 then
      buque.gabarras = StockGabarra.all(:select => 'gabarra_id, max(fecha_hora_stock)', :group => "gabarra_id" , :conditions => {:locacion_id => 1, :estatus_gabarra_id => 3}) # Todas las gabarras vacias y que esten en Matanzas
      buque.equipos = Equipo.find_all_by_tipo_equipo_id(1)
      buque.descargas = DescargaBauxita.find_all_by_arribo_id_and_arribo_type(buque.id, self.name)
    end

    unless buque.fecha_atraque_buque.nil? # A menos que el arribo no exista
      buque.atraque_fecha = buque.fecha_atraque_buque.to_s(:fecha)
      buque.atraque_hora = buque.fecha_atraque_buque.to_s(:hora)

      buque.inicio_fecha = buque.fecha_inicio_descarga_buque ? buque.inicio_descarga_buque.to_s(:fecha) : nil
      buque.inicio_hora = buque.fecha_inicio_descarga_buque ? buque.inicio_descarga_buque.to_s(:hora) : nil

      buque.fin_fecha = buque.fecha_fin_descarga_buque ? buque.fecha_fin_descarga_buque.to_s(:fecha) : nil
      buque.fin_hora = buque.fecha_fin_fecha_buque ? buque.fecha_fin_descarga_buque.to_s(:hora) : nil

      buque.desatraque_fecha = buque.fecha_desatraque_buque ? buque.fecha_desatraque_buque.to_s(:fecha) : nil
      buque.desatraque_hora = buque.fecha_desatraque_buque ? buque.fecha_desatraque_buque.to_s(:hora) : nil

      # Extraigo las novedades
      buque.novedades = buque.atraque_fecha ? Novedad.find_all_by_proceso_id_and_proceso_type(buque.id, self.name) : nil
    end

    buque
  end

  # Si tonelaje descargado iguala el tonelaje de material del buque, el buque se considera descargado
  def self.descargado(id)
    buque = self.find(id)

    if buque.tipo_materia_id == 1 then # Si el buque es de bauxita, busco en el model de descargas de bauxita
      tonelaje_descarga = DescargaBauxita.sum(:tonelaje_buque, :conditions => {:arribo_id => buque.id, :arribo_type => self.name})
    else
      tonelaje_descarga = buque.tonelaje_buque
    end

    if buque.tonelaje_buque == tonelaje_descarga then
      buque.toggle!(:descargado)
    end
  end
  
  private

    def self.paises
      '<option value="">Seleccione un origen del buque</option><optgroup label="Venezuela"><option value="Amazonas">Amazonas</option><option value="Anzoategui">Anzoategui</option><option value="Apure">Apure</option><option value="Aragua">Aragua</option><option value="Barinas">Barinas</option><option value="Bolivar">Bolivar</option><option value="Carabobo">Carabobo</option><option value="Cojedes">Cojedes</option><option value="Delta Amacuro">Delta Amacuro</option><option value="Distrito Capital">Distrito Capital</option><option value="Falcon">Falcon</option><option value="Guarico">Guarico</option><option value="Lara">Lara</option><option value="Merida">Merida</option><option value="Miranda">Miranda</option><option value="Monagas">Monagas</option><option value="Nueva Esparta">Nueva Esparta</option><option value="Portuguesa">Portuguesa</option><option value="Sucre">Sucre</option><option value="Tachira">Tachira</option><option value="Trujillo">Trujillo</option><option value="Vargas">Vargas</option><option value="Yaracuy">Yaracuy</option><option value="Zulia">Zulia</option></optgroup><optgroup label="Otros paises"><option value="Afganistan">Afganistan</option><option value="Albania">Albania</option><option value="Alemania">Alemania</option><option value="Andorra">Andorra</option><option value="Angola">Angola</option><option value="Anguilla">Anguilla</option><option value="Antartida">Antartida</option><option value="Antigua y Barbuda">Antigua y Barbuda</option><option value="Antillas Holandesas">Antillas Holandesas</option><option value="Arabia Saudi">Arabia Saudi</option><option value="Argelia">Argelia</option><option value="Argentina">Argentina</option><option value="Armenia">Armenia</option><option value="Aruba">Aruba</option><option value="Australia">Australia</option><option value="Austria">Austria</option><option value="Azerbaiyan">Azerbaiyan</option><option value="Bahamas">Bahamas</option><option value="Bahrein">Bahrein</option><option value="Bangladesh">Bangladesh</option><option value="Barbados">Barbados</option><option value="Belgica">Belgica</option><option value="Belice">Belice</option><option value="Benin">Benin</option><option value="Bermudas">Bermudas</option><option value="Bielorrusia">Bielorrusia</option><option value="Birmania">Birmania</option><option value="Bolivia">Bolivia</option><option value="Bosnia y Herzegovina">Bosnia y Herzegovina</option><option value="Botswana">Botswana</option><option value="Brasil">Brasil</option><option value="Brunei">Brunei</option><option value="Bulgaria">Bulgaria</option><option value="Burkina Faso">Burkina Faso</option><option value="Burundi">Burundi</option><option value="Butan">Butan</option><option value="Cabo Verde">Cabo Verde</option><option value="Camboya">Camboya</option><option value="Camerun">Camerun</option><option value="Canada">Canada</option><option value="Chad">Chad</option><option value="Chile">Chile</option><option value="China">China</option><option value="Chipre">Chipre</option><option value="Ciudad del Vaticano (Santa Sede)">Ciudad del Vaticano (Santa Sede)</option><option value="Colombia">Colombia</option><option value="Comores">Comores</option><option value="Congo">Congo</option><option value="Congo, Republica Democratica del">Congo, Republica Democratica del</option><option value="Corea">Corea</option><option value="Corea del Norte">Corea del Norte</option><option value="Costa de Marfil">Costa de Marfil</option><option value="Costa Rica">Costa Rica</option><option value="Croacia (Hrvatska)">Croacia (Hrvatska)</option><option value="Cuba">Cuba</option><option value="Dinamarca">Dinamarca</option><option value="Djibouti">Djibouti</option><option value="Dominica">Dominica</option><option value="Ecuador">Ecuador</option><option value="Egipto">Egipto</option><option value="El Salvador">El Salvador</option><option value="Emiratos Arabes Unidos">Emiratos Arabes Unidos</option><option value="Eritrea">Eritrea</option><option value="Eslovenia">Eslovenia</option><option value="ES">Espania</option><option value="Estados Unidos">Estados Unidos</option><option value="Estonia">Estonia</option><option value="Etiopia">Etiopia</option><option value="Fiji">Fiji</option><option value="Filipinas">Filipinas</option><option value="Finlandia">Finlandia</option><option value="Francia">Francia</option><option value="Gabon">Gabon</option><option value="Gambia">Gambia</option><option value="Georgia">Georgia</option><option value="Ghana">Ghana</option><option value="Gibraltar">Gibraltar</option><option value="Granada">Granada</option><option value="Grecia">Grecia</option><option value="Groenlandia">Groenlandia</option><option value="Guadalupe">Guadalupe</option><option value="Guam">Guam</option><option value="Guatemala">Guatemala</option><option value="Guayana">Guayana</option><option value="Guayana Francesa">Guayana Francesa</option><option value="Guinea">Guinea</option><option value="Guinea Ecuatorial">Guinea Ecuatorial</option><option value="Guinea-Bissau">Guinea-Bissau</option><option value="Haiti">Haiti</option><option value="Honduras">Honduras</option><option value="Hungria">Hungria</option><option value="India">India</option><option value="Indonesia">Indonesia</option><option value="Irak">Irak</option><option value="Iran">Iran</option><option value="Irlanda">Irlanda</option><option value="Isla Bouvet">Isla Bouvet</option><option value="Isla de Christmas">Isla de Christmas</option><option value="Islandia">Islandia</option><option value="Islas Caiman">Islas Caiman</option><option value="Islas Cook">Islas Cook</option><option value="Islas de Cocos o Keeling">Islas de Cocos o Keeling</option><option value="Islas Faroe">Islas Faroe</option><option value="Islas Heard y McDonald">Islas Heard y McDonald</option><option value="Islas Malvinas">Islas Malvinas</option><option value="Islas Marianas del Norte">Islas Marianas del Norte</option><option value="Islas Marshall">Islas Marshall</option><option value="Islas menores de Estados Unidos">Islas menores de Estados Unidos</option><option value="Islas Palau">Islas Palau</option><option value="Islas Salomon">Islas Salomon</option><option value="Islas Svalbard y Jan Mayen">Islas Svalbard y Jan Mayen</option><option value="Islas Tokelau">Islas Tokelau</option><option value="Islas Turks y Caicos">Islas Turks y Caicos</option><option value="Islas Virgenes (EE.UU.)">Islas Virgenes (EE.UU.)</option><option value="Islas Virgenes (Reino Unido)">Islas Virgenes (Reino Unido)</option><option value="Islas Wallis y Futuna">Islas Wallis y Futuna</option><option value="Israel">Israel</option><option value="Italia">Italia</option><option value="Jamaica">Jamaica</option><option value="Japon">Japon</option><option value="Jordania">Jordania</option><option value="Kazajistan">Kazajistan</option><option value="Kenia">Kenia</option><option value="Kirguizistan">Kirguizistan</option><option value="Kiribati">Kiribati</option><option value="Kuwait">Kuwait</option><option value="Laos">Laos</option><option value="Lesotho">Lesotho</option><option value="Letonia">Letonia</option><option value="Libano">Libano</option><option value="Liberia">Liberia</option><option value="Libia">Libia</option><option value="Liechtenstein">Liechtenstein</option><option value="Lituania">Lituania</option><option value="Luxemburgo">Luxemburgo</option><option value="Macedonia, Ex-Republica Yugoslava de">Macedonia, Ex-Republica Yugoslava de</option><option value="Madagascar">Madagascar</option><option value="Malasia">Malasia</option><option value="Malawi">Malawi</option><option value="Maldivas">Maldivas</option><option value="Mali">Mali</option><option value="Malta">Malta</option><option value="Marruecos">Marruecos</option><option value="Martinica">Martinica</option><option value="Mauricio">Mauricio</option><option value="Mauritania">Mauritania</option><option value="Mayotte">Mayotte</option><option value="Mexico">Mexico</option><option value="Micronesia">Micronesia</option><option value="Moldavia">Moldavia</option><option value="Monaco">Monaco</option><option value="Mongolia">Mongolia</option><option value="Montserrat">Montserrat</option><option value="Mozambique">Mozambique</option><option value="Namibia">Namibia</option><option value="Nauru">Nauru</option><option value="Nepal">Nepal</option><option value="Nicaragua">Nicaragua</option><option value="Niger">Niger</option><option value="Nigeria">Nigeria</option><option value="Niue">Niue</option><option value="Norfolk">Norfolk</option><option value="Noruega">Noruega</option><option value="Nueva Caledonia">Nueva Caledonia</option><option value="Nueva Zelanda">Nueva Zelanda</option><option value="Oman">Oman</option><option value="Paises Bajos">Paises Bajos</option><option value="Panama">Panama</option><option value="Papua Nueva Guinea">Papua Nueva Guinea</option><option value="Paquistan">Paquistan</option><option value="Paraguay">Paraguay</option><option value="Peru">Peru</option><option value="Pitcairn">Pitcairn</option><option value="Polinesia Francesa">Polinesia Francesa</option><option value="Polonia">Polonia</option><option value="Portugal">Portugal</option><option value="Puerto Rico">Puerto Rico</option><option value="Qatar">Qatar</option><option value="Reino Unido">Reino Unido</option><option value="Republica Centroafricana">Republica Centroafricana</option><option value="Republica Checa">Republica Checa</option><option value="Republica de Sudafrica">Republica de Sudafrica</option><option value="Republica Dominicana">Republica Dominicana</option><option value="Republica Eslovaca">Republica Eslovaca</option><option value="Reunion">Reunion</option><option value="Ruanda">Ruanda</option><option value="Rumania">Rumania</option><option value="Rusia">Rusia</option><option value="Sahara Occidental">Sahara Occidental</option><option value="Saint Kitts y Nevis">Saint Kitts y Nevis</option><option value="Samoa">Samoa</option><option value="Samoa Americana">Samoa Americana</option><option value="San Marino">San Marino</option><option value="San Vicente y Granadinas">San Vicente y Granadinas</option><option value="Santa Helena">Santa Helena</option><option value="Santa Lucia">Santa Lucia</option><option value="Santo Tome y Principe">Santo Tome y Principe</option><option value="Senegal">Senegal</option><option value="Seychelles">Seychelles</option><option value="Sierra Leona">Sierra Leona</option><option value="Singapur">Singapur</option><option value="Siria">Siria</option><option value="Somalia">Somalia</option><option value="Sri Lanka">Sri Lanka</option><option value="St. Pierre y Miquelon">St. Pierre y Miquelon</option><option value="Suazilandia">Suazilandia</option><option value="Sudan">Sudan</option><option value="Suecia">Suecia</option><option value="Suiza">Suiza</option><option value="Surinam">Surinam</option><option value="Tailandia">Tailandia</option><option value="Taiwan">Taiwan</option><option value="Tanzania">Tanzania</option><option value="Tayikistan">Tayikistan</option><option value="Territorios franceses del Sur">Territorios franceses del Sur</option><option value="Timor Oriental">Timor Oriental</option><option value="Togo">Togo</option><option value="Tonga">Tonga</option><option value="Trinidad y Tobago">Trinidad y Tobago</option><option value="Tunez">Tunez</option><option value="Turkmenistan">Turkmenistan</option><option value="Turquia">Turquia</option><option value="Tuvalu">Tuvalu</option><option value="Ucrania">Ucrania</option><option value="Uganda">Uganda</option><option value="Uruguay">Uruguay</option><option value="Uzbekistan">Uzbekistan</option><option value="Vanuatu">Vanuatu</option><option value="Vietnam">Vietnam</option><option value="Yemen">Yemen</option><option value="Yugoslavia">Yugoslavia</option><option value="Zambia">Zambia</option><option value="Zimbabue">Zimbabue</option></optgroup>'
    end
end