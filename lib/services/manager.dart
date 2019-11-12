import 'package:newswebapp/services/caller.dart';
import 'package:newswebapp/services/connectionStatus.dart';
import 'package:newswebapp/services/responses.dart';

class ServiceManager {
  final ServiceCaller _sc = ServiceCaller();

  Future<NewsResponse> fetchNews() async {
    NewsResponse news;
    try {
      ConnectionStatus connectionStatus = ConnectionStatus.getInstance();
      bool isOnline = await connectionStatus.checkConnection();
      if (isOnline) news = await _sc.fetchNews();
      return news;
    } catch (e) {
      throw e;
    }
  }
}
