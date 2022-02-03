import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class VaccinationCountryViewModel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> vaccines = [];
  List<dynamic> vaccineSections = [];
  List<dynamic> listvaccine = [];
 List<dynamic> listvaccineSections = [];
  Future getMasterVaccines() async {
    setBusy(true);
   String countryCode = preferencesService.select_covid_countryId;
    vaccines = await apiService.getCountry_vaccine(countryCode);
    vaccineSections = vaccines.toList();
    setBusy(false);
  }

  void vaccineTest_search(String search) {
    vaccines = vaccineSections.where((e) {
      return e['vaccine_name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
 setBusy(false);
  }

Future getuservaccinetype() async {
    setBusy(true);
    listvaccine = await apiService.getuservaccinetype();
    listvaccineSections = listvaccine.toList();
    setBusy(false);
  }

 void getvaccine_search(String search) {
    listvaccine = listvaccineSections.where((e) {
      return e['vaccine_name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
 setBusy(false);
  }

 Future addnewvaccine(String vaccine) async {
    setBusy(true);
    final response = await apiService.addnewvaccine(vaccine);
    await getuservaccinetype();
     preferencesService.onRefreshData!.value = true;
    setBusy(false);
  }
 
 Future vaccineEdit(String docid, String vaccinename) async {
    setBusy(true);
    final response = await apiService.edit_master_vaccine(docid, vaccinename);
  await getuservaccinetype();
    preferencesService.onRefreshData!.value = true;
    setBusy(false);
  }

   Future vaccinedelete(String docid) async {
    setBusy(true);
    final response = await apiService.delete_master_vaccine(docid);
  await getuservaccinetype();
    preferencesService.onRefreshData!.value = true;
    setBusy(false);
  }
}
