import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_cleaner/components/homepage.dart';
import 'package:git_cleaner/components/login_form_widget.dart';
import 'package:git_cleaner/services/loginService.dart';
import 'package:git_cleaner/style/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  var path = Directory.current.path;
  Hive..init(path);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Git Cleaner',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthScreen(title: 'GitCleaner'),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  final String title;
  LoginService _loginService = new LoginService();

  AuthScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Git-Cleaner",
                style: GoogleFonts.inconsolata(fontSize: 35),
              ),
              Container(
                  height: 120,
                  child: Image(
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/ef/03/f8/ef03f898ffa6f5eac9a37622cd73cd4b.gif"),
                  ))
            ],
          ),
        ),
        preferredSize: Size.fromHeight(200),
      ),
      body: Column(
        children: [
          LoginFormLayout(),
          SizedBox(
            height: 15,
          ),
          Material(
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      print("Navigate to github.com/settings/apps");
                    },
                    child: Text(
                      "Generate a new token",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
              ))
        ],
      ),
      floatingActionButton: LoginFormLayout().submitBtn(context)
    );
  }
}
