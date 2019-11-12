import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newswebapp/constants/FzNews.dart';
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
            if (snapshot.hasData)
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: snapshot.data.articles[index].urlToImage != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data.articles[index].urlToImage),
                          )
                        : Container(
                            color: Colors.pink,
                          ),
                    title: snapshot.data.articles[index].title != null
                        ? Text(snapshot.data.articles[index].title)
                        : Container(),
                    subtitle: snapshot.data.articles[index].author != null
                        ? Text(snapshot.data.articles[index].author)
                        : Container(),
                  );
                },
                itemCount: snapshot.data.articles.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey,
                ),
              );

            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: FzNews().gradientLoader(),
              );

            return Container();
          },
        ),
      );
}
