import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/WeatherResponse.dart';

void main() => runApp(WeatherScreen());

class WeatherScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<WeatherScreen> {
  WeatherResponse response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getdata(),
            builder: (context, snaapshot) {
              if (snaapshot.hasData) {
                return SizedBox(
                  height: double.infinity,

                  child: Card(
                    semanticContainer: true,
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Card(

                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Text("City   " + response.name),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Main   " + response.weather[0].main),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Description   " + response.weather[0].description),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("LAT   " + response.coord.lat.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("LON   " + response.coord.lon.toString()),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Temp   " + response.main.temp.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pressure   " + response.main.pressure.toString()),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Humidity   " + response.main.humidity.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Wind   " + response.wind.speed.toString()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<WeatherResponse> getdata() async {
    var url =
        "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22%22";
    var ss = await http.get(url);

    setState(() {
      response = WeatherResponse.fromJson(json.decode(ss.body));
    });
    return response;
  }
}
