

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:git_cleaner/models/user_model.dart';

abstract class GitInterface {
  void getUserData(String token){

  }
}

class GitApi implements GitInterface  {
  GitUserModel userModel;

  @override
  Future<GitUserModel> getUserData(String token) async{
    String url = "https://api.github.com/user";
    String tokenTemp = "efd9b78e3e07fde56fdf994e7b5a55a513c09054";

    try {
      Response response = await Dio(
        BaseOptions(
          headers: {
            "Authorization" : "token $tokenTemp",
            "Accept": "application/vnd.github.v3+json"
          }
        )
      ).get(url);
      final resultReponse = json.decode(response.toString());
      userModel = GitUserModel.fromJson(resultReponse);

    }
    catch(e){
      print(e);
    }
    return userModel;
  }
}