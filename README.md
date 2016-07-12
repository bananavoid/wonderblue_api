# SIMPLE RAILS API TASK

* call surfline API:

http://api.surfline.com/v1/forecasts/2169?resources=surf,analysis&days=7&getAllSpots=true&interpolate=false&showOptimal=true

* call worltides API:

http://www.worldtides.info/api?heights&extremes&lat=-8.674374&lon=115.212586&start=1467660952&step=5400&length=604800&key=714c07bf-b7b8-45a0-b440-f503d173fea4

* call weather API:

https://api.forecast.io/forecast/c4f1d705d7250937a2decba12d532ecb/-8.674374,115.212586

* parse responses from surfline API (sfResponse), worltides API (tideResponse), weather API (weatherResponse) and save it in database.

* create the array of objects for each spot, that provided by surfline API. Response should contain this data:

	"id": 5556, // sfResponse.id
	"name": "Bali Rovercam", // sfResponse.name
	"lat": -8.950192825865, // sfResponse.lat
	"lon": 115.12573242187, // sfResponse.lon
	"wave_height": "3 - 5 ft", // sfResponse.Surf.surf_min[0][0] + " - " + sfResponse.Surf.surf_max[0][0]
	"swell_direction": 211, // sfResponse.Surf.swell_direction1[0][0],

	"tide": { // parse tideResponse.
		"height": 1.3, // tideResponse.heights - find element with closest time** to current and use tideResponse.heights[index].height
		"desc": "low to high" // tideResponse.heights or tideResponse.extremes - find current tide condition (low - hight || high - low)
	},

	"wind": {
		"speed": 7.8, // weatherResponse.currently.windSpeed
		"bearing": 118 // weatherResponse.currently.windBearing
	}

* create an API endpoint, that will include in response array of described above objects.
		Client should send as query parameters latitude and longitude (lat, lon). It will go to API requests urls.

** the time in worltides API is in seconds since the unix epoch
