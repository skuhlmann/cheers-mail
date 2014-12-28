class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to root_path, notice: "You've been subscribed."
    else
      redirect_to root_path, notice: 'There was an error while creating the subscription.'
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:name, :email_address)
    end


end
