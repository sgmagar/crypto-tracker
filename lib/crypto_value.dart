import 'package:http/http.dart' as http;
import 'dart:convert';

const btcAverageUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';
const btcAverageAPIKey = 'ZmVmYzMxMmM4OTc2NGFhNWJkY2EwZWRmMGIxNzQ3Yjg';

class CryptoValue {
  CryptoValue(this.selectedCurrency);
  String selectedCurrency;

  Future<double> getBTCValue() async {
    try {
      var headers = {'x-ba-key': btcAverageAPIKey};
      var response = await http.get('$btcAverageUrl/BTC$selectedCurrency',
          headers: headers);
      var decodedValue = jsonDecode(response.body);
      double lastValue = decodedValue["last"];
      return lastValue;
    } catch (e) {
      print(e);
    }
  }
}
