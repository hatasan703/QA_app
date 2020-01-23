class UsersController < ApplicationController

before_action :redirect_top, except: :show
before_action :only_current_user, except: :show
before_action :set_user

  def my_question
    @questions = @user.questions.page(params[:page]).order("created_at DESC")
  end

  def my_answer
    @answers = @user.answers.page(params[:page]).order("created_at DESC")
  end

  def edit
  end

  def update

    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to action: :show
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end

    else
        redirect_to root_url
    end

  end

  def show
    @user_sex = @user.sex
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :sex, :bio, :age, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
