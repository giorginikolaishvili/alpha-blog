class CategoriesController < ApplicationController
    def new
        @category=Category.new
    end

    def index
        @categories=Category.paginate(page: params[:page],per_page:3)
    end
    
    def show
    end
    def create
        @category=Category.new(set_params)
        if @category.save
            flash[:success]="category created"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    private
    def set_params
        params.require(:category).permit(:name)
    end
end