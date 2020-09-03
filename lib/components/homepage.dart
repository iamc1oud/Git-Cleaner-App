import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_cleaner/api/git_api.dart';
import 'package:git_cleaner/login/loginService.dart';
import 'package:git_cleaner/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String token = "efd9b78e3e07fde56fdf994e7b5a55a513c09054";

    GitApi gitApi = new GitApi();

    return Consumer<LoginService>(
      builder: (context, loginService, widget) {
        return Scaffold(
          appBar: AppBar(title: new Text(loginService.getUsername),),
          // ignore: missing_required_param
          drawer: Drawer(
            elevation: 5,
              child: FutureBuilder(
                future: gitApi.getUserData(loginService.getToken),
                builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    GitUserModel model = snapshot.data;
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: Color(0xFF191414),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            accountName: Text(model.login),
                            accountEmail: Text(model.email),
                            currentAccountPicture: CircleAvatar(
                              backgroundImage: NetworkImage(model.avatarUrl),
                            ),
                          ),
                        ),
                        Text(model.bio),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getDrawerItems(model),
                          ),
                        )
                      ],
                    );
              },),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

            },
            child: new Icon(Icons.wifi),
          ),
        );
      },
    );
  }

  List<Widget> getDrawerItems(GitUserModel model){
    TextStyle titleStyle = TextStyle(fontSize: 16);
    TextStyle valueStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    DateFormat date = new DateFormat('yyyy-MM-dd');
    String getCreationDate = date.format(DateTime.parse(model.createdAt));

    return [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Followers", style: titleStyle),
                    new Text(model.followers.toString(), style: valueStyle,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Following", style: titleStyle),
                    new Text(model.following.toString(), style: valueStyle,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Public repos", style: titleStyle),
                    new Text(model.publicRepos.toString(), style: valueStyle,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Public repos", style: titleStyle),
                    new Text(model.publicGists.toString(), style: valueStyle,)
                  ],
                )
              ],
            ),
          ),
        ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Followers", style: titleStyle),
                  new Text(model.followers.toString(), style: valueStyle,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Following", style: titleStyle),
                  new Text(model.following.toString(), style: valueStyle,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Public repos", style: titleStyle),
                  new Text(model.publicRepos.toString(), style: valueStyle,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Public repos", style: titleStyle),
                  new Text(model.publicGists.toString(), style: valueStyle,)
                ],
              )
            ],
          ),
        ),
      ),

    ];
  }
}
