class Backoffice::AdminsController < BackofficeController
  	before_action :set_admin, only: [:edit, :update, :destroy]

  def index
  	# @admins = Admin.all.order(:email)
    @admins = Admin.with_full_access
    # @admins = Admin.with_restricted_access
  end

  def new
  	@admin = Admin.new
  end

  def create
  	@admin = Admin.new(params_admin)
  	if @admin.save
  		redirect_to backoffice_admins_path,
  					notice: "Administrador: #{@admin.email}, criado com sucesso!"
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
  					notice: "Administrador: #{@admin.email}, alterado com sucesso!"
  	else
  		render :edit		
  	end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
        redirect_to backoffice_admins_path,
                    notice: "Administrador: #{admin_email}, removido com sucesso!"
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