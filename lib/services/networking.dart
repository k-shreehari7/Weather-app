import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper
{
  NetworkHelper({this.url});
  final String url;
  Future getData() async
  {
    String data;
    http.Response response=await http.get(Uri.parse(url));
    if(response.statusCode==200)
    {
      data=response.body;
      var decoded_data=jsonDecode(data);
      return decoded_data;
    }
    else {
      print(response.statusCode);
    }
  }
}