#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p python3Packages.requests


import json
import requests


WEATHER_ICON = {
    "01d": " ",
    "01n": " ",
    "02d": "  ",
    "02n": "  ",
    "03d": "  ",
    "03n": "  ",
    "04d": "  ",
    "04n": "  ",
    "09d": "  ",
    "09n": "  ",
    "10d": "  ",
    "10n": "  ",
    "11d": "  ",
    "11n": "  ",
    "13d": "  ",
    "13n": "  ",
    "50d": "  ",
    "50n": "  ",
}

data = {}
apiKey = "changeMe"
lat = "45.2199"
lon = "5.7901"
try:
    weather = requests.get(
        f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={apiKey}&units=metric"
    ).json()
except ConnectionError:
    weather = " 😭 "
    data["text"] = " 😭 "
    print(json.dumps(data))
finally:
    data["text"] = f"{WEATHER_ICON[weather['weather'][0]['icon']]}{str(int(weather['main']['temp']))}°C" 
    data[
        "tooltip"
    ] = f"<b> {WEATHER_ICON[weather['weather'][0]['icon']]}{weather['weather'][0]['description']} </b>\n"
    data["tooltip"] += f"Feels like {str(int(weather['main']['feels_like']))}° Your City here"
    print(json.dumps(data))
