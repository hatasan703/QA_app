class UsersController < ApplicationController

before_action :redirect_top, except: :show
before_action :only_current_user, except: :show

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
    @verifie = "未提出"
    if @user.connect_id.present?
        stripe_account = Stripe::Account.retrieve(@user.connect_id)
        @postal = stripe_account.individual.address_kana.postal_code
        @state = stripe_account.individual.address_kanji.state
        @city = stripe_account.individual.address_kanji.city
        @town = stripe_account.individual.address_kanji.town
        @line1 = stripe_account.individual.address_kanji.line1
        @line2 = stripe_account.individual.address_kanji.line2

        @state_kana = stripe_account.individual.address_kana.state
        @city_kana = stripe_account.individual.address_kana.city
        @town_kana = stripe_account.individual.address_kana.town
        @line1_kana = stripe_account.individual.address_kana.line1
        @line2_kana = stripe_account.individual.address_kana.line2

        @first_name = stripe_account.individual.first_name_kanji
        @last_name = stripe_account.individual.last_name_kanji
        @first_name_kana = stripe_account.individual.first_name_kana
        @last_name_kana = stripe_account.individual.last_name_kana

        @day = stripe_account.individual.dob.day
        @month = stripe_account.individual.dob.month
        @year = stripe_account.individual.dob.year
        phone = stripe_account.individual.phone
        @phone = phone.sub("+81","0")
        @email = stripe_account.individual.email
        # binding.pry
        @gender = stripe_account.individual.gender
        if stripe_account.individual.verification.status == "verified"
            @verifie = "本人確認済み"
        end
    end
    # binding.pry
  end

  def create_identification
    if current_user.connect_id.nil? || current_user.connect_id.empty?
    account = Stripe::Account.create({
        country: 'JP',
        type: 'custom',
        business_type: 'individual',
        individual: {
            address_kanji: {
                postal_code: params[:postal],
                state: params[:state],
                city: params[:city],
                town: params[:town],
                line1: params[:line1],
                line2: params[:line2],
            },
            address_kana: {
                postal_code: params[:postal],
                state: params[:state_kana],
                city: params[:city_kana],
                town: params[:town_kana],
                line1: params[:line1_kana],
                line2: params[:line2_kana],
            },

            dob: {
                day: params[:day],
                month: params[:month],
                year: params[:year],
            },

            first_name_kanji: params[:first_name],
            last_name_kanji: params[:last_name],
            first_name_kana: params[:first_name_kana],
            last_name_kana: params[:last_name_kana],
            gender: params[:gender],
            phone: "+81 " + params[:phone_number],
            email: params[:email],
        },
    })

    current_user.update(connect_id: account[:id])

    verification_document = Stripe::FileUpload.create(
        {
          purpose: 'identity_document',
          file: File.new(params[:id_file_front].tempfile)
        },
        {
          stripe_account: current_user.connect_id
        }
      )

      verification_document_back = Stripe::FileUpload.create(
        {
          purpose: 'identity_document',
          file: File.new(params[:id_file_back].tempfile)
        },
        {
          stripe_account: current_user.connect_id
        }
      )
      account.individual.verification.document.front = verification_document.id
      account.individual.verification.document.back = verification_document_back.id
# binding.pry

    else
        account = Stripe::Account.retrieve(current_user.connect_id)
        account.individual.address_kana.postal_code = params[:postal]
        account.individual.address_kanji.state = params[:state]
        account.individual.address_kanji.city = params[:city]
        account.individual.address_kanji.town = params[:town]
        account.individual.address_kanji.line1 = params[:line1]
        account.individual.address_kanji.line2 = params[:line2]

        account.individual.address_kana.state = params[:state_kana]
        account.individual.address_kana.city = params[:city_kana]
        account.individual.address_kana.town = params[:town_kana]
        account.individual.address_kana.line1 = params[:line1_kana]
        account.individual.address_kana.line2 =params[:line2_kana]

        account.individual.first_name_kanji = params[:first_name]
        account.individual.last_name_kanji = params[:last_name]
        account.individual.first_name_kana = params[:first_name_kana]
        account.individual.last_name_kana = params[:last_name_kana]

        account.individual.dob.day = params[:day]
        account.individual.dob.month = params[:month]
        account.individual.dob.year = params[:year]
        account.individual.phone = "+81 " + params[:phone_number]
        account.individual.email = params[:email]
        account.individual.gender = params[:gender]
    end
    # binding.pry
    account.save

      # アップロードされたドキュメントのID番号

    current_user.update(connect_id: account[:id])
    @user = User.find(params[:id])

    # binding.pry

    # account.save
    redirect_to controller: 'users', action: 'identification', id: @user.id
  end

  def bank
    @user = User.find(params[:id])
    if current_user.connect_id.present?
    stripe_account = Stripe::Account.retrieve(@user.connect_id)
        if stripe_account.external_accounts.data.present?
            @bank_account = stripe_account.external_accounts.data

            @bank_name = stripe_account.external_accounts.data[0]
            @bank_code = stripe_account.external_accounts.data[0].routing_number.slice(0..3)
            @code = stripe_account.external_accounts.data[0].routing_number.slice(4..6)
        end
    end


  end

  def create_bank
    @user = User.find(params[:id])
    # binding.pry
    if current_user.connect_id.present?
        stripe_account = Stripe::Account.retrieve(@user.connect_id)

        Stripe::Account.update(
            @user.connect_id,
            {
              tos_acceptance: {
                date: Time.now.to_i,
                ip: request.remote_ip, # Assumes you're not using a proxy
              },
            }
          )

        # unless stripe_account.external_accounts.data.present?
            # 銀行口座作成
            bank_account = Stripe::Account.create_external_account(@user.connect_id,
                {

                    external_account: {
                            object: "bank_account",
                            # account_holder_type: "individual",
                            routing_number: "1100000", #テスト環境
                            # routing_number: params[:bank_code] + params[:code], #銀行コード+支店コード
                            account_number: "00012345", #テスト環境
                            # account_number: params[:account_number],
                            # bank_name: params[:bank_name],
                            account_holder_name: params[:last_name] + " #{params[:first_name]}",
                            currency: 'jpy',
                            country: 'JP',
                    },

                        }
                )
        # end

        # binding.pry
    end

    redirect_to controller: 'users', action: 'bank', id: @user.id
  end

  def point
    @user = User.find(params[:id])
  end

  def payout_confirmation
    @user = User.find(params[:id])
  end

  def payout_point
    @user = User.find(params[:id])
    transfer = Stripe::Transfer.create({
      amount: @user.money,
      currency: 'jpy',
      destination: @user.connect_id,
      # transfer_group: 'ORDER_95',
    })

    payout = Stripe::Payout.create({
        amount: @user.money,
        currency: 'jpy',
        # source_type: "card",
        # source_type: 'bank_account',
      }, {stripe_account: @user.connect_id})

      current_user.update(money: 0)
      # binding.pry
    redirect_to controller: 'users', action: 'point', id: @user.id, notice: '振込が完了しました'
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :sex, :bio, :age, :role)
  end

end
