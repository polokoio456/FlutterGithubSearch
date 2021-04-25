
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
    padding: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    height: 50.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: TextField(
              maxLines: 1,
              onChanged: (text) {
                state.onKeywordChanged(text);
              },
              controller: state.keywordController,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 20),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white.withOpacity(0.5)),
                border: InputBorder.none,
                fillColor: Colors.transparent,
                focusColor: Colors.white,
              ),
            ),
        ),
        SizedBox(width: 8),
        Icon(Icons.search, color: Colors.white,)
      ],
    )
  );

  Widget _githubListView(BuildContext context) => Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            if (index == (state.users.length - 1)) {
              state.loadMore();

              if (state.lastPageSize < 20) {
                return Container();
              } else {
                return _loadMoreCircle;
              }
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
        child: CircularProgressIndicator(
            strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        )
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
              Expanded(
                child: Text(
                  state.users[index].name,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
    ),
  );
}