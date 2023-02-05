import 'dart:convert';

import 'package:covid19_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

import '../modals/World_states_model.dart';

class StateServices{

  Future<WorldStatesModel> getStatesData () async {

    var response = await http.get(Uri.parse(AppUrls.worldStatesApi));

    if(response.statusCode == 200){
      WorldStatesModel statesData = WorldStatesModel.fromJson(jsonDecode(response.body));
      return statesData;
    }
    else{
      throw Exception('error');
    }
  }

}

