import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class AddRoleListViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> role = [];
  List<dynamic> roleSections = [];

  Future getroleList() async {
    setBusy(true);
    role = await apiService.getroleList();
    roleSections = role.toList();
    print(role.toString());
    setBusy(false);
  }

  Future<bool> addrole(Map<String, dynamic> postParams) async {
    setBusy(true);
    final response = await apiService.addrole(postParams);
    if (response['_id'] != null) {
      print(response);
      setBusy(false);
      return true;
    }
    setBusy(false);
    return false;
  }
}
