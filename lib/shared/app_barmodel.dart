import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class AppBarmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  String role ='';

   Future init() async {
    setBusy(true);
    role = await preferencesService.getAdminInfo('role');
    // User Access
    String userview = await preferencesService.getAccessInfo('user_view_access');
    String useredit = await preferencesService.getAccessInfo('user_edit_access');
    String useradd = await preferencesService.getAccessInfo('user_add_access');
    String userdelete = await preferencesService.getAccessInfo('user_delete_access');
     preferencesService.user_accessInfo={'view':userview,'edit':useredit,'add':useradd,'delete':userdelete};
  // Vaccine Access
     String vaccview = await preferencesService.getAccessInfo('vacc_view_access');
    String vaccedit = await preferencesService.getAccessInfo('vacc_edit_access');
    String vaccadd = await preferencesService.getAccessInfo('vacc_add_access');
    String vaccdelete = await preferencesService.getAccessInfo('vacc_delete_access');
     preferencesService.vaccine_accessInfo={'view':vaccview,'edit':vaccedit,'add':vaccadd,'delete':vaccdelete};
  // Covid Access
    String covidview = await preferencesService.getAccessInfo('user_view_access');
    String covidedit = await preferencesService.getAccessInfo('user_edit_access');
    String covidadd = await preferencesService.getAccessInfo('user_add_access');
    String coviddelete = await preferencesService.getAccessInfo('user_delete_access');
     preferencesService.covid_accessInfo={'view':covidview,'edit':covidedit,'add':covidadd,'delete':coviddelete};
  // Role Access
     String roleview = await preferencesService.getAccessInfo('vacc_view_access');
    String roleedit = await preferencesService.getAccessInfo('vacc_edit_access');
    String roleadd = await preferencesService.getAccessInfo('vacc_add_access');
    String roledelete = await preferencesService.getAccessInfo('vacc_delete_access');
     preferencesService.role_accessInfo={'view':roleview,'edit':roleedit,'add':roleadd,'delete':roledelete};
    // Subscription Access
   String subsview = await preferencesService.getAccessInfo('user_view_access');
    String subsedit = await preferencesService.getAccessInfo('user_edit_access');
    String subsadd = await preferencesService.getAccessInfo('user_add_access');
    String subsdelete = await preferencesService.getAccessInfo('user_delete_access');
     preferencesService.subscription_accessInfo={'view':subsview,'edit':subsedit,'add':subsadd,'delete':subsdelete};
 
   setBusy(false);
  }

}
