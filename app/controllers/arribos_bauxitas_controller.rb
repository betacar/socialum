class ArribosBauxitasController < ApplicationController
  # before_filter :authenticate_user! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  respond_to :html, :json

  # GET /arribos_bauxitas
  # GET /arribos_bauxitas.json
  def index
    @arribos_bauxitas = ArriboBauxita.all
    respond_with @arribos_bauxitas
  end

  # POST /arribos_bauxitas
  # POST /arribos_bauxitas.json
  def create
    @arribo_bauxita = ArriboBauxita.new(:bax_id => params[:bax_id], :fecha_hora_arribo_bauxita => DateTime.now)

    respond_to do |format|
      if @arribo_bauxita.save
        format.json { render json: @arribo_bauxita, status: :created }
      else
        format.json { render json: @arribo_bauxita.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /arribos_bauxitas/1
  # PUT /arribos_bauxitas/1.json
  def update
    @arribo_bauxita = ArriboBauxita.find(params[:id])

    respond_to do |format|
      if @arribo_bauxita.update_attributes(params[:arribo_bauxita])
        format.html { redirect_to @arribo_bauxita, notice: 'Arribo bauxita was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @arribo_bauxita.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arribos_bauxitas/1
  # DELETE /arribos_bauxitas/1.json
  def destroy
    @arribo_bauxita = ArriboBauxita.find(params[:id])
    @arribo_bauxita.destroy

    respond_to do |format|
      format.html { redirect_to arribos_bauxitas_url }
      format.json { head :no_content }
    end
  end
end
