class Admin::SeriesController < Admin::BaseAdminController
  def new
    @series = Series.new
  end

  def show
    @series = Series.find(params[:id])
    @episodes = @series.episodes.order(:season)
  end

  def create
    @series = Series.create(series_params)
    if @series.save
      @series.gather_episodes(params[:single_page])
      redirect_to admin_series_path(@series), notice: "Series was created, please check episode content shortly."
    else
      render :new, notice: "There was an error"
    end
  end

  def series_params
    params.require(:series).permit(:name, :seasons)
  end
end
