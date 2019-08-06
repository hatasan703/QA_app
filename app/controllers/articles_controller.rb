class ArticlesController < ApplicationController

    def index
    end

    def new
      @article = Article.new
      @title = params[:title]
      @text = params[:text]
    end

    def create
        article = Article.new(article_params)
        article.save
        redirect_to controller: 'articles', action: 'show', id: article.id
    end

    def show
        @article = Article.find(params[:id])
    end

    def confirm
        @article = Article.new(article_params)
    end

    private

    def article_params
        params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
    end

end
