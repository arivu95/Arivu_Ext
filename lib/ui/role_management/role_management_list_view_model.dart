import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class RoleListViewmodel extends BaseViewModel {
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

  Future<bool> addadminuser(Map<String, dynamic> postParams) async {
    setBusy(true);
    final response = await apiService.addadminuser(postParams);
    if (response['name'] != null) {
      print(response);
      setBusy(false);
      return true;
    }
    setBusy(false);
    return false;
  }

  void getRole_search(String search) {
    role = roleSections.where((e) {
      return e['admin_role_name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
    setBusy(false);
  }

  Future delete_roles(String roleid) async {
    setBusy(true);
    final response = await apiService.delete_roles(roleid);
    await getroleList();
    setBusy(false);
  }

  void role_asc_sort() {
    role.sort((a, b) {
      return a['admin_role_name']
          .toString()
          .toLowerCase()
          .compareTo(b['admin_role_name'].toString().toLowerCase());
    });
    setBusy(false);
  }

  void role_desc_sort() {
    role.sort((a, b) {
      return b['admin_role_name']
          .toString()
          .toLowerCase()
          .compareTo(a['admin_role_name'].toString().toLowerCase());
    });
    setBusy(false);
  }

  Future<bool> updaterolemanagement(String id, String name) async {
    setBusy(true);
    Map<String, dynamic> postParams = {};
    postParams['admin_role_name'] = name;
    final response = await apiService.updaterole(id, postParams);
    await getroleList();
    setBusy(false);
    return false;
  }
}
