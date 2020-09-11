import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:git_cleaner/login/loginService.dart';
import 'package:git_cleaner/style/const.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

// ignore: must_be_immutable
class LoginFormLayout extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController oauthController = new TextEditingController();

  // Creating a global key that uniquely defines the given form
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        child: Consumer<LoginService>(
          builder: (context, loginService, child) {
            return Form(
              key: _loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "Must enter username";
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: inputDecoration(
                          'Username',
                          Icon(
                            Icons.account_circle,
                          ))),
                  Divider(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "Must enter oauth token";
                        }
                        return null;
                      },
                      controller: oauthController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onFieldSubmitted: (val) {
                        print(val);
                      },
                      decoration: inputDecoration(
                        'OAuth Token',
                        Icon(Icons.vpn_key),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: FloatingActionButton.extended(
                          backgroundColor: ColorSchemes().lightDark,
                          icon: Icon(
                            Icons.lock_open,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_loginFormKey.currentState.validate()) {
                              loginService.setUsername(usernameController.value.text);
                              loginService.setOauthToken(oauthController.value.text);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                            }
                          },
                          label: new Text(
                            "Authorize",
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText, Icon prefixIcon, {Icon suffixIcon}) {
    return InputDecoration(
      border: InputBorder.none,
      /*enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 1.0),
      ),*/
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      focusColor: Colors.blue,
      prefixIcon: prefixIcon,
      labelText: labelText,
      suffixIcon: suffixIcon ?? SizedBox(),
    );
  }

  Widget submitBtn({BuildContext context}) {
    return FloatingActionButton.extended(
        backgroundColor: ConstFloatingActionButton().lightFabColor,
        icon: Icon(Icons.lock_open),
        onPressed: () {
          if (_loginFormKey.currentState.validate()) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Logging in")));
          }
        },
        label: new Text("Authorize"));
  }
}
