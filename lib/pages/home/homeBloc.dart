import 'package:newswebapp/services/manager.dart';
import 'package:newswebapp/services/responses.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final newsBloc = BehaviorSubject<NewsResponse>();
  NewsResponse newsData = NewsResponse();
  Observable<NewsResponse> get allnews => newsBloc.stream;

  Future fetchNews() async {
    try {
      ServiceManager sm = ServiceManager();
      NewsResponse news = await sm.fetchNews();
      newsBloc.sink.add(news);
    } catch (error) {
      print(error);
    }
  }

  dispose() {
    newsBloc.close();
  }
}
