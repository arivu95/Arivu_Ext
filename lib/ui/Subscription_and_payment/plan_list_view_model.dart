import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class PlanListViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> plan = [];
  List<dynamic> planSections = [];

  Future getplan() async {
    setBusy(true);
    plan = await apiService.getplanList();
    planSections = plan.toList();
    print(plan.toString());
    setBusy(false);
  }

  void getPlan_search(String search) {
    plan = planSections.where((e) {
      return e //['subscription_plan']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
    // recentFamily.add({});
    setBusy(false);
  }

  Future edit_plan_list(String id, String planname) async {
    setBusy(true);
    final response = await apiService.edit_plan_list(id, planname);
    await getplan();
    setBusy(false);
  }

  Future delete_plan(String _id) async {
    setBusy(true);
    final response = await apiService.delete_plan(_id);
    await getplan();
    setBusy(false);
  }

  void plans_asc_sort() {
    plan.sort((a, b) {
      return a['subscription_plan']
          .toString()
          .toLowerCase()
          .compareTo(b['subscription_plan'].toString().toLowerCase());
    });
    setBusy(false);
  }

  void plans_desc_sort() {
    plan.sort((a, b) {
      return b['subscription_plan']
          .toString()
          .toLowerCase()
          .compareTo(a['subscription_plan'].toString().toLowerCase());
    });
    setBusy(false);
  }
}
