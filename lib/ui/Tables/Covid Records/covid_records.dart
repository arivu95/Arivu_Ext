import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/sidebar.dart';

//import 'package:swaradmin/ui/Tables/Vaccination/vaccination_view.dart';

import 'covid_record_view.dart';

class CovidRecordss extends StatelessWidget {
  static const String id = 'covid-management';
  //const UserManagment({Key? key}) : super(key: key) testd;

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
      swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: _appBar.AppBarMenus(),
       sideBar: _sideBar.sideBarMenus(context, CovidRecordss.id),
      body: Container(
        child: Center(
          child: CovidTable(),
        ),
      ),
    );
  }
}
