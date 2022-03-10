import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  //Dropdown Button for Android
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String curr in ListofCurrencies) {
      var newItem = DropdownMenuItem(
        child: Text(curr),
        value: curr,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  //Cupertino Picker for iOS
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String curr in ListofCurrencies) {
      pickerItems.add(Text(curr));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightGreenAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //Alternate method for choosing dropdown button/ cupertino picker for Android or iOS
  // Widget getPicker(){
  //   if (Platform.isIOS){
  //     return iOS();
  //   }
  //   else if (Platform.isAndroid){
  //     return getDropDownButton();
  //   }
  // }

  // Variable for text widget in line 96 which gets called before the data comes back from the async methods.
  String BtcToUsd = '?';

  //async method to wait for the coinData class from coin.dart
  void getData() async {
    try {
      double data = await CoinData().getCoinData();
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        BtcToUsd = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightGreenAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  // Update the Text Widget with the data in the string BtcToUsd.
                  '1 BTC = $BtcToUsd USD',
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
            color: Colors.lightGreenAccent,
            //Tenary operator for checking if the platform is iOS or Android. Chooses Cupertino Picker or Dropdown Button
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}