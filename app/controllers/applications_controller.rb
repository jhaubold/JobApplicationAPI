class ApplicationsController < ApplicationController

http_basic_authenticate_with :name => "megorei", :password => "megorei", :except => :create

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.json
  def create

    userparams = params[:application].delete(:user)
    @user = User.find_by_email_and_token!(userparams[:user][:email],userparams[:user][:token])
    # TODO: fail wenn user leer
    @application = Application.new(params[:application])
    userparams[:user].each_key {
      |key|
      # TODO: ins Model verfrachten dass id, email und Token nicht geändert werden können
      @user[key] = userparams[:user][key] if key != :email && key != :token
    }
    @application.user_id = @user.id
    respond_to do |format|
      if @user.save && @application.save
        # send confirmation mail
        ApplicationMailer.thanks_for_application(@user).deliver
        # send info mail to megorei
        ApplicationMailer.new_application(@application).deliver

        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.xml { render xml: @application, status: :created, location: @application }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render action: "new", notice: 'Alles im Eimer' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @application, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end
end
