class RejectsController < ApplicationController
  # GET /rejects
  # GET /rejects.json
  def index
    @rejects = Reject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rejects }
    end
  end

  # GET /rejects/1
  # GET /rejects/1.json
  def show
    @reject = Reject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reject }
    end
  end

  # GET /rejects/new
  # GET /rejects/new.json
  def new
    unless params[:product_id]
      render :text => 'no product?'
      return
    end
    @reject = Reject.new
    @reject.product_id = params[:product_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reject }
    end
  end

  # GET /rejects/1/edit
  def edit
    @reject = Reject.find(params[:id])
  end

  # POST /rejects
  # POST /rejects.json
  def create
    @reject = Reject.new(params[:reject])

    respond_to do |format|
      if @reject.save
        format.html { redirect_to @reject, notice: 'Reject was successfully created.' }
        format.json { render json: @reject, status: :created, location: @reject }
      else
        format.html { render action: "new" }
        format.json { render json: @reject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rejects/1
  # PUT /rejects/1.json
  def update
    @reject = Reject.find(params[:id])

    respond_to do |format|
      if @reject.update_attributes(params[:reject])
        format.html { redirect_to @reject, notice: 'Reject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rejects/1
  # DELETE /rejects/1.json
  def destroy
    @reject = Reject.find(params[:id])
    @reject.destroy

    respond_to do |format|
      format.html { redirect_to rejects_url }
      format.json { head :no_content }
    end
  end
end
