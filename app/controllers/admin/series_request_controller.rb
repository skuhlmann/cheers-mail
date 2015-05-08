class Admin::SeriesRequestController < Admin::BaseAdminController

  def update
    @request = SeriesRequest.find(params[:id])
    if @request.update(fulfilled: true)
      redirect_to admin_index_path, notice: "Series request for #{@request.subscription.email_address} marked as fullfilled"
    else
      redirect_to admin_index_path, notice: "There was an error"
    end
  end
end
