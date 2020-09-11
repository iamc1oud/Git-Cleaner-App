import 'package:flutter/material.dart';
import 'package:git_cleaner/api/git_api.dart';
import 'package:git_cleaner/login/loginService.dart';
import 'package:git_cleaner/providers/repo_delete_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateFormat date = new DateFormat('dd-MM-yyyy');

class FollowingListView extends StatefulWidget {
  @override
  _FollowingListViewState createState() => _FollowingListViewState();
}

class _FollowingListViewState extends State<FollowingListView> with AutomaticKeepAliveClientMixin<FollowingListView> {
  GitApi gitApi = new GitApi();
  bool isSelected = false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Consumer<LoginService>(
      builder: (context, _loginService, child) => FutureBuilder(
        future: gitApi.getUserFollowing(_loginService.getToken),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ChangeNotifierProvider(
            create: (_) => RepositoryDeleteProvider(),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, pos) {
                return RepositoryCard(
                  data: snapshot.data[pos],
                );
              },
              physics: BouncingScrollPhysics(),
              //children: _repoList,
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RepositoryCard extends StatefulWidget {
  final dynamic data;

  const RepositoryCard({Key key, this.data}) : super(key: key);
  @override
  _RepositoryCardState createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: new Text(widget.data["login"])),
    );
  }
}
