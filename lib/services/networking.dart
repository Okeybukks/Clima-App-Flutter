import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String dataUrl;

  NetworkHelper(this.dataUrl);

  Future<dynamic> getData() async{
    var url = Uri.parse(dataUrl);
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      print(response.statusCode);
    }
  }

}