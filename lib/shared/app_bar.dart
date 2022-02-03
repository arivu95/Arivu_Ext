import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_barmodel.dart';
import 'package:swaradmin/shared/app_colors.dart';

class swaradminBar {
  AppBarMenus() {
    return  AppBar(
            backgroundColor: activeColor,
            actions: [
              ViewModelBuilder<AppBarmodel>.reactive(
        onModelReady: (model) async {
          await model.init();
        },
        builder: (context, model, child) {
          return
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 5),
                child: new Text(
                  model.role,
                //'',
                  textScaleFactor: 1.5,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
              },        viewModelBuilder: () => AppBarmodel()),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:
                    Icon(Icons.account_circle, size: 50, color: Colors.white),
              ),
            ],
          );
      }
}
