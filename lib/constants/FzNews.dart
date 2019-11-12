import 'dart:convert';

class FzNews {
  //* Service Caller Settings
  static const String newsURL =
      'https://newsapi.org/v2/everything?q=bitcoin&from=2019-10-12&sortBy=publishedAt&apiKey=4d561835cb754e9989cec5c287c17964';
  //* DB Settings

  //* Error Messages
  String errorMessage;
  getErrorMessage(errorsData) {
    try {
      if (errorsData.response != null) {
        var responseData = jsonDecode(errorsData.response.toString());
        if (responseData['errors'] != null) {
          var errors = responseData['errors'];
          errors.forEach((k, v) => errorMessage = v[0].toString());
        } else {
          errorMessage = "Server error";
        }
      } else {
        errorMessage = "Server error";
      }
      return errorMessage;
    } catch (e) {
      return "Server error";
    }
  }
}
