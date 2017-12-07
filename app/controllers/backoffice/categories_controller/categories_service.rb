class Backoffice::CategoriesController::CategoriesService
	attr_accessor :category

	def self.create(params_category)
		@category = Category.new(params_category)

		if @Category.valid?
			@category.save!
		end		

		@category
	end
end