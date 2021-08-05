require "test_helper"

class YoutubeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get youtube_index_url
    assert_response :success
  end
end
