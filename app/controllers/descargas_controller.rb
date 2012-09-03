class DescargasController < ApplicationController
  # GET /descargas
  # GET /descargas.json
  def index
    @descargas = DescargaBauxita.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @descargas }
    end
  end

  # GET /descargas/1
  # GET /descargas/1.json
  def show
    @descarga = DescargaBauxita.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @descarga }
    end
  end

  # POST /descargas
  # POST /descargas.json
  def create
    @descarga = DescargaBauxita.new(params[:descarga])

    respond_to do |format|
      if @descarga.save
        format.html { redirect_to @descarga, notice: 'Descarga was successfully created.' }
        format.json { render json: @descarga, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @descarga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /descargas/1
  # PUT /descargas/1.json
  def update
    @descarga = DescargaBauxita.find(params[:id])

    respond_to do |format|
      if @descarga.update_attributes(params[:descarga])
        format.html { redirect_to @descarga, notice: 'Descarga was successfully updated.' }
        format.json { render json: @descarga }
      else
        format.html { render action: "edit" }
        format.json { render json: @descarga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descargas/1
  # DELETE /descargas/1.json
  def destroy
    @descarga = DescargaBauxita.find(params[:id])
    @descarga.destroy

    respond_to do |format|
      format.html { redirect_to descargas_url }
      format.json { head :no_content }
    end
  end
end
