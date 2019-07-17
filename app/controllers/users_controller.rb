class UsersController < ApplicationController

before_action :redirect_top, except: [:my_question, :my_answer]

  def my_question
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page]).order("created_at DESC")
  end

  def my_answer
    @user = User.find(params[:id])
    @answers = @user.answers.page(params[:page]).order("created_at DESC")
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
        redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])

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
    @user = User.find(params[:id])
    @user_sex = @user.sex
  end


  def identification
    @user = User.find(params[:id])
    unless @user == current_user
        redirect_to root_path
    end
  end

  def card
    @user = User.find(params[:id])
    unless @user == current_user
        redirect_to root_path
    end
  end

  def point
    @user = User.find(params[:id])
    unless @user == current_user
        redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :sex, :bio, :age, :role)
  end

end
