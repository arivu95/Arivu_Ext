import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class UserSelectViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> listusers = [];
  // List<dynamic> userInfo = [];
  //List<dynamic> languages = [];

  Future getuserList(bool isReload) async {
    if (isReload) {
      setBusy(true);
    }

  // List user = await apiService.getUserList(userId);

    ///  List userData = await apiService.getUsersData(userId);
    //List products = [];
    // if (userData.length > 0) {
    // for (final gtlst in user_Data) {
    //   if (gtlst.length > 0) {
    //     var productMap = {
    //       'get_id': gtlst['_id'],
    //       'get_azure_link': gtlst['azureBlobStorageLink'],
    //       'get_name': gtlst['name'],
    //     };
    //     products.add(productMap);
    //   }
    // }
    // print(products.toString());
    // }
    //  listmembers.clear();
    // if (user.length > 0) {
    //   for (var i = 0; i < user.length; i++) {
        // tot_count = '';
        // if (products.length > 0) {
        //   outputList = products
        //       .where((o) => o['get_id'] == members[i]['user_Id'])
        //       .toList();
        //   if (outputList.length != 0) {
        //     usr_img = outputList[0]['get_azure_link'].toString();
        //     usr_name = outputList[0]['get_name'].toString();
        //     tot_count = members[i]['comments'].length.toString();
        //     members[i]['profile_img'] = usr_img;
        //     members[i]['profile_name'] = usr_name;
        //     members[i]['count'] = tot_count;
        //     listmembers.add(members[i]);
        //   } else {
        //     listmembers.add(members[i]);
        //   }
        //  } else {
        //  if (user[i]['feeds_category'] == "invite") {
       // listusers.add(user[i]);
        // }
        print(listusers.toString());
      }
    }
 // }

  getUserInfo() {}
  //  setBusy(false);
//}
  // Future getuserInfo() async {
  //   setBusy(true);
  //   userInfo = await apiService.getuserInfo();
  //   // await getLanguages();
  //   setBusy(false);
  // }

  //Future getLanguages() async {
  //languages = await apiService.getLanguages();
  //}

