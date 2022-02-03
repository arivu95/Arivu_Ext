import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class UserdetailsViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> members = [];
  List<dynamic> memberSections = [];
  List<dynamic> countries = [];
  List<dynamic> labtestSections = [];
  List<dynamic> countrySections = [];

  Future getCountries() async {
    setBusy(true);
    countries = await apiService.getcovidCountries();
    countrySections = countries.toList();
    setBusy(false);
  }

  Future getmembers(String userId) async {
    setBusy(true);

    members = await apiService.getUserMembersList(userId);
    memberSections = members.toList();
    setBusy(false);
  }
  void members_asc_sort() {
    members.sort((a, b) {
      return a['name']
          .toString()
          .toLowerCase()
          .compareTo(b['name'].toString().toLowerCase());
    });
    setBusy(false);
  }

  void members_desc_sort() {
    members.sort((a, b) {
      return b['name']
          .toString()
          .toLowerCase()
          .compareTo(a['name'].toString().toLowerCase());
    });
    setBusy(false);
  }

}
