import 'package:http/http.dart' as http;
import 'networking.dart';
import 'dart:convert';

NetworkHelper networkHelper = NetworkHelper();

class CryptoValue {
  CryptoValue(this.selectedCurrency);
  String selectedCurrency;

  Future<double> getBTCValue() async {
    var btcData = await networkHelper.getData('/BTC$selectedCurrency');
    return btcData["last"];
  }
}
