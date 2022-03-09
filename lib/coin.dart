import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const coinApi = "https://rest.coinapi.io/v1/exchangerate/BTC/NGN?apiKey=C1F7F0CD-E0CC-4DB6-8324-554913FBE22C";
const List<String> ListofCurrencies = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
  'NGN'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData() async{
    String coinApiUrl = "$coinApi";
    http.Response response = await http.get(coinApiUrl);
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var coinPrice = jsonData;
      return coinPrice;
    }
    else {
      print (response.statusCode);
    }
  }
}
