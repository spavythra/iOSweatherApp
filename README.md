# iOSweatherApp

Mobile application developed as a part of coursework in MacOS
  - Xcode 13 version

- Application and its design rationale

	- API: https://openweathermap.org/api (Accessing that account)
	- Displays current weather in "Manual Coordinates around Helsinki" in the UI
	- Displays icon of the weather
	- Uses tabs, one for current weather and one for forecast, the forecast has not been implemented yet due to some issue with openweathermap API
	- Uses GPS and display conditions based on the gps location instead of Tampere.
	- Created settings tab, contains UI that has toggle for
    		Current position (GPS)
    		Tampere
    		Helsinki
    		Oulu
		    Paris
	- User can choose one of these and display either one of the cities weather OR the gps
	- User can add cities to the list. 
	- User can remove cities from the list, not the current location. 
	
- Demonstration of the application in MacOS
https://youtu.be/u8nu9ELPRNY
