class ValidatesController < ApplicationController
  # GET /validates
  # GET /validates.json
  def index
    @validates = Validate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @validates }
    end
  end

  # GET /validates/1
  # GET /validates/1.json
  def show
    @validate = Validate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @validate }
    end
  end

  # GET /validates/new
  # GET /validates/new.json
  def new
    unless params[:product_id]
      render :text => 'no product?'
      return
    end
    @validate = Validate.new
    @validate.product_id = params[:product_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @validate }
    end
  end

  # GET /validates/1/edit
  def edit
    @validate = Validate.find(params[:id])
  end

  # POST /validates
  # POST /validates.json
  def create
    @validate = Validate.new(params[:validate])

    respond_to do |format|
      if @validate.save
        format.html { redirect_to @validate, notice: 'Validate was successfully created.' }
        format.json { render json: @validate, status: :created, location: @validate }
      else
        format.html { render action: "new" }
        format.json { render json: @validate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /validates/1
  # PUT /validates/1.json
  def update
    @validate = Validate.find(params[:id])

    respond_to do |format|
      if @validate.update_attributes(params[:validate])
        format.html { redirect_to @validate, notice: 'Validate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @validate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validates/1
  # DELETE /validates/1.json
  def destroy
    @validate = Validate.find(params[:id])
    @validate.destroy

    respond_to do |format|
      format.html { redirect_to validates_url }
      format.json { head :no_content }
    end
  end
end
