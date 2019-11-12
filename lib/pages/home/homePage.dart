import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data.articles[index].urlToImage),
                    ),
                    title: Text(snapshot.data.articles[index].title),
                    subtitle: Text(snapshot.data.articles[index].author),
                  );
                },
                itemCount: snapshot.data.articles.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey,
                ),
              );

            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: SpinKitCubeGrid(
                  size: 70.0,
                  itemBuilder: (context, index) => DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFF6356F),
                          const Color(0xFFFF5F50)
                        ],
                        tileMode: TileMode.clamp,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
              );
          },
        ),
      );
}
