import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class AddvaccineViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();

  List<dynamic> coviddose = [];
  List<dynamic> covidvaccine = [];

  List<dynamic> countrySections = [];
  List<dynamic> vaccines = [];
  List<dynamic> vaccineSections = [];
  List<dynamic> labtest = [];
  List<dynamic> labtestSections = [];

  Future getCovidVaccines() async {
    setBusy(true);
    String country_id = preferencesService.country_id;
    vaccines = await apiService.getCountry_vaccine(country_id);
    vaccineSections = vaccines.toList();
    setBusy(false);
  }

  Future addCovidtest(String covidTest) async {
    setBusy(true);
    String country_id = preferencesService.country_id;
    final response = await apiService.addCovidtest(covidTest, country_id);
    await getCovidLabtest();
    setBusy(false);
  }

  Future getCovidLabtest() async {
    setBusy(true);
    String country_id = preferencesService.country_id;
    labtest = await apiService.getCountry_labtest(country_id);
    labtestSections = labtest.toList();
    setBusy(false);
  }

  void vaccineTest_search(String search) {
    vaccines = vaccineSections.where((e) {
      return e //['vaccination_name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    labtest = labtestSections.where((e) {
      return e //['test_name']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    setBusy(false);
  }

  Future edit_covid_vaccineName(String vaccineId, String vaccinename) async {
    setBusy(true);
    final response =
        await apiService.edit_covid_vaccineName(vaccineId, vaccinename);
    await getCovidVaccines();
    setBusy(false);
  }

  Future delete_covid_vaccine(String vacc_id) async {
    setBusy(true);
    final response = await apiService.delete_covid_Vaccine(vacc_id);
    await getCovidVaccines();
    setBusy(false);
  }

  Future delete_covid_Vaccine_dose(String vacc_id, String dode_id) async {
    setBusy(true);
    final response =
        await apiService.delete_covid_Vaccine_dose(vacc_id, dode_id);
    await getCovidVaccines();
    setBusy(false);
  }

  Future edit_covid_testName(String testid, String testname) async {
    setBusy(true);
    final response = await apiService.edit_covid_testName(testid, testname);
    await getCovidLabtest();
    setBusy(false);
  }

  Future delete_covid_testName(String testid) async {
    setBusy(true);
    final response = await apiService.delete_covid_testName(testid);
    await getCovidLabtest();
    setBusy(false);
  }

  Future getdoselist() async {
    setBusy(true);
    coviddose = await apiService.getdoeslist();
    setBusy(false);
  }

  Future addCoviddose(String covidDose) async {
    setBusy(true);
    final response = await apiService.addCovidDose(covidDose);
    await getdoselist();
    setBusy(false);
  }

  Future covidaddvaccine(List<String> docIds, String vaccine) async {
    setBusy(true);
    Map<String, dynamic> postParams = {};
    postParams['country_Id'] = preferencesService.country_id;
    postParams['vaccination_name'] = vaccine;
    postParams['covidDose_Id'] = docIds;
    await apiService.addcovidvaccine(postParams);
    setBusy(false);
  }

  Future covidvaccineupdated(
      String vaccineid, List<String> docIds, String vaccinename) async {
    setBusy(true);
    Map<String, dynamic> postParams = {};
    postParams['covidDose_Id'] = docIds;
    await apiService.edit_covid_vaccineName(vaccineid, vaccinename);
    await apiService.updatecovidvaccine(vaccineid, postParams);
    setBusy(false);
  }

  Future vaccinenameupdated(String vaccineid, String vaccinename) async {
    setBusy(true);
    await apiService.edit_covid_vaccineName(vaccineid, vaccinename);
    setBusy(false);
  }

  Future coviddoseupdated(String doseid, String dosename) async {
    setBusy(true);
    final response = await apiService.edit_covid_dose(doseid, dosename);
    await getdoselist();
    setBusy(false);
  }

  Future coviddosedelete(String doseid) async {
    setBusy(true);
    final response = await apiService.delete_covid_dose(doseid);
    await getdoselist();
    setBusy(false);
  }
}
