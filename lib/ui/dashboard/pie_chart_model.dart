import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class PiechartViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  dynamic members = {};
  dynamic subsccription = {};
  double act_count = 0;
  double deact_count = 0;
  double free_user = 0;
  double paid_user = 0;

  Future getmemberscount() async {
    setBusy(true);
    members = await apiService.getUserCountList();
    if (members.length > 0) {
      act_count = members['user_active_count'];
      deact_count = members['user_deactive_count'];
    }
    await getstoragecount();
    setBusy(false);
  }

  Future getstoragecount() async {
    setBusy(true);
    subsccription = await apiService.getUsersubsscriptionList();
    if (subsccription.length > 0) {
      free_user = subsccription['basic_plan_count'];
      paid_user = subsccription['paid_plan_count'];
    }
    setBusy(false);
  }
}
