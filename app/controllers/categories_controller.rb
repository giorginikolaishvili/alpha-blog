class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index,:show]
    def new
        @category=Category.new
    end

    def index
        @categories=Category.paginate(page: params[:page],per_page:3)
    end
    
    def show
        @category=Category.find(params[:id])
        @category_articles=@category.articles.paginate(page: params[:page],per_page:4)
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
    def require_admin
        if !logged_in?|| (logged_in? && !current_user.admin?)
            flash[:danger]="only admin can do that"
            redirect_to categories_path
        end

    end
end