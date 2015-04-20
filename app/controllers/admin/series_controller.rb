class Admin::SeriesController < Admin::BaseAdminController

  def new
    @series = Series.new
  end

  def show
    @series = Series.find(params[:id])
  end

  def create
    @series = Series.create(series_params)
    if @series.save
      redirect_to admin_series_path(@series), notice: "Series was created, please check episode content"
    else
      render :new, notice: "There was an error"
    end

    # @wiki = WikiService.new
    # 1.upto(params[:series][:seasons].to_i) do |season|
    #   title = "#{params[:series][:name]} (season_#{season})"
    #   episode_content = @wiki.collect_data(title)

    # end
  end

  def series_params
    params.require(:series).permit(:name, :seasons)
  end
end
