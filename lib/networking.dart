import 'package:http/http.dart' as http;
import 'dart:convert';

const btcAverageUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';
const btcAverageAPIKey = 'ZmVmYzMxMmM4OTc2NGFhNWJkY2EwZWRmMGIxNzQ3Yjg';

class NetworkHelper {
  Future<dynamic> getData(urlPath) async {
    try {
      var headers = {'x-ba-key': btcAverageAPIKey};
      var response = await http.get('$btcAverageUrl$urlPath', headers: headers);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
