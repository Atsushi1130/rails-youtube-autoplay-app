class YoutubeController < ApplicationController
  before_action :flag

  def find_videos(keyword)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = 'API-KEY'

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 3,
      order: :relevance,
      page_token: next_page_token,
    }
    service.list_searches(:snippet, opt)
  end

  def search
    @youtube_data = find_videos(params[:keyword])
    if @current_user
      @playlists = Playlist.where(user_id: @current_user.id)
    else
      @playlists = nil
    end
    @flag = true
    @index = 0
  end

  def delete
    @playlist = Playlist.find_by(id: params[:playlist_id])
    @video = Video.find_by(id: params[:id])
    if @video.destroy
      flash[:notice] = "削除が完了しました"
      redirect_to("/playlist/#{@playlist.id}/detail")
    end
  end
end
