from flask import Flask, jsonify, make_response
import requests, re
from datetime import timedelta
import json
import logging
import os

app = Flask(__name__)

app.secret_key = 'test'
app.config['DEBUG'] = 'True'
@app.route('/ping', methods = ['GET', 'POST'])
def ping():
   reponse_text = 'PONG'
   response = make_response(reponse_text,200)
   response.headers["Content-Type"] = "text/html"
   return response

@app.route('/health', methods = ['GET', 'POST'])
def health():
   reponse_dict = {'text' : 'HEALTHY'}
   response = make_response(jsonify(reponse_dict),200)
   response.headers["Content-Type"] = "application/json"
   return response

@app.route('/', methods = ['GET', 'POST'])
def wheather():
   lat = '51.509865'
   lon = '-0.118092'
   apikey = 'a6311858fb35df63b55216bae4aa952a'
   wresponse = requests.get("https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + apikey)
   wdata = wresponse.json()
   html_var = open('templates/weather.html', 'r').read()
   html_var = re.sub("__name__", wdata['name'], html_var)
   html_var = re.sub("__clouds__", str(wdata['clouds']['all']), html_var)
   html_var = re.sub("__country__", str(wdata['sys']['country']), html_var)
   html_var = re.sub("__dt__", str(wdata['dt']), html_var)
   html_var = re.sub("__temp__", str(wdata['main']['temp']), html_var)
   html_var = re.sub("__feels_like__", str(wdata['main']['feels_like']), html_var)
   html_var = re.sub("__humidity__", str(wdata['main']['humidity']), html_var)
   html_var = re.sub("__sunrise__", str(wdata['sys']['sunrise']), html_var)
   html_var = re.sub("__sunset__", str(wdata['sys']['sunset']), html_var)
   response = make_response(html_var,200)
   response.headers["Content-Type"] = "text/html"
   return response

if __name__ == '__main__':
   port = int(os.environ.get('PORT', 8080))
   app.run(host='0.0.0.0',port=port , debug=True )
