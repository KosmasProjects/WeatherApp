import 'package:flutter/material.dart';
import 'package:weather_app/functions/maps.dart';
import 'package:weather_icons/weather_icons.dart';

import '../functions/api_functions.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final Future dataFetched;

  Future<void> fetchDataForWeather() async {
    await fetchApi();
    await fetchMaxTemperature();
    await fetchMinTemperature();
    await fetchWeatherCode();
  }

  void initState() {
    dataFetched = fetchDataForWeather();
    dataFetched.then((value) => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: dataFetched,
          builder: (context, snapshot) {
            if (apiData.isNotEmpty) {
              return Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: apiData['current_weather']['is_day'] == 1
                        ? const AssetImage("assets/images/day.jpg")
                        : const AssetImage("assets/images/night.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: dataFetched,
                          builder: (context, snapshot) {
                            if (apiData.isEmpty ||
                                maxTemperature.isEmpty ||
                                minTemperature.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, right: 22.0, top: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${maxTemperature['timezone']}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          '${apiData['current_weather']['temperature']} \u2103',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 40),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(
                                                  Icons.wind_power,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '${apiData['current_weather']['windspeed']}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.thermostat,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '${maxTemperature['daily']['apparent_temperature_max'][0]} \u2103',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.thermostat,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  ' ${minTemperature['daily']['apparent_temperature_min'][0]} \u2103',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              );
                            }
                          },
                        ),
                        const Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Weather for nex days:',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Container(
                              height: 125,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: maxTemperatureList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${maxTemperatureDateList[index]}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                BoxedIcon(
                                                  WeatherIcons.cloud,
                                                  color: Colors.white,
                                                  // Fallback is optional, throws if not found, and not supplied.
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${maxTemperatureList[index]} \u2103',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            height: 90,
                                            width: 2,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/day.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text('Loading...'),
                        ))),
              );
            }
          }),
    );
  }
}
