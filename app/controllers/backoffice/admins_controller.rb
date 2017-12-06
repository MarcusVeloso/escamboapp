class Backoffice::AdminsController < BackofficeController
  	before_action :set_admin, only: [:edit, :update]

  def index
  	@admins = Admin.all.order(:email)
  end

  private 

  def set_admin
  	@admin = Admin.find(params[:id])  	
  end

  def params_admin
  	params.require(:admin).permit(:email)
  end
end
