import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class PlanListViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> plan = [];
  List<dynamic> planSections = [];
  List<dynamic> planSec = [];
  int pageno = 1;

  Future getplan() async {
    setBusy(true);
    plan = await apiService.getauditList();
    planSections = plan.toList();
    planSec = plan.toList();
    await auditList(1);
    setBusy(false);
  }

  void getPlan_search(String search) {
    planSec = planSections.where((e) {
      return e['name']
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()) ||
          e['email'].toString().toLowerCase().contains(search.toLowerCase()) ||
          e['mobile_number']
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase());
    }).toList();
    auditList(pageno);
    setBusy(false);
  }

  Future getdatefilter(String start, String end) async {
    setBusy(true);
    planSec = await apiService.getdatefilter(start, end);
    auditList(1);
    setBusy(false);
  }

  Future auditList(int page) async {
    plan.clear();
    pageno = page;
    int startIndex = (page - 1) * 15;
    int endIndex = startIndex + 15;

    if (page == 1 && planSec.length < 16) {
      plan = planSec.toList();
    } else {
      for (int i = startIndex; i < endIndex; i++) {
        plan.add(planSec[i]);
      }
    }
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
