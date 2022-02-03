import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class AddPlanViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();

  List<dynamic> countries = [];
  List<dynamic> coviddose = [];
  List<dynamic> covidvaccine = [];

  Future getCountries() async {
    setBusy(true);
    countries = await apiService.getCountries();
    await getdoselist();
    setBusy(false);
  }

  Future getdoselist() async {
    setBusy(true);
    coviddose = await apiService.getdoeslist();
    setBusy(false);
  }

  Future getvaccinelist(String countryid) async {
    setBusy(true);
    covidvaccine = await apiService.getcovidvaccinelist(countryid);
    setBusy(false);
  }

  Future addCoviddose(String covidDose) async {
    setBusy(true);
    final response = await apiService.addCovidDose(covidDose);
    await getdoselist();
    setBusy(false);
  }

  Future<bool> addplan(Map<String, dynamic> postParams) async {
    setBusy(true);
    final response = await apiService.addplan(postParams);
    if (response['_id'] != null) {
      print(response);
      setBusy(false);
      return true;
    }
    setBusy(false);
    return false;
  }
  // Future addplan(
  //     String planname, planstatus, validity, price) async {
  //   setBusy(true);
  //   final response =
  //       await apiService.addplan(planname, planstatus, validity, price);
  //   setBusy(false);
  // }

  

}






// // TODO Implement this library.
// import 'package:stacked/stacked.dart';
// import 'package:swaradmin/app/locator.dart';
// import 'package:swaradmin/services/api_services.dart';
// import 'package:swaradmin/services/preferences_service.dart';

// class AddPlanViewmodel extends BaseViewModel {
//   PreferencesService preferencesService = locator<PreferencesService>();
//   ApiService apiService = locator<ApiService>();
//   // String res = "";
//   //List<dynamic> selectedplan = [];

//   // Future addAdminPlanModel(List<String> docIds) async {
//   //   List<String> users = selectedplan.map((e) {
//   //     return e['_id'].toString();
//   //   }).toList();
//   //   Map<String, dynamic> postParams = {};
//   //   final response = await apiService.addAdminPlan(postParams);
//   //   print(response);
//   // }

//   // Future<bool> registerPlans(postParams) async {
//   //   //postParams['subscription_plan '] = preferencesService.subscription_plan;
//   //   // preferencesService.email = preferencesService.userInfo['email'];
//   //   setBusy(true);
//   //   //print('model response-------------->'+response.length.toString());

//   //   final response = await apiService.registerPlans(postParams);
//   //   print(postParams);
//   //   setBusy(false);
//   //   return false;
//   // }

//   Future<bool> registerPlans(
//     Map<String, dynamic> postParams,
//   ) async {
//     setBusy(true);
//     final response = await apiService.registerPlans(postParams);
//     if (response['subscription_plan'] != null) {
//       preferencesService.subscription_plan = response;
//       preferencesService.subscription_plan =
//           preferencesService.subscription_plan;
//       preferencesService.subscription_plan = response['subscription_plan'];
//       // if (response['azureBlobStorageLink'] != null) {}
//       print(response);
//       setBusy(false);
//       return true;
//     }
//     setBusy(false);
//     return false;
//   }

// // Future updateMemberProfile(String memberId,Map<String, dynamic> memberInfo, String profileImagePath) async {
// //     setBusy(true);
// //      final response = await apiService.updateMemberProfile(memberId, memberInfo, profileImagePath);
// //     setBusy(false);
// //   }

// }
