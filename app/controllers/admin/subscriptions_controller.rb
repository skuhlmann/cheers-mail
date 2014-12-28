class Admin::SubscriptionsController < Admin::BaseAdminController

  def index
    @subscriptions = Subscription.all
    @subscription = Subscription.new
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to admin_subscriptions_path, notice: 'Subscription was successfully created.'
    else
      redirect_to admin_subscriptions_path, notice: 'There was an error while creating the subscription.'
    end
  end

  def destroy
    set_subscription
    @subscription.destroy
    redirect_to admin_subscriptions_path, notice: 'Subscription was successfully destroyed.'
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:name, :email_address)
    end
end
