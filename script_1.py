# 3a. Задание можно выполнить на любом языке программирования.
# Задача: разработать программу, которая на основании данных сервиса https://openweathermap.org/ (требует регистрации, достаточно бесплатного плана Free) будет выводить следующие данные для Вашего города:
# 1. День, с минимальной разницей "ощущаемой" и фактической температуры ночью (с указанием разницы в градусах Цельсия)
# 2. Максимальную продолжительностью светового дня (считать, как разницу между временем заката и рассвета) за ближайшие 5 дней (включая текущий), с указанием даты.


import requests
import json
import datetime

request_14_02 = 'http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&units=metric&dt=1644866918&appid=471513ea69403129f79bbd3675cfccf3'
request_13_02 = 'http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&units=metric&dt=1644780518&appid=471513ea69403129f79bbd3675cfccf3'
request_12_02 = 'http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&units=metric&dt=1644694118&appid=471513ea69403129f79bbd3675cfccf3'
request_11_02 = 'http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&units=metric&dt=1644607718&appid=471513ea69403129f79bbd3675cfccf3'
request_10_02 = 'http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&units=metric&dt=1644521318&appid=471513ea69403129f79bbd3675cfccf3'

date_list = {request_14_02: '14:02', request_13_02: '13:02', request_12_02: '12:02',
             request_11_02: '11:02', request_10_02: '10:02'}
my_dict = {}
for key, value in date_list.items():
    resp = requests.get(key)
    data = json.loads(resp.text)
    sunrise = datetime.datetime.fromtimestamp(data['current']['sunrise'])
    sunset = datetime.datetime.fromtimestamp(data['current']['sunset'])
    result = sunset - sunrise
    my_dict.update({result: value})

max_result = max(my_dict.keys())
print(f'Максимальная продолжительность светового дня {my_dict[max_result]} и составила {max_result}')

my_dict1_temp = {}
for key, value in date_list.items():
    resp = requests.get(key)
    data = json.loads(resp.text)
    feels_like = data['current']["feels_like"]
    temp = data['current']["temp"]
    result = abs(feels_like - temp)
    my_dict1_temp.update({result: value})

min_difference = min(my_dict1_temp.keys())
print(f'День, с минимальной разницей "ощущаемой" {my_dict1_temp[min_difference]} и составила {min_difference}')
