import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class VaccineAgeViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> vaccines = [];
  List<dynamic> vaccineSections = [];
 
   Future getAgeVaccines() async {
    setBusy(true);
   String country_id=preferencesService.country_id;
 vaccines = await apiService.getuservaccinelist(country_id);
    vaccineSections = vaccines.toList();
    setBusy(false);
  }


  void vaccineTest_search(String search) {
    vaccines = vaccineSections.where((e) {
      return e
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
  setBusy(false);
  }

   Future edit_age_vaccineName(String vaccineId, String age) async {
    setBusy(true);
    final response = await apiService.edit_age_vaccineName(vaccineId,age);
    await getAgeVaccines();
    setBusy(false);
  }

    Future delete_age_vaccine(String vacc_id) async {
    setBusy(true);
    final response = await apiService.delete_age_Vaccine(vacc_id);
   await getAgeVaccines();
    setBusy(false);
  }

  Future delete_inner_vaccine(String vacc_id, String doc_id) async {
    setBusy(true);
    final response = await apiService.delete_inner_Vaccine(vacc_id, doc_id);
  await getAgeVaccines();
    setBusy(false);
  }
}
