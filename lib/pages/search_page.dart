import 'package:flutter/material.dart';
import '../constant/component_index.dart';

class SearchPage extends StatefulWidget {
  final String searchWord;
  SearchPage(this.searchWord);
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Directionality(
            textDirection: Directionality.of(context),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              decoration: InputDecoration(
                hintText: '搜索...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              autofocus: false,
              onSubmitted: (String search) {
                ToastUtil.showToast("搜索$_search");
                _search = search;
                //_searchData();
              },
            )),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //_searchData();
                ToastUtil.showToast("搜索$_search");
              })
        ]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.search)),
      ),
      body: Container(
        child: Text(widget.searchWord ?? "搜索词"),
      ),
    );
  }
}
