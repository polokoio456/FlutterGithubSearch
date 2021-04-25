
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

  int _page = 1;
  int lastPageSize;

  @override
  Widget build(BuildContext context) => MyHomePageStateWidgetBuilder(this).sceneWidget(context);

  @override
  void initState() {
    super.initState();

    keywordSubject
        .debounceTime(Duration(milliseconds: 500))
        .listen((text) {
          _resetList();
          onSearch(text, _page);
        });
  }

  void onKeywordChanged(String text) {
    keywordSubject.add(keywordController.text);
  }

  void onSearch(String keyword, int page) {
    if (keyword == null || keyword.isEmpty) {
      return;
    }

    _githubService.search(keyword, page)
        .asStream()
        .listen((response) {
        lastPageSize = response.userList.length;
          _updateList(response.userList);
        });
  }

  void loadMore() {
    if (lastPageSize < 20) {
      return;
    }

    onSearch(keywordController.text, ++_page);
  }

  void _updateList(List<GithubUser> newUsers) {
    setState(() {
      users.addAll(newUsers);
    });
  }

  void _resetList() {
    setState(() {
      _page = 1;
      users.clear();
    });
  }
}