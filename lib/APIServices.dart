import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'modals/countryModal.dart';
import 'modals/globalModals.dart';
class APIservices{
  final  globalUir = "https://disease.sh/v3/covid-19/all";
  final  CountriesUir = "https://disease.sh/v3/covid-19/countries";
  List<CountryModal> listData = [];

  Future<GlobalModals> getData(String uri)async{
    Response res = await http.get(Uri.parse(uri));
    if(res.statusCode == 200)
    {
      var data = jsonDecode(res.body);
      return GlobalModals.fromJson(data);
    } else{
      throw Exception('error');
    }
  }
  Future<List<CountryModal>> getCountryData(String uri)async{
    Response res = await http.get(Uri.parse(uri));
    if(res.statusCode == 200)
    {
      var data = jsonDecode(res.body);
      for(Map i in data){
        listData.add(CountryModal.fromJson(i));
      }
      return listData;
    } else{
      throw Exception('error');
    }
  }



}