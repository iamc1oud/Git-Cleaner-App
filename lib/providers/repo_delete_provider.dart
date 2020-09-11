import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepositoryDeleteProvider extends ChangeNotifier implements ReassembleHandler {
  Set<String> _listOfRepos = new Set<String>();

  Set<String> get _getListOfRepos => _listOfRepos;

  void addRepo(String url) {
    _getListOfRepos.add(url);
    print(_getListOfRepos);
    notifyListeners();
  }

  void deleteRepo(String url) {
    _getListOfRepos.remove(url);
    print(_listOfRepos);
    notifyListeners();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
  }
}
