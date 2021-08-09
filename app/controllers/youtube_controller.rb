class YoutubeController < ApplicationController
  before_action :flag
  before_action :remain_search_keyword

  def find_videos(keyword)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = 'API-KEY'

    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 6,
      order: :relevance,
      page_token: next_page_token,
    }
    service.list_searches(:snippet, opt)
  end

  def search
    @youtube_data = find_videos(params[:keyword]).items
    @kaminari_data = Kaminari.paginate_array(@youtube_data).page(params[:page]).per(2)
    if @current_user
      @playlists = Playlist.where(user_id: @current_user.id)
      if @playlists.length == 0
        @playlists = nil
      end
    else
      @playlists = nil
    end
    @flag = true
    @index = 0
    @count = 0
  end

  def test
    @youtube_data = find_videos(params[:keyword])
    if @current_user
      @playlists = Playlist.where(user_id: @current_user.id)
      if @playlists.length == 0
        @playlists = nil
      end
    else
      @playlists = nil
    end
    @flag = true
    @index = 0
    @count = 0
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
