class EnvironmentsController < ApplicationController
  before_action :set_environment, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:my_environments, :refresh]
  # GET /environments
  # GET /environments.json
  def index
    @environment = Environment.all
  end

  # GET /environments/1
  # GET /environments/1.json
  def show
  end

  # GET /environments/new
  def new
    @environment = Environment.new
  end

  def my_environments
    @environment = current_user.environments
  end
  # GET /environments/1/edit
  def edit
  end

  # POST /environments
  # POST /environments.json
  def create
    @user = current_user
    @environment = @user.environments.create(environment_params)

    respond_to do |format|
      if @environment.save
        format.html { redirect_to root_path, notice: 'Environment was successfully created.' }
        format.json { render :show, status: :created, location: @environment }
      else
        format.html { render :new }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environments/1
  # PATCH/PUT /environments/1.json
  def update
    respond_to do |format|
      if @environment.update(environment_params)
        format.html { redirect_to root_path, notice: 'Environment was successfully updated.' }
        format.json { render :show, status: :ok, location: @environment }
      else
        format.html { render :edit }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    @environment.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def refresh
    @environment = Environment.find(params[:id])	
     if system("touch /var/www/demo-requests/#{@environment.servername}-`date +%m.%d.%Y`") 
	flash[:notice] = "Refresh of #{@environment.servername}  started"
    	redirect_to root_path
     else
    	flash[:danger] = "Could not start refresh"
   	redirect_to root_path
     end
end

end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environment_params
      params.require(:environment).permit(:servername, :location, :user_id, :status)
    end
   def require_admin
    if !user_signed_in? || (user_signed_in? and !current_user.admin?)
      flash[:danger] = "only admins can perform that action"
      redirect_to root_path
    end
   end

