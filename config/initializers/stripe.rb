# Rails.configuration.stripe = {
#     :publishable_key => Rails.application.credentials.stripe[:publishable_key],#stipeのページに行って自分のアカウントから取ってくる
#     :secret_key      => Rails.application.credentials.stripe[:secret_key]
#   }

#   Stripe.api_key = Rails.configuration.stripe[:secret_key]



  Rails.configuration.stripe = {
    # case Rails.env
    # when 'development'
    #     :publishable_key => Rails.application.credentials.stripe[:stripe_publishable_key_test],#stipeのページに行って自分のアカウントから取ってくる
    #     :secret_key      => Rails.application.credentials.stripe[:stripe_secret_key_test]
    # when 'production'
        publishable_key: Rails.application.credentials.stripe[:stripe_publishable_key],#stipeのページに行って自分のアカウントから取ってくる
        secret_key: Rails.application.credentials.stripe[:stripe_secret_key]
    # end

  }

  Stripe.api_key = Rails.configuration.stripe[:secret_key]
