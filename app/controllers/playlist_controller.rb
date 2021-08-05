class PlaylistController < ApplicationController
  before_action :flag

  def index
    if @current_user
      @playlists = Playlist.where(user_id: @current_user.id)
    else
      @playlists
    end
  end

  def detail
    @flag = true
    @playlist = Playlist.find_by(id: params[:id])
    @videos = Video.where(playlistId: params[:id])
  end

  def new
    @playlist = Playlist.new
    @flag = true
  end

  def create
    @flag = true
    @playlist = Playlist.new(
      name: params[:name],
      description: params[:description],
      user_id: @current_user.id,
    )
    @playlists
    if @playlist.save
      flash[:notice] = @playlist.name + "を作成しました"
      redirect_to("/")
    else
      render("playlist/new.html.erb")
    end
  end

  def delete
    @playlist = Playlist.find_by(id: params[:id])
    if @playlist.destroy
      flash[:notice] = @playlist.name + "を削除しました"
      redirect_to("/")
    end
  end

  def register
    @video = Video.new(
      videoId: params[:video_id],
      playlistId: params[:playlist_id],
    )
    if @video.save
      redirect_to("/")
    end
  end

  def autoplay
    @flag = true
    @playlist = Playlist.find_by(id: params[:id])
    @videos = Video.where(playlistId: params[:id])
    @index = 0
    @count = 0
  end
end
