import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
  String username;
  String oauth;

  LoginService(){
      print("Logging in the user");
  }

  void setUsername(String username){
    this.username = username;
    notifyListeners();
  }

  void setOauthToken(String token){
    this.oauth = token;
    notifyListeners();
  }

  void testFun(){
    print('function called');
  }

  String get getUsername => this.username;
  String get getToken => this.oauth;
}