import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'crypto_value.dart';
import 'price_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double btcValue;
  double ethValue;
  double ltcValue;

  void initState() {
    super.initState();
    updatePrice();
  }

  void updatePrice() async {
    CryptoValue cryptoValue = CryptoValue(selectedCurrency);
    Map allValues = await cryptoValue.getAllValues();
    setState(() {
      btcValue = allValues['BTC'];
      ethValue = allValues['ETH'];
      ltcValue = allValues['LTC'];
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PriceCard(
                  priceText:
                      '1 BTC = ${btcValue != null ? btcValue.toStringAsFixed(3) : ''} $selectedCurrency'),
              PriceCard(
                  priceText:
                      '1 ETH = ${ethValue != null ? ethValue.toStringAsFixed(3) : ''} $selectedCurrency'),
              PriceCard(
                  priceText:
                      '1 LTC = ${ltcValue != null ? ltcValue.toStringAsFixed(3) : ''} $selectedCurrency'),
            ],
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
