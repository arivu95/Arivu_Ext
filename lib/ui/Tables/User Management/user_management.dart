import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/ui/user_management/user_list_view.dart';

//import 'User_Management_View.dart';

class UserManagment extends StatelessWidget {
  static const String id = 'user-management';
 
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      backgroundColor: Colors.white,
        appBar: _appBar.AppBarMenus(),
         sideBar: _sideBar.sideBarMenus(context, UserManagment.id),
      body: Container(
        child: Center(
          child: UsersListView(),
        ),
      ),
    );
  }
}
