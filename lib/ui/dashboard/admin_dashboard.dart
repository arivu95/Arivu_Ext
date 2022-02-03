import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/ui/dashboard/pie_chart.dart';

class Dashboard extends StatelessWidget {
  static const String id = 'home-screen';
  PreferencesService preferencesService = locator<PreferencesService>();
  //const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      //backgroundColor: activeColor,
      appBar: _appBar.AppBarMenus(),
      sideBar: _sideBar.sideBarMenus(context, Dashboard.id),
      body: Container(
        //    padding: EdgeInsets.all(25),
        child: PieChartNew(),
      ),
    );
  }
}
