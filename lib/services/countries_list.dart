import 'dart:convert';

import 'package:covid19_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class CountriesList {
  Future<List<dynamic>> getCountriesApi() async{

    var response = await http.get(Uri.parse(AppUrls.countriesList));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception(
          'error'
      );
    }
  }
}