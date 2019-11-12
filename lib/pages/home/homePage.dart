import 'package:flutter/material.dart';
import 'package:newswebapp/services/responses.dart';

import 'homeBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.fetchNews();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Daily News'),
        ),
        body: StreamBuilder(
            stream: _homeBloc.allnews,
            builder: (context, AsyncSnapshot<NewsResponse> snapshot) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile();
                },
                itemCount: snapshot.data.articles.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey,
                ),
              );
            }),
      );
}
