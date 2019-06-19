class CategoriesController < ApplicationController
	before_action :authenticate_user!, except:[:index, :show]
	before_action :set_category, only:[:show, :edit, :update, :destroy]

	def index
		@categories = Category.all.order('created_at DESC')
	end

	def new
		@category = current_user.categories.build
	end

	def create
		@category = current_user.categories.build(category_params)
		if @category.save
			redirect_to category_path(@category), notice:'Category was succesfully created.'
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @category.update(category_params)
			redirect_to category_path(@category), notice:'Category was succesfully updated.'
		else
			render 'edit'
		end
	end

	def destroy
		@category.destroy
		redirect_to @category
	end

	private
	def category_params
		params.require(:category).permit(:user_id, :name, :description, :avatar)
	end

	def set_category
		@category = Category.find(params[:id])
	end
	
end
