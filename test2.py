from flask import Flask
import json
import urllib

app = Flask(__name__)

@app.route('/')

def datatest():
	
	url = "https://www.googleapis.com/calendar/v3/calendars/0rn5mgclnhc7htmh0ht0cc5pgk@group.calendar.google.com/events?T00:00:00-07:00&singleEvents=true&key=AIzaSyASiprsGk5LMBn1eCRZbupcnC1RluJl_q0"

	response = urllib.request.urlopen(url)
	
	json_data = json.loads(response.read())

	print(json_data)

	return json_data
		 
