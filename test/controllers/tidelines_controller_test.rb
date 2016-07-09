require 'test_helper'

class TidelinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tideline = tidelines(:one)
  end

  test "should get index" do
    get tidelines_url, as: :json
    assert_response :success
  end

  test "should create tideline" do
    assert_difference('Tideline.count') do
      post tidelines_url, params: { tideline: { lat: @tideline.lat, lon: @tideline.lon, name: @tideline.name, swell_direction: @tideline.swell_direction, tide: @tideline.tide, wave_length: @tideline.wave_length, wind: @tideline.wind } }, as: :json
    end

    assert_response 201
  end

  test "should show tideline" do
    get tideline_url(@tideline), as: :json
    assert_response :success
  end

  test "should update tideline" do
    patch tideline_url(@tideline), params: { tideline: { lat: @tideline.lat, lon: @tideline.lon, name: @tideline.name, swell_direction: @tideline.swell_direction, tide: @tideline.tide, wave_length: @tideline.wave_length, wind: @tideline.wind } }, as: :json
    assert_response 200
  end

  test "should destroy tideline" do
    assert_difference('Tideline.count', -1) do
      delete tideline_url(@tideline), as: :json
    end

    assert_response 204
  end
end
