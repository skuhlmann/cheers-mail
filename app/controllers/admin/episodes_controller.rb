class Admin::EpisodesController < Admin::BaseAdminController

  def edit
    @episode = Episode.find(params[:id])
  end

  def update
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      redirect_to admin_series_path(@episode.series), notice: 'Episode was updated.'
    else
      render :edit
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:summary)
  end

end
