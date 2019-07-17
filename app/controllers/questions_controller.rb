class QuestionsController < ApplicationController

before_action :redirect_top, only: [:new, :confirm, :create, :destroy]

  impressionist unique: [:session_hash]

  def new
    @question = Question.new
    @categories = Category.all
    @title = params[:title]
    @text = params[:text]
    @category_id = params[:category_id]
    @point = params[:point]
    # binding.pry
  end

  def confirm
    @question = Question.new(question_params)
    redirect_to action: 'new' if @question.invalid?
  end

  def create

    @question = Question.new(question_params)
    @categories = Category.all
        if params[:back]
          render :new
        elsif @question.save
                         # stripe決済
       # Amount in cents
       @amount = @question.point #引き落とす金額
       ###この操作で、Stripe から帰ってきた情報を取得します
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail], #emailは暗号化されずに受け取れます
          :source  => params[:stripeToken] #めちゃめちゃな文字列です
        )

        ###この操作で、決済をします
        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Rails Stripe customer',
          :currency    => 'jpy'
        )
        #  rescue Stripe::CardError => e
        #     flash[:error] = e.message
        #     redirect_to action: "show"
        #  end

            redirect_to controller: 'questions', action: 'show', id: @question.id
        else
            render :new
        end





  end

  def destroy
    question = Question.find(params[:id])
    @answers = question.answers.includes(:user)
    if @answers.empty?
      question.destroy if question.user_id == current_user.id
    end
    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    impressionist(@question, nil, :unique => [:session_hash])

    @answer = Answer.new
    @all_answers = @question.answers.includes(:user)
    @answers = @all_answers.where(best_answer: nil).order("created_at DESC")
    @best_answer = @all_answers.find_by(best_answer: true)

    @is_questioner = false
    @answerable = true # TODO: 変数名は後で直す
    if current_user != nil
      @is_questioner = current_user.id == @question.user_id
      @answerable  = @all_answers.exists?(user_id: current_user.id)
    end
    @resolved = @question.done.present?
  end
# Question.includes(:user).page(params[:page]).per(5).order("created_at DESC")

  # ランキング
  def ranking
    @resolved_questions = Question.where(done: true)
    @questions = @resolved_questions.page(params[:page]).per(10).order('impressions_count DESC')
  end

  def ranking_open
    @open_questions = Question.where(done: nil)
    @questions = @open_questions.page(params[:page]).per(10).order('impressions_count DESC')
  end

  # 回答受付中
  def open
    @questions = Question.where(done: nil).page(params[:page]).per(10).order('created_at DESC')
  end

  def open_pv
    @questions = Question.where(done: nil).page(params[:page]).per(10).order('impressions_count DESC')
  end


  def open_point
    @questions = Question.where(done: nil).page(params[:page]).per(10).order('point DESC')
  end


  private

  def question_params
    params.require(:question).permit(:title, :text, :category_id, :point).merge(user_id: current_user.id)
  end

  def revive_active_record(arr)
    arr.first.class.where(id: arr.map(&:id))
  end

end
