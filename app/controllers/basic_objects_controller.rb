class BasicObjectsController < ApplicationController
  # GET /basic_objects
  # GET /basic_objects.xml
  def index
    @basic_objects = BasicObject.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @basic_objects }
    end
  end

  # GET /basic_objects/1
  # GET /basic_objects/1.xml
  def show
    @basic_object = BasicObject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @basic_object }
    end
  end

  # GET /basic_objects/new
  # GET /basic_objects/new.xml
  def new
    @basic_object = BasicObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @basic_object }
    end
  end

  # GET /basic_objects/1/edit
  def edit
    @basic_object = BasicObject.find(params[:id])
  end

  # POST /basic_objects
  # POST /basic_objects.xml
  def create
    @basic_object = BasicObject.new(params[:basic_object])

    respond_to do |format|
      if @basic_object.save
        flash[:notice] = 'Object was successfully created.'
        format.html { redirect_to(@basic_object) }
        format.xml  { render :xml => @basic_object, :status => :created, :location => @basic_object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @basic_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /basic_objects/1
  # PUT /basic_objects/1.xml
  def update
    @basic_object = BasicObject.find(params[:id])

    respond_to do |format|
      if @basic_object.update_attributes(params[:basic_object])
        flash[:notice] = 'Object was successfully updated.'
        format.html { redirect_to(@basic_object) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @basic_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /basic_objects/1
  # DELETE /basic_objects/1.xml
  def destroy
    @basic_object = BasicObject.find(params[:id])
    @basic_object.destroy

    respond_to do |format|
      format.html { redirect_to(basic_objects_url) }
      format.xml  { head :ok }
    end
  end
end
