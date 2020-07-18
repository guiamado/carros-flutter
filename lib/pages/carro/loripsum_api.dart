import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:http/http.dart' as http;

class LoripsumBloc extends SimpleBloc<String> {
  static String lorim;
  fetch() async {
    try {
      String s = lorim ?? await LoripsumApi.getLoripsum();
      add(s);
      lorim = s;
    } catch (e) {
      addError(e);
    }
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = 'http://loripsum.net/api';

    var response = await http.get(url);

    String text = response.body;
    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');

    return text;
  }
}
