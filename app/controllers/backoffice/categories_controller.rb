class Backoffice::CategoriesController < ApplicationController
	before_action :authenticate_admin!

	layout "backoffice"
	
  def index
  	@categories = Category.all.order(:description)
  end
end
