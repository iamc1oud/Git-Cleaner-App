import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:git_cleaner/models/repo_model.dart';
import 'package:git_cleaner/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class GitInterface {
  Future<GitUserModel> getUserData(String token) async {}
  Future<dynamic> getUserRepository(String username, String token) async {}
}

class GitApi implements GitInterface  {
  GitUserModel userModel;

  String tokenTemp = "7df9aa0108c06befd1387601de129b8f3ee1555d ";

  @override
  Future<GitUserModel> getUserData(String token) async{
    String url = "https://api.github.com/user";

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

  @override
  Future<dynamic> getUserRepository(String username, String token) async {
    var decodedJson;
    try {
      http.Response response = await http.get("https://api.github.com/users/AjjuSingh/repos",headers: {
        "Authorization" : "token $tokenTemp",
        "Accept": "application/vnd.github.v3+json",
      });

      decodedJson = jsonDecode(response.body);
    }
    catch(e){
      print(e);
    }
    return decodedJson;
  }
}