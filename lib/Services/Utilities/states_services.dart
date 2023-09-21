import 'dart:convert';

import 'package:covid19app/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../Models/WorldStatesModel.dart';

class StatesServices{
  AppUrl appUrl =AppUrl();

  Future<WorldStatesModel>fetchWorldStatesRecords()async{
    final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
      print("rakib");
      return WorldStatesModel.fromJson(data);

    }
    else{
      throw Exception("error");
    }
  }


  Future<List<dynamic>>countriesListApi()async{
    final response=await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
        return data;
    }
    else{
      throw Exception("error");
    }


  }



}

