
import 'package:flutter/material.dart';
import 'package:flutter_github_search/main/my_home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              SizedBox(height: 8.0),
              _githubListView(context)
            ],
          )
      )
  );

  Widget get _keywordTextField => Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      border: Border.all(width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    height: 40.0,
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: TextField(
      onChanged: (text) {
        state.onKeywordChanged(text);
      },
      controller: state.keywordController,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: Color(0xFF333333), fontSize: 20),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
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

  Widget _item(int index) => GestureDetector(
    onTap: () {
      Fluttertoast.showToast(
          msg: "Name is ${state.users[index].name}！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER
      );
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
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
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              )
            ],
          ),
        )
    ),
  );
}