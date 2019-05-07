class UsersController < ApplicationController

  def my_question
    user = current_user.id
    @user = User.find(user)
    @questions = @user.questions.page(params[:page]).per(5).order("created_at DESC")
  end

  def my_answer
    user = current_user.id
    @user = User.find(user)
    @answers = @user.answers.page(params[:page]).per(5).order("created_at DESC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user

      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to root_path
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end

    else
        redirect_to root_url
    end

    end


  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :sex, :bio, :age)
  end

end
