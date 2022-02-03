import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class RoleViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> recentDatas = [];
  List<dynamic> listrole = [];
  List<dynamic> listroleSections = [];
  dynamic role = {};
  dynamic user = {};

  Future getrole() async {
    setBusy(true);
    String ID = preferencesService.roleManagementId;
    role = await apiService.getparticularrole(ID);
    if (role['usermanagement'] != null) {
      user = role['usermanagement'][0];
      user['name'] = "User Management";
      recentDatas.add(user);
    }

    if (role['vaccination'] != null) {
      user = role['vaccination'][0];
      user['name'] = "Vaccination";
      recentDatas.add(user);
    }

    if (role['covidrecords'] != null) {
      user = role['covidrecords'][0];
      user['name'] = "Covid Records";
      recentDatas.add(user);
    }

    if (role['rolemanagement'] != null) {
      user = role['rolemanagement'][0];
      user['name'] = "Role Management";
      recentDatas.add(user);
    }

    if (role['subscriptionandpayments'] != null) {
      user = role['subscriptionandpayments'][0];
      user['name'] = "Subscription & Payments";
      recentDatas.add(user);
    }
    listroleSections=recentDatas.toList();
    print(role.toString());
    setBusy(false);
  }

  Future editrole(String roleId, String rolepermission) async {
    setBusy(true);
    final response =
        await apiService.editparticularrole(roleId, rolepermission);
    await getrole();
    setBusy(false);
  }

  void getrole_search(String search) {
    recentDatas = listroleSections.where((e) {
      return e['name'].toString().toLowerCase().contains(search.toLowerCase());
    }).toList();
    setBusy(false);
  }

   Future<bool> updaterolemanagement(String name,String view,String add,String edit,String delete) async {
    setBusy(true);
    Map<String, dynamic> postParams = {};
     String ID = preferencesService.roleManagementId;
     postParams['name'] = name;
     postParams['view'] = view;
     postParams['add'] = add;
     postParams['edit'] = edit;
     postParams['delete'] = delete;
    final response = await apiService.updaterole(ID, postParams);
    recentDatas.clear();
      await getrole();
    if (response['_id'] != null) {
      print(response);
      setBusy(false);
      return true;
    }
  
    setBusy(false);
    return false;
  }
}
