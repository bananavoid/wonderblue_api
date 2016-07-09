class TidelinesController < ApplicationController
  before_action :set_tideline, only: [:show, :update, :destroy]

  # GET /tidelines
  def index
				if params[:lat].blank? || params[:lon].blank?
					render json: {message: 'lat and lon params required'}
				else
					surfline = (HTTParty.get("http://api.surfline.com/v1/forecasts/2169?resources=surf,analysis&days=7&getAllSpots=true&interpolate=false&showOptimal=true",
		    :headers => {"Accept" => 'application/json' ,  "Content-Type" => 'application/json' ,
							"Authorization" => "bearer 95683401d1ac7830467e74b4992adebca7141367c005463d9d2f237e13084f35"}))

					forecast = (HTTParty.get("https://api.forecast.io/forecast/c4f1d705d7250937a2decba12d532ecb/#{params[:lat]},#{params[:lon]}",
				    :headers => {"Accept" => 'application/json' ,  "Content-Type" => 'application/json' ,
									"Authorization" => "bearer 95683401d1ac7830467e74b4992adebca7141367c005463d9d2f237e13084f35"}))

					worldtides = (HTTParty.get("http://www.worldtides.info/api?heights&extremes&lat=#{params[:lat]}&lon=#{params[:lon]}&start=1467660952&step=5400&length=604800&key=714c07bf-b7b8-45a0-b440-f503d173fea4",
							:headers => {"Accept" => 'application/json' ,  "Content-Type" => 'application/json' ,
							"Authorization" => "bearer 95683401d1ac7830467e74b4992adebca7141367c005463d9d2f237e13084f35"}))

							extremes = worldtides.parsed_response['extremes']
							if surfline.code == 200
								render json: [
									spots:{
											id: surfline.first['id'],
											name: surfline.first['name'],
											lat: surfline.first['lat'],
											lon: surfline.first['lot'],
											wave_height: "#{surfline.first['Surf']['surf_min'][0][0]} - #{surfline.first['Surf']['surf_max'][0][0]}",
											swell_direction: surfline.first['Surf']['swell_direction1'][0][0]
									},
									conditions:
									{
										tide:{
											height:worldtides.parsed_response["heights"].last["height"],
											desc: "#{extremes.last['type']} - #{extremes[extremes.length - 1]['type']}"
										},
										wind:{
											speed: forecast.parsed_response['currently']['windSpeed'],
											bearing: forecast.parsed_response['currently']['windBearing']
										}
									}
								]
							else

								if forecast.code == 200 && worldtides.code == 200
									render json: [conditions:
										{
											tide:{
												height:worldtides.parsed_response["heights"].last["height"],
												desc: "#{extremes.last['type']} - #{extremes[extremes.length - 1]['type']}"
											},
											wind:{
												speed: forecast.parsed_response['currently']['windSpeed'],
												bearing: forecast.parsed_response['currently']['windBearing']
											}
										}
									]
								end
							end
				end

  end

  # GET /tidelines/1
  def show
    render json: @tideline
  end

  # POST /tidelines
  def create
    @tideline = Tideline.new(tideline_params)

    if @tideline.save
      render json: @tideline, status: :created, location: @tideline
    else
      render json: @tideline.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tidelines/1
  def update
    if @tideline.update(tideline_params)
      render json: @tideline
    else
      render json: @tideline.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tidelines/1
  def destroy
    @tideline.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tideline
      @tideline = Tideline.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tideline_params
      params.require(:tideline).permit(:name, :lat, :lon, :wave_length, :swell_direction, :tide, :wind)
    end
end
