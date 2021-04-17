
import 'package:flutter/material.dart';
import 'package:flutter_github_search/main/my_home_page.view.dart';
import 'package:flutter_github_search/network/RestApiModule.dart';
import 'package:flutter_github_search/network/model/github_search_result.dart';
import 'package:flutter_github_search/network/service/github_service.dart';
import 'package:rxdart/rxdart.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState(RestApiModule().githubService);
}

class MyHomePageState extends State<MyHomePage> {

  final IGithubService _githubService;

  TextEditingController keywordController = TextEditingController();
  PublishSubject<String> keywordSubject = PublishSubject();

  MyHomePageState(this._githubService);

  List<GithubUser> users = List<GithubUser>();

  int page = 1;

  @override
  Widget build(BuildContext context) => MyHomePageStateWidgetBuilder(this).sceneWidget(context);

  @override
  void initState() {
    super.initState();

    keywordSubject
        .debounceTime(Duration(milliseconds: 1500))
        .listen((text) {
          _resetList();
          onSearch(text, page);
        });
  }

  void onKeywordChanged(String text) {
    keywordSubject.add(keywordController.text);
  }

  void onSearch(String keyword, int page) {
    _githubService.search(keyword, page)
        .asStream()
        .listen((response) {
          _updateList(response.userList);
        });
  }

  void loadMore() {
    onSearch(keywordController.text, ++page);
  }

  void _updateList(List<GithubUser> newUsers) {
    setState(() {
      users.addAll(newUsers);
    });
  }

  void _resetList() {
    setState(() {
      page = 1;
      users.clear();
    });
  }
}