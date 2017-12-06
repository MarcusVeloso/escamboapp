class Backoffice::AdminsController < BackofficeController
  	before_action :set_admin, only: [:edit, :update]

  def index
  	@admins = Admin.all.order(:email)
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

  private 

  def set_admin
  	@admin = Admin.find(params[:id])  	
  end

  def params_admin
  	params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
