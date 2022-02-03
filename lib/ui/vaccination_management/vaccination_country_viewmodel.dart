import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class VaccinationcountryViewModel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  List<dynamic> countries = [];
  List<dynamic> countrySections = [];
 
  //// Get Master Vaccine Countries ////
  Future getCountries() async {
    setBusy(true);
    countries = await apiService.getmasterCountries();
    countrySections = countries.toList();
    setBusy(false);
  }

  
  void getcountry_search(String search) {
    countries = countrySections.where((e) {
      return e['country']
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
 setBusy(false);
  }


}
