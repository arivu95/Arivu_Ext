import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/ui/Subscription_and_payment/plan_list_view.dart';
import 'package:swaradmin/ui/audit_management/audit_list_view.dart';
import 'package:swaradmin/ui/covid_management/vaccine_test_view.dart';
import 'package:swaradmin/ui/dashboard/admin_dashboard.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view.dart';
import 'package:swaradmin/ui/splash/signout_view.dart';
import 'package:swaradmin/ui/user_management/user_list_view.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_list_view.dart';

//test
class SideBarWidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      backgroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.black, fontSize: 14),
      activeTextStyle: TextStyle(
        color: activeColor,
        fontSize: 16,
      ),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: Dashboard.id,
          icon: (Icons.donut_small_outlined),
        ),
        MenuItem(
          title: 'User Management',
          route: UserControl.id,
          icon: (CupertinoIcons.person_2),
        ),
        MenuItem(
          title: 'Vaccination',
          route: AgeVaccinationView.id,
          icon: (Icons.medication_outlined),
        ),
        MenuItem(
          title: 'Covid Records',
          route: VaccineTestView.id,
          icon: (Icons.description_outlined),
        ),
        MenuItem(
          title: 'Audit Log',
          route: AuditListViewControl.id,
          icon: (Icons.money_off_csred_outlined),
        ),
        MenuItem(
          title: 'Settings',
          route: SignoutView.id,
          icon: (Icons.settings_outlined),
          children: [
            MenuItem(
              // title: 'Subsription & Payment',
              // route: PlanListView.id,
              // icon: (Icons.payment),
              title: 'Subscription & Payment',
              route: PlanListViewControl.id,
              icon: (Icons.payment),
            ),
            MenuItem(
                title: 'Role Management',
                route: RoleListViewControl.id,
                icon: (Icons.manage_accounts_outlined)),
          ],
        ),
        MenuItem(
          title: 'Signout',
          route: SignoutView.id,
          icon: (Icons.logout),
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Image.asset(
              'assets/swar_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
