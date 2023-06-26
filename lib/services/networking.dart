import 'package:http/http.dart';
import 'dart:convert';



class NetworkHelper{
  final String url;
  NetworkHelper(this.url);

  Future getData ()async{
    Uri uri=Uri.parse(url);
    Response response= await get(uri) ;
    if(response.statusCode==200) {
      String data = (response.body);

      var decodeData = jsonDecode(data);
      return decodeData;
  }
    else{
      print(response.statusCode);
    }

}
}
