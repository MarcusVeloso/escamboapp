class Backoffice::CategoriesController < BackofficeController	
  def index
  	@categories = Category.all.order(:description)
  end
end