import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:git_cleaner/api/git_api.dart';
import 'package:git_cleaner/models/repo_model.dart';
import 'package:intl/intl.dart';

DateFormat date = new DateFormat('dd-MM-yyyy');

class RepositoryListView extends StatefulWidget {
  @override
  _RepositoryListViewState createState() => _RepositoryListViewState();
}

class _RepositoryListViewState extends State<RepositoryListView> {
  GitApi gitApi = new GitApi();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gitApi.getUserRepository("AjjuSingh", "some token"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, pos){
            return RepositoryCard(data: snapshot.data[pos],);
          },
          physics: BouncingScrollPhysics(),
          //children: _repoList,
        );
      },
    );
  }
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          maintainState: true,
          title: Row(
            children: [
              Checkbox(
                  value: isSelected, onChanged: (val){
                setState(() {
                  isSelected = val;
                });
                print(isSelected);
              }),
              Flexible(child: Text(widget.data["name"], style: TextStyle(fontSize: 18),)),
            ]
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding:  EdgeInsets.all(8.0),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  avatar: Icon(Icons.star_border),
                  label: Text(widget.data["stargazers_count"].toString()),
                ),
                Chip(
                  avatar: Icon(Icons.remove_red_eye),
                  label: Text(widget.data["watchers"].toString()),
                ),
                Chip(
                  avatar: Icon(AntIcons.fork),
                  label: Text(widget.data["forks"].toString()),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Last Updated: "  + date.format(DateTime.parse(widget.data["updated_at"]))),
                  Text("Created On: "  + date.format(DateTime.parse(widget.data["created_at"]))),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
