class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: "You've been subscribed."
    else
      redirect_to root_path, notice: 'There was an error while creating the subscription.'
    end
  end

  def destroy
    @subscription = Subscription.find_by(email_address: subscription_params["email_address"])
    binding.pry
    @subscription.destroy
    redirect_to admin_subscriptions_path, notice: 'Subscription was successfully destroyed.'
  end

  def unsubscribe
    @subscription = Subscription.new
  end

  private
    def subscription_params
      params.require(:subscription).permit(:name, :email_address)
    end
end
