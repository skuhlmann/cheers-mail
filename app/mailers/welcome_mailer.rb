class WelcomeMailer < ActionMailer::Base
  default from: "sam@example.com"

  def new_subscription_email(subscription)
    @subscription = subscription
    @episode = subscription.random_episode

    mail(to: @subscription.email_address,
         subject: "You've signed up for Do You Remember That One Episode?")
  end
end
