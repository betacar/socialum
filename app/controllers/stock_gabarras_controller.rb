class StockGabarrasController < ApplicationController
  # GET /stock_gabarras
  # GET /stock_gabarras.xml
  def index
    @stock_gabarras = StockGabarra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stock_gabarras }
    end
  end

  # GET /stock_gabarras/1
  # GET /stock_gabarras/1.xml
  def show
    @stock_gabarra = StockGabarra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock_gabarra }
    end
  end

  # GET /stock_gabarras/new
  # GET /stock_gabarras/new.xml
  def new
    @stock_gabarra = StockGabarra.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stock_gabarra }
    end
  end

  # GET /stock_gabarras/1/edit
  def edit
    @stock_gabarra = StockGabarra.find(params[:id])
  end

  # POST /stock_gabarras
  # POST /stock_gabarras.xml
  def create
    @stock_gabarra = StockGabarra.new(params[:stock_gabarra])

    respond_to do |format|
      if @stock_gabarra.save
        flash[:notice] = 'StockGabarra was successfully created.'
        format.html { redirect_to(@stock_gabarra) }
        format.xml  { render :xml => @stock_gabarra, :status => :created, :location => @stock_gabarra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stock_gabarra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stock_gabarras/1
  # PUT /stock_gabarras/1.xml
  def update
    @stock_gabarra = StockGabarra.find(params[:id])

    respond_to do |format|
      if @stock_gabarra.update_attributes(params[:stock_gabarra])
        flash[:notice] = 'StockGabarra was successfully updated.'
        format.html { redirect_to(@stock_gabarra) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock_gabarra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_gabarras/1
  # DELETE /stock_gabarras/1.xml
  def destroy
    @stock_gabarra = StockGabarra.find(params[:id])
    @stock_gabarra.destroy

    respond_to do |format|
      format.html { redirect_to(stock_gabarras_url) }
      format.xml  { head :ok }
    end
  end
end
