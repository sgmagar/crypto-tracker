import 'networking.dart';

NetworkHelper networkHelper = NetworkHelper();

class CryptoValue {
  CryptoValue(this.selectedCurrency);
  String selectedCurrency;

  Future<Map> getAllValues() async {
    return {
      "BTC": await getBTCValue(),
      "ETH": await getETHValue(),
      "LTC": await getLTCValue()
    };
  }

  Future<double> getBTCValue() async {
    var btcData = await networkHelper.getData('/BTC$selectedCurrency');
    return btcData != null ? btcData["last"] : 0.0;
  }

  Future<double> getETHValue() async {
    var ethData = await networkHelper.getData('/ETH$selectedCurrency');
    return ethData != null ? ethData["last"] : 0.0;
  }

  Future<double> getLTCValue() async {
    var ltcData = await networkHelper.getData('/LTC$selectedCurrency');
    return ltcData != null ? ltcData["last"] : 0.0;
  }
}
