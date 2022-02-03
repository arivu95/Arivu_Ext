import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';

class CovidCountrySelect extends StatefulWidget {
  @override
  _CovidCountrySelectState createState() => _CovidCountrySelectState();
}

class _CovidCountrySelectState extends State<CovidCountrySelect> {
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = true,
      _navigateToPreviousScreenOnIOSBackPress = true;
  late List<String> _list;
  String _selectedItem = 'Select Country';

  @override
  void initState() {
    _list = ["India", "Qatar", "USA"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AwesomeDropDown(
        isPanDown: _isPanDown,
        dropDownList: _list,
        isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
        selectedItem: _selectedItem,
        onDropDownItemClick: (selectedItem) {
          _selectedItem = selectedItem;
        },
        dropStateChanged: (isOpened) {
          _isDropDownOpened = isOpened;
          if (!isOpened) {
            _isBackPressedOrTouchedOutSide = false;
          }
        },
      ),
    );
  }
}
