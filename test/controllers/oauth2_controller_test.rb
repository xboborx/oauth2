require 'test_helper'

class Oauth2ControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get welcome" do
    get :welcome
    assert_response :success
  end

end
