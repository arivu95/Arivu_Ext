import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaradmin/app/locator.dart';

import 'package:swaradmin/ui/Subscription_and_payment/plan_list_view.dart';
import 'package:swaradmin/ui/audit_management/audit_list_view.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_view.dart';
import 'package:swaradmin/ui/covid_management/covid_countries_view.dart';
import 'package:swaradmin/ui/covid_management/vaccine_test_view.dart';
import 'package:swaradmin/ui/dashboard/admin_dashboard.dart';
import 'package:swaradmin/ui/role_management/add_adminuser_view.dart';
import 'package:swaradmin/ui/role_management/add_role_view.dart';
import 'package:swaradmin/ui/role_management/role_access_list_view.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view.dart';
import 'package:swaradmin/ui/splash/signout_view.dart';
import 'package:swaradmin/ui/splash/splash_view.dart';
import 'package:swaradmin/ui/splash/start_view.dart';
import 'package:swaradmin/ui/splash/start_view_web.dart';
import 'package:swaradmin/ui/user_management/user_list_view.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_list_view.dart';
import 'package:swaradmin/ui/vaccination_management/vaccination_country_view.dart';
import 'package:swaradmin/ui/vaccination_management/vaccine_widget_view.dart';
import 'ui/Tables/Role Management/role_management.dart';
import 'ui/Tables/Subscription and payment/Subscriptionandpayment.dart';
//testt
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(SwarAdmin());
}

class SwarAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      //home: Dashboard(),
      routes: {
        StartViewWeb.id: (context) => StartViewWeb(),
        SplashView.id: (context) => SplashView(),
        Dashboard.id: (context) => Dashboard(),
        UsersListView.id: (context) => UsersListView(),
        AgeVaccinationView.id: (context) => AgeVaccinationView(),
        VaccineCommonView.id: (context) => VaccineCommonView(),
        VaccineTestView.id: (context) => VaccineTestView(),
        AddCovidRecords.id: (context) => AddCovidRecords(),
        RoleManagement.id: (context) => RoleManagement(),
        SubscriptionandPayments.id: (context) => SubscriptionandPayments(),
        PlanListView.id: (context) => PlanListView(),
        AuditListView.id: (context) => AuditListView(),
        RoleManagementListView.id: (context) => RoleManagementListView(),
        AddAdminUserView.id: (context) => AddAdminUserView(),
        AddRoleView.id: (context) => AddRoleView(),
        SignoutView.id: (context) => SignoutView(),
        UserControl.id: (context) => UserControl(),
        VaccineCountryControl.id: (context) => VaccineCountryControl(),
        MasterRole.id: (context) => MasterRole(),
        RoleListViewControl.id: (context) => RoleListViewControl(),
        PlanListViewControl.id: (context) => PlanListViewControl(),
        AuditListViewControl.id: (context) => AuditListViewControl(),
      },
    );
  }
}
