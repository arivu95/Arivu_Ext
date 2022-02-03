import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/shared/shimmer.dart';
import 'app_colors.dart';

/// Contains useful consts to reduce boilerplate and duplicate codet
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceTiny = 4.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceTiny = SizedBox(height: _VerticalSpaceTiny);
  static const Widget verticalSpaceSmall =
      SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge =
      SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceSmall =
      SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: _HorizontalSpaceLarge);

  static Widget hairLineWidget({Color borderColor = const Color(0x88A5A5A5)}) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      color: borderColor,
      height: 1,
    );
  }

  static BoxDecoration allcornerRadiuswithbottomShadow(double top_l,
      double top_r, double bottom_l, double bottom_r, Color backgroundColor) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(top_r),
          topLeft: Radius.circular(top_l),
          bottomLeft: Radius.circular(bottom_l),
          bottomRight: Radius.circular(bottom_r)),
      color: backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 1),
          blurRadius: 2.0,
        )
      ],
    );
  }

  static swarPreloader() {
    return Center(
        child: HeartbeatProgressIndicator(
      child: Opacity(
        opacity: 0.7,
        child: Image.asset(
          'assets/swar_logo_grey.png',
          width: 20,
          height: 20,
        ),
      ),
    ));
  }

  static OutlineInputBorder getInputBorder(double width,
      {double radius: 10, Color borderColor: Colors.transparent}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(color: borderColor, width: width),
    );
  }

  static commonTopBar(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            Text(title).bold(),
          ],
        ),
      ),
    );
  }

  static String randomString(int length) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(length, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static Widget tagWidget(String value, Color color,
      {textColor: Colors.white, radius: 4, double fontSize: 10}) {
    return Container(
      decoration: UIHelper.roundedBorderWithColor(6, color),
      padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
      child: Text(
        value,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: textColor,
            shadows: [
              Shadow(
                  offset: Offset(0, 1), blurRadius: 0.0, color: Colors.black26)
            ]),
      ),
    );
  }

  //
  static BoxDecoration roundedBorder(double radius,
      {Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: borderColor));
  }

  static BoxDecoration roundedBorderWithColor(
      double radius, Color backgroundColor,
      {Color borderColor = Colors.black}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: borderColor),
        color: backgroundColor);
  }

  static BoxDecoration roundedLineBorderWithColor(
      double radius, Color backgroundColor, double wid,
      {Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: wid, color: borderColor),
        color: backgroundColor);
  }

  static BoxDecoration roundedActiveButtonLineBorderWithGradient(
      double radius, double wid,
      {Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [Color(0xFFFFF7B2), Color(0xFFFFC46B)]),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: wid, color: borderColor));
  }

  static BoxDecoration roundedButtonWithGradient(
      double radius, List<Color> colors) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.9],
            colors: colors),
        borderRadius: BorderRadius.circular(radius));
  }

 static BoxDecoration rowSeperator(Color bgcolor) {
    return BoxDecoration(border: Border(bottom: BorderSide(color: bgcolor, width: 2)));
  }


  static BoxDecoration roundedBorderWithColorWithShadow(
      double radius, Color backgroundColor,
      {Color borderColor = Colors.transparent}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: borderColor),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 1),
            blurRadius: 2.0,
          )
        ]);
  }

  static BoxDecoration addShadow() {
    return BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 1),
        blurRadius: 2.0,
      )
    ]);
  }

  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return activeColor;
  }

  static Widget addHeader(
      BuildContext context, String title, bool isBackBtnVisible) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: [
          isBackBtnVisible
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                )
              : SizedBox(),
          Text(title).bold().fontSize(16),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  static Widget addHeaderNew(
      BuildContext context, String title, bool isBackBtnVisible) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: [
          // isBackBtnVisiblet
          //     ? GestureDetector(
          //         onTap: () {
          //           Get.back();
          //         },
          //         child: Icon(
          //           Icons.arrow_back_ios,
          //           size: 20,
          //         ),
          //       )
          //: SizedBox(),
          Text(title).bold().fontSize(16),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  static ExtendedImage getImage(String image_url, double width, double height) {
    // image_url = 'https://smartcitylands.com/wp-content/uploads/WPL/users/4/profile.jpg';
    print('image_url >> $image_url');
    return ExtendedImage.network(image_url,
        width: width,
        height: height,
        cache: true,
        fit: BoxFit.cover, loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Container(
            width: width,
            height: height,
            color: subtleColor,
            child: Shimmer.fromColors(
              baseColor: subtleColor,
              highlightColor: activeColor,
              child: Icon(Icons.refresh),
            ),
          );
          break;
        case LoadState.completed:
          return ExtendedRawImage(
            fit: BoxFit.cover,
            image: state.extendedImageInfo?.image,
            width: width,
            height: height,
          );
          break;
        case LoadState.failed:
          return Container(
            color: Colors.black12,
            width: width,
            height: height,
          );
          break;
      }
    });
  }

  static Future<dynamic> showAlertDialog(
      BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static rowRightBorder() {}
}
