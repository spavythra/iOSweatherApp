# iOSweatherApp

Mobile application developed as a part of coursework in MacOS
  - Xcode 13 version

- Application and its design rationale

	- API: https://openweathermap.org/api (Accessing that account)
	- Displayed current weather in "Manual Coordinates around Helsinki" in the UI
	- Displayed icon of the weather
	- Use tabs, one for current weather and one for forecast, the forecast has not been implemented yet due to some issue with openweathermap API
	- Use GPS and display conditions based on the gps location instead of Tampere.
	- Create settings tab, contains UI that has toggle for
    		Current position (GPS)
    		Tampere
    		Helsinki
    		Oulu
		    Paris
	- User can choose one of these and display either one of the cities weather OR the gps
	- User can add cities to the list. 
	- User can remove cities from the list, not the current location. 
