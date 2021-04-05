//https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var url =
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd' +
            id;
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    //var value = json['market_data']['current_price']['usd'].toString();
    return json;
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
