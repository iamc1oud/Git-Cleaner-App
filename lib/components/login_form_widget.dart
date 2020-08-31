import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:git_cleaner/services/loginService.dart';
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
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        child: Consumer<LoginService>(
          builder: (context, loginService, child) => child,
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (String val){
                    if(val.isEmpty){
                      return "Must enter username";
                    }
                    return "Okay";
                  },
                  controller: usernameController,
                    decoration: inputDecoration('Username', Icon(Icons.account_circle, color: const Color(0xFF2A2C34),))
                ),
                Divider(
                  height: 20,
                ),
                TextFormField(
                    validator: (String val){
                      if(val.isEmpty){
                        return "Must enter oauth token";
                      }
                      return "Okay";
                    },
                  controller: oauthController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  onFieldSubmitted: (val){
                    print(val);
                  },
                  decoration: inputDecoration('OAuth Token', Icon(Icons.vpn_key, color: const Color(0xFF2A2C34)),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText, Icon prefixIcon, {Icon suffixIcon}){
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
      prefixIcon: prefixIcon,
      labelText: labelText,
      suffixIcon: suffixIcon ?? SizedBox(),
    );
  }

  Widget submitBtn(BuildContext context) {
  return FloatingActionButton.extended(
  backgroundColor: ConstFloatingActionButton().lightFabColor,
  icon: Icon(Icons.lock_open),
  onPressed: () {
    if(_loginFormKey.currentState.validate()){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Logging in")));
    }
  },
  label: new Text("Authorize"));
}
}
