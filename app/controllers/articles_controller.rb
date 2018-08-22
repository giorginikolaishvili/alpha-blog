class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show,:index]
  before_action :require_same_user, only: [:edit,:update,:destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2 )
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article Updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def create
    @article = Article.new(article_params)
    @article.user=current_user
    if @article.save
      flash[:success] = "Article Created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article destroyed"
    redirect_to articles_path
  end
  def search
    @result=params[:res]
    Article.all.each do |article|
      if   article.title==@result
        redirect_to article_path(article.id)
        return
      end
    end
        flash[:error]="Cant find article with name #{@result}"
        redirect_to root_path
end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
  def require_same_user
    if current_user!=@article.user
      flash[:danger]="You can't edit or delete other's articles"
      redirect_to root_path
  end
end
end