Rails.configuration.stripe = {
    :publishable_key => Rails.application.credentials.stripe[:publishable_key],#stipeのページに行って自分のアカウントから取ってくる
    :secret_key      => Rails.application.credentials.stripe[:secret_key]
  }

  Stripe.api_key = Rails.configuration.stripe[:secret_key]
