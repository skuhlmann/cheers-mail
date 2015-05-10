class Admin::SubscriptionsController < Admin::BaseAdminController

  def index
    @subscriptions = Subscription.all.includes(:series)
    @subscription = Subscription.new
    @series = Series.order(:name)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.series_ids = params[:series_ids]
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

  def weekly_email
    set_subscription
    EpisodeMailer.weekly_episode_email(@subscription).deliver
    redirect_to admin_subscriptions_path, notice: 'Email sent'
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:name, :email_address)
    end
end
