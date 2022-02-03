import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swaradmin/frideos/streamed_map.dart';
import 'package:swaradmin/frideos/streamed_value.dart';
import 'package:swaradmin/services/api_services.dart';

class PreferencesService {
  String userId = '';
  String email = '';
  String country = '';
  String country_id = "602dde0764f3802c6453641b";
  String phone = '';
  String logintoken = '';
  String user_country = '';
  String user_country_id = '';
  String user_country_flag = '';

  String roleManagementId = '';
  String select_covid_countryId = '';
  String select_master_countryId = '';
  RxBool isReload = false.obs;

   Map<String, dynamic> adminInfo = {};
   Map<String, dynamic> user_accessInfo = {};
   Map<String, dynamic> vaccine_accessInfo = {};
   Map<String, dynamic> covid_accessInfo = {};
   Map<String, dynamic> role_accessInfo = {};
   Map<String, dynamic> subscription_accessInfo = {};

 Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userkey') ?? '';
    if (token != '') {
      return true;
    }
    return false;
  }

 Future<bool> setUserInfo(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

  Future<String> getUserInfo(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(key) ?? '';
    if (userid != '') {
      return userid;
    }
    return '';
  }

Future<bool> setAdminInfo(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

Future<String> getAdminInfo(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rolename = prefs.getString(key) ?? '';
    if (rolename != '') {
      return rolename;
    }
    return '';
  }

  Future<bool> setAccessInfo(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

Future<String> getAccessInfo(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rolename = prefs.getString(key) ?? '';
    if (rolename != '') {
      return rolename;
    }
    return '';
  }

  Future cleanAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('oid');
    await prefs.remove('userkey');
    await prefs.remove('countryCode');
    await prefs.remove('swartoken');
    await prefs.remove('refreshtoken');
    phone = '';
    email = '';
  
}
   StreamedValue<bool>? onRefreshData = null;
   
    void initRefreshData() {
    onRefreshData = StreamedValue<bool>(initialData: false);
  } 

}

class _setValue {
}
