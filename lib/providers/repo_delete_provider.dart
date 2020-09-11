import 'package:flutter/material.dart';

class RepositoryDeleteProvider extends ChangeNotifier {
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
}
