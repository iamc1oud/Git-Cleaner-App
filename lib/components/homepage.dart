import 'package:flutter/material.dart';
import 'package:git_cleaner/services/loginService.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginService>(
      builder: (context, loginService, widget) {
        return Scaffold(
          appBar: AppBar(title: new Text(loginService.getUsername),),
        );
      },
    );
  }
}
