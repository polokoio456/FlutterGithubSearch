
import 'package:flutter/material.dart';
import 'package:flutter_github_search/main/my_home_page.dart';

class MyHomePageStateWidgetBuilder {

  static const Color COLOR_BLACK = Color(0xFF000000);
  static const Color COLOR_GENERAL_TEXT = Color(0xFF333333);

  MyHomePageState state;

  MyHomePageStateWidgetBuilder(this.state);

  Widget sceneWidget(BuildContext context) => Scaffold(
      body: Container(
          child: Column(
            children:[
              SizedBox(height: 70.0),
              _keywordTextField,
              _githubListView(context)
            ],
          )
      )
  );

  Widget get _keywordTextField => Container(
    height: 50.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: TextField(
      onChanged: (text) {
        state.onKeywordChanged(text);
      },
      controller: state.keywordController,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: Color(0xFF333333), fontSize: 20),
      cursorColor: COLOR_BLACK,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: COLOR_GENERAL_TEXT, width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: COLOR_GENERAL_TEXT, width: 2)),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
      ),
    ),
  );

  Widget _githubListView(BuildContext context) => Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            if (index == (state.users.length - 1)) {
              state.loadMore();
              return _loadMoreCircle;
            } else {
              return _item(index);
            }
          }
      ),
    ),
  );

  Widget get _loadMoreCircle => Container(
    padding: const EdgeInsets.all(16.0),
    alignment: Alignment.center,
    child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(strokeWidth: 2.0)
    ),
  );

  Widget _item(int index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: Image.network(
              state.users[index].avatar,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Center(
            child: Text(
              state.users[index].name,
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      )
  );
}