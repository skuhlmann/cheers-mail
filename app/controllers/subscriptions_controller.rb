class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)
    add_series(params, @subscription)
    if @subscription.save && @subscription.series.present?
      WelcomeMailer.new_subscription_email(@subscription).deliver
      redirect_to root_path, notice: "You've been subscribed."
    elsif @subscription.save && @subscription.series.blank?
      redirect_to root_path, notice: "You've been subscribed. We are trying to find that series for you."
    else
      redirect_to root_path, notice: 'There was an error while creating the subscription.'
    end
  end

  def destroy
    @subscription = Subscription.find_by(email_address: subscription_params["email_address"])
    unless @subscription == nil
      @subscription.destroy
      redirect_to root_path, notice: "You've been unsubscribed."
    else
      redirect_to unsubscribe_path, notice: "The email address provided is not currently subscribed."
    end
  end

  def unsubscribe
    @subscription = Subscription.new
  end

  private
    def subscription_params
      params.require(:subscription).permit(:name, :email_address)
    end

    def add_series(params, subscription)
      subscription.series_ids = params[:series_ids]
      unless params[:series_request] == ""
        request = SeriesRequest.new
        request.subscription = subscription
        request.name = params[:series_request]
      end
    end
end
