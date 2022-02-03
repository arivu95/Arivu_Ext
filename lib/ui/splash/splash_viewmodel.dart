import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class SplashViewModel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();

  Future<bool> checkUserLoggedIn() async {
    return Future.delayed(const Duration(seconds: 3), () async {
      bool isLoggedIn = await preferencesService.isUserLoggedIn();
      return isLoggedIn;
    });
  }

  Future<bool> checkUserExist() async {
    String oid = await preferencesService.getUserInfo('userkey');
    if (oid.length > 0) {
      final response = await apiService.checkUserExist(oid);
return response;

    }

    return false;
  }
}
