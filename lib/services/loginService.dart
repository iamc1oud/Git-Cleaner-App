import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

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

  String get _getUsername => this.username;
  String get _getToken => this.oauth;
}