import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_viewmodel.dart';

class withoutAccess extends StatefulWidget {
  withoutAccess({Key? key}) : super(key: key);
  @override
  _withoutAccessState createState() => _withoutAccessState();
}

class _withoutAccessState extends State<withoutAccess> {


  @override
  Widget build(BuildContext context) {
    return Container(
       width: Screen.width(context),
     child: Center(
       child: Text('You dont Have access!').textColor(activeColor).fontSize(18).fontWeight(FontWeight.w600),
    )
               
             
    );
  }
}
