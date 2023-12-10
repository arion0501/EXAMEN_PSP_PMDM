import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'PilotoF1.dart';

class HttpAdmin {
  HttpAdmin();

  Future<int> getPilotosF1(int anio) async {
    int iAnio = 2022;
    final response = await http
        .get(Uri.parse('http://ergast.com/api/f1/${iAnio}/drivers.json'));

    if (response.statusCode == 200) {
      print("Prueba --->>   " + jsonDecode(response.body).toString());
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> json2 = json["Datos"];
      Map<String, dynamic> json3 = json2["Tabla Pilotos"];
      List<dynamic> listaPilotos = json3["Pilotos"];

      List<dynamic> listaPilotos2 = json["MRData"]["DriverTable"]["Drivers"];

      List<PilotoF1> listaPilotosFinal = [];

      for (int i = 0; i < listaPilotos2.length; i++) {
        listaPilotosFinal.add(PilotoF1.fromJson(listaPilotos2[i]));
      }

      print("Piloto en posición 17 (nombre) --->>: " +
          listaPilotosFinal[17].givenName +
          "   " +
          listaPilotosFinal[17].familyName);
      return anio;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<double> pedirTemperaturasEn(double lat, double long) async {
    var url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'hourly': 'temperature_2m'
    });
    print("URL Resultante: " + url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var horas = jsonResponse['hourly_units'];
      DateTime now = DateTime.now();
      int hour = now.hour;

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes = jsonHourly['time'];
      var jsonTiempo0 = jsonTimes[hour];
      var jsonTemperaturas = jsonHourly['temperature_2m'];
      var jsonTemperatura0 = jsonTemperaturas[hour];
      return jsonTemperatura0;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  }
}
