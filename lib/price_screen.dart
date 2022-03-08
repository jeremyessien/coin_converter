import 'package:flutter/material.dart';
import 'coin.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'show Platform;
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String chosenCurrency = 'NGN';

  //Drop Down Button for Android
  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    //For loop for drop down button
    for (String curr in ListofCurrencies) {
      var newItem = DropdownMenuItem(
        child: Text(curr),
        value: curr,
      );
      dropDownItem.add(newItem);
    }
    return DropdownButton<String>(
      value: chosenCurrency,
      dropdownColor: Colors.lightBlueAccent,
      //Called the for loop from line 12
      items: dropDownItem,
      onChanged: (value) {
        setState(() {
          chosenCurrency = value;
        });
      },
    );
  }

  // Cupertino Picker for iOS
  CupertinoPicker iOS(){
    List<Text> pickerItems = [];
    for (String curr in ListofCurrencies) {
      pickerItems.add(Text(curr));
    }

   return CupertinoPicker(
      backgroundColor: Colors.lightGreenAccent.shade200,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {},
      children: pickerItems,
    );
  }

  // Widget getPicker(){
  //   if (Platform.isIOS){
  //     return iOS();
  //   }
  //   else if (Platform.isAndroid){
  //     return getDropDownButton();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Converter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightGreenAccent.shade200,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
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
            color: Colors.lightGreenAccent.shade200,
            //Tenary Operator to check  if platform is iOS or Android
            child:Platform.isIOS? iOS() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}
