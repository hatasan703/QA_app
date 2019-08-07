class ArticlesController < ApplicationController

    load_and_authorize_resource except: :show

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

    def destroy
        article = Article.find(params[:id])
        # binding.pry
        article.destroy if current_user.try(:admin?)
        redirect_to root_path
    end

    # def edit
    #     article = Article.find(params[:id])
    #     article.destroy if current_user.try(:admin?)
    # end

    def edit
        @article = Article.find(params[:id])
        # binding.pry
    end

    def update
        @article = Article.find(params[:id])

        # adminユーザーかどうか判定
        if current_user.try(:admin?)

          if @article.update(article_params)
            redirect_to action: :show
          else
            flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
            render :edit
          end

        else
            redirect_to root_url
        end

        end

    def confirm
        @article = Article.new(article_params)
    end

    private

    def article_params
        params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
    end

end
