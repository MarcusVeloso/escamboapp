class Backoffice::AdminsController < BackofficeController
  	before_action :set_admin, only: [:edit, :update, :destroy]
    after_action :verify_authorized, only: :new
    after_action :verify_policy_scoped, only: :index

  def index
  	# @admins = Admin.all.order(:email)
    # @admins = Admin.with_restricted_access
    # @admins = Admin.with_full_access    
    @admins = policy_scope(Admin)
  end

  def new
  	@admin = Admin.new
    authorize @admin
  end

  def create
  	@admin = Admin.new(params_admin)
  	if @admin.save
  		redirect_to backoffice_admins_path,
  					notice: I18n.t('messages.created_with', item: @admin.name)
  	else
  		render :new
  	end
  end

  def edit  	
  end

  def update
    pwd = params[:admin][:password]
    pwd_confirmation = params[:admin][:password_confirmation]

    if pwd.blank? && pwd_confirmation.blank?
        params[:admin].delete(:password)
        params[:admin].delete(:password_confirmation)
    end

  	if @admin.update_attributes(params_admin) 
  		redirect_to backoffice_admins_path,  					
  					notice: I18n.t('messages.updated_with', item: @admin.name)
  	else
  		render :edit		
  	end
  end

  def destroy
    admin_name = @admin.name
    if @admin.destroy
        redirect_to backoffice_admins_path,
              notice: I18n.t('messages.destroyed_with', item: @admin.name)
    else
      render :index
    end    
  end

  private 

  def set_admin
  	@admin = Admin.find(params[:id])  	
  end

  def params_admin
  	params.require(:admin).permit(:name,:email, :password, :password_confirmation)
  end
end