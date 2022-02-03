import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFFD8B677);

const Color commentColor = Color.fromARGB(255, 255, 246, 196);
const Color applicationColor = Color(0xFF8dc542);
const Color activeColor = Color(0xFFDE2128);
const Color primaryColor = Color(0xFFd7b677);
const Color submitBtnColor = Color(0xFF00C064);
const Color fieldBgColor = Color(0xFFF4F4F4);
//const Color adminHeaderDark = Color(0xFFB0BEC5);
// const Color adminHeaderDark = Color(0xffd6d6d6);
// //const Color adminHeaderLight = Color(0xFFCFD8DC);
// const Color adminHeaderLight = Color(0xffeeeeee);

//const Color adminHeaderDark = Color(0xff757575); ->pre final

const Color adminHeaderDark = Color(0xffbdbdbd);

//const Color adminHeaderLight = Color(0xffeeeeee);
const Color adminHeaderLight = Color(0xffffcdd2);
const Color disabledColor = Color(0x331D1159);
const Color subtleColor = Color(0xFFF5F3F3);
const Color addToCartColor = Color(0xFF28a745);
const Color productBgColor = Color(0x11EEEEEE);
const Color productOfferBgColor = Color(0xFFFFE2AF);
const Color dealOfDayBgColor = Color(0xFFFFE01E);
const Color saveForLaterColor = Color(0xFF342F2F);
const Color contentBgColor = Color(0xFFF4F4F8);
const Color appdrawerColor = Color(0xFFD8B677);
const Color textColor = Color(0xFF8A0007);
const Color borderColor = Color(0xFF5A2D0C);
const Color piechartActiveMemberColor = Color.fromRGBO(81, 130, 255, 1);
const Color piechartDeActiveMemberColor = Color.fromRGBO(210, 239, 255, 1);
const Color piechartFreeUserColor = Color.fromRGBO(105, 201, 255, 1);
const Color piecharPaidUserColor = Color.fromRGBO(255, 139, 139, 1);

const List<Color> btnActiveColor = [
  Color(0xFFD6B476),
  Color(0xFFF3D8A7),
  Color(0xFFD6B476)
];
const List<Color> btnTBActiveColor = [
  Color(0xFF338023),
  Color(0xFF42A230),
  Color(0xFF338023)
];
const List<Color> btnTBInActiveColor = [
  Color(0xFFBF0A0A),
  Color(0xFFBF0A0A),
  Color(0xFFBF0A0A)
];

//#1d1159

//Color Code : For bigmart
//Icon Green     - #8dc542     Icon Pink        - #dd63a5
//Logo Green    -  #8dc542     Logo Pink      - #a82275

class ButtonColors extends MaterialStateColor {
  static const int _defaultColor = 0xFFDE2128;
  static const int _pressedColor = 0x55DE2128;

  const ButtonColors() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
