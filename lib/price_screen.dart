import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'crypto_value.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double btcValue;

  void initState() {
    super.initState();
    updatePrice();
  }

  void updatePrice() async {
    CryptoValue cryptoValue = CryptoValue(selectedCurrency);
    double bitcoinValue = await cryptoValue.getBTCValue();
    setState(() {
      btcValue = bitcoinValue;
    });
  }

  DropdownButton androidDropdown() {
    return DropdownButton(
      value: selectedCurrency,
      items: currenciesList
          .map(
            (currency) => DropdownMenuItem(
              child: Text(currency),
              value: currency,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updatePrice();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        updatePrice();
      },
      children: currenciesList.map((currency) => Text(currency)).toList(),
      scrollController: FixedExtentScrollController(
          initialItem: currenciesList.indexOf(selectedCurrency)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${btcValue ?? ''} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown()),
        ],
      ),
    );
  }
}
