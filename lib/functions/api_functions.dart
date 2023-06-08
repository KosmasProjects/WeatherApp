import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:weather_app/functions/maps.dart';

String api =
    'https://api.open-meteo.com/v1/forecast?latitude=52.23&longitude=21.01&current_weather=true';

Future<void> fetchApi() async {
  try {
    Response response = await get(
      Uri.parse(api),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    var decoded = jsonDecode(response.body);
    apiData = decoded;
  } catch (e) {
    print(e);
    (e.toString());
  }
}

Future<void> fetchMaxTemperature() async {
  try {
    Response response = await get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=52.23&longitude=21.01&daily=apparent_temperature_max,&timezone=auto'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    var decoded = jsonDecode(response.body);
    maxTemperature = decoded;
    maxTemperatureList = decoded['daily']['apparent_temperature_max'];
    maxTemperatureDateList = decoded['daily']['time'];
  } catch (e) {
    print(e);
    (e.toString());
  }
}

Future<void> fetchMinTemperature() async {
  try {
    Response response = await get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=52.23&longitude=21.01&daily=apparent_temperature_min,&timezone=auto'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    var decoded = jsonDecode(response.body);
    minTemperature = decoded;
  } catch (e) {
    print(e);
    (e.toString());
  }
}

Future<void> fetchWeatherCode() async {
  try {
    Response response = await get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=52.23&longitude=21.01&daily=weathercode,&timezone=auto'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    var decoded = jsonDecode(response.body);
    weatherCodeList = decoded['daily']['weathercode'];
    print(decoded['daily']['weathercode']);
  } catch (e) {
    print(e);
    (e.toString());
  }
}
