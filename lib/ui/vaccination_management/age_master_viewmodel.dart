import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class AddMasterVaccineViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> countries = [];
  List<dynamic> uservaccine = [];
  List<dynamic> uservaccineage = [];
  List<dynamic> uservaccinetype = [];
  List<dynamic> vaccinenew = [];
  List<dynamic> memberSections = [];
 

  /////////////////// User Vaccine /////////////////////////

Future init() async {
    preferencesService.initRefreshData();
    preferencesService.onRefreshData!.onChange((isRefresh) {
      if (isRefresh) {
        preferencesService.onRefreshData!.value = false;
        getuservaccinelist();
        getuservaccinetype();
      }
    });
  }

  // get user vaccine
  Future getuservaccinelist() async {
    setBusy(true);
     String country_id=preferencesService.country_id;
    uservaccine = await apiService.getuservaccinelist(country_id);
    await getuservaccinetype();
    setBusy(false);
  }

Future addmastervaccine(String vaccineid, String age) async {
    setBusy(true);
     String country_id=preferencesService.country_id;
    final response = await apiService.adddvaccination(country_id, vaccineid,age);
    setBusy(false);
  }
  
  
  Future getuservaccinetype() async {
    setBusy(true);
    vaccinenew = await apiService.getuservaccinetype();
    print(vaccinenew);
    setBusy(false);
  }


  // Future getCountries() async {
  //   setBusy(true);
  //   countries = await apiService.getCountries();
  //   await getuservaccinelist();
  //   await getuservaccinetype();
  //   setBusy(false);
  // }

  

  
  Future mastervaccineupdated(String masterid, String vaccineid) async {
    setBusy(true);
    final response = await apiService.updatevaccine(masterid, vaccineid);
    setBusy(false);
  }

 

}
