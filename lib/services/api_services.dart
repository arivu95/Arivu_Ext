import 'package:dio/dio.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:dio/src/form_data.dart' as FormData1;
import 'package:dio/dio.dart' as Dio;

// const endPoint = 'https://apidev02.swardoctor.com/api';
//const endPoint = 'https://testapi02.swardoctor.com/api';
//const endPoint = 'https://prodapi01.swardoctor.com/api';
const endPoint = 'https://swar-api-prod01-test.azurewebsites.net/api';

class ApiService {
  // static String fileStorageEndPoint =
  //     'https://swartest.blob.core.windows.net/swardoctor/';

  static String fileStorageEndPoint =
      'https://swarprod01.blob.core.windows.net/swardoctor/';
  Dio.Dio client = new Dio.Dio();
  String token = '';
  bool is_feedCall = false;
  int intial_feed = 0;
  CancelToken cancel_Token = CancelToken();
  PreferencesService preferencesService = locator<PreferencesService>();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  ApiService() {
    client.options.baseUrl = endPoint;
    client.options.headers['content-type'] = 'application/json';

    client.interceptors
        .add(Dio.InterceptorsWrapper(onRequest: (request, handler) async {
      request.cancelToken = cancel_Token;
      if (request.extra['endpoint'] == null) {
        // token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNjE3YmQxY2I3NGZjMzQwMDJlOTYyODVlIiwiaWF0IjoxNjM3NzYyNTg2LCJleHAiOjE2Mzc4NDg5ODZ9.QsGaItWXSd8DvXIvjpPc6KJvdAOeDagT53NXDPUd1Iw";
        token = await locator<PreferencesService>().getUserInfo('swartoken');
        request.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(request);
    }, onError: (err, handler) async {
      if (err.response?.statusCode == 403) {
        // refresh token
        cancel_Token.cancel();
        String refreshToken =
            await locator<PreferencesService>().getUserInfo('refreshtoken');
        if (refreshToken.isNotEmpty) {
          client.lock();
          client.interceptors.requestLock.lock();
          client.interceptors.responseLock.lock();
          client.interceptors.errorLock.lock();
          String userId = preferencesService.userId;
          Dio.Dio refClient = new Dio.Dio();
          dynamic response = await refClient.post(
              '$endPoint/adminuser/userrefreshtoken',
              data: {'userId': userId, 'refreshToken': refreshToken},
              options: Dio.Options(extra: {'endpoint': 'access_token'}));
          if (response.data['refresh_token'] != null) {
            dynamic tokenObject = response.data['refresh_token'];
            if (tokenObject['accessToken'] != null) {
              await preferencesService.setUserInfo(
                  'swartoken', tokenObject['accessToken']);
              await preferencesService.setUserInfo(
                  'refreshtoken', tokenObject['refreshToken']);
              client.unlock();
              client.interceptors.requestLock.unlock();
              client.interceptors.responseLock.unlock();
              client.interceptors.errorLock.unlock();
              final opts = new Dio.Options(
                  method: err.requestOptions.method,
                  headers: err.requestOptions.headers);
              final cloneReq = await client.request(err.requestOptions.path,
                  options: opts,
                  data: err.requestOptions.data,
                  queryParameters: err.requestOptions.queryParameters);
              return handler.resolve(cloneReq);
            }
          }
        }
        return handler.reject(err);
        //
      } else if (err.response?.statusCode == 401) {
        // await locator<PreferencesService>().cleanAllPreferences();
        //  locator<NavigationService>().clearStackAndShow(RoutePaths.);
        //Navigator.of(context).pushNamed(StartView.id);
      }
      return handler.reject(err);
    }));

    client.interceptors.add(Dio.LogInterceptor(
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        requestBody: true));
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  //@@@@@@@@@@@@@----LogIn--------@@@@@@@@@@@@@
  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Future<bool> checkUserExist(String oid) async {
    try {
      var response = await client.get('$endPoint/adminuser/admincheck?$oid');
      if (response.statusCode == 200) {
        if (response.data['roledetail'] != null) {
          // preferencesService.vaccine_accessInfo= response.data['roledetail']['vaccination'][0];
          //preferencesService.covid_accessInfo= response.data['roledetail']['covidrecords'][0];
          //preferencesService.role_accessInfo= response.data['roledetail']['rolemanagement'][0];
          //preferencesService.subscription_accessInfo= response.data['roledetail']['subscriptionandpayments'][0];

          var userAccess = response.data['roledetail']['usermanagement'][0];
          var vaccineAccess = response.data['roledetail']['vaccination'][0];
          var covidAccess = response.data['roledetail']['covidrecords'][0];
          var roleAccess = response.data['roledetail']['rolemanagement'][0];
          var subscriptionAccess =
              response.data['roledetail']['subscriptionandpayments'][0];
          //User Access
          await preferencesService.setAccessInfo(
              'user_view_access', userAccess['view']);
          await preferencesService.setAccessInfo(
              'user_edit_access', userAccess['edit']);
          await preferencesService.setAccessInfo(
              'user_add_access', userAccess['add']);
          await preferencesService.setAccessInfo(
              'user_delete_access', userAccess['delete']);
          // Vaccine Access
          await preferencesService.setAccessInfo(
              'vacc_view_access', vaccineAccess['view']);
          await preferencesService.setAccessInfo(
              'vacc_edit_access', vaccineAccess['edit']);
          await preferencesService.setAccessInfo(
              'vacc_add_access', vaccineAccess['add']);
          await preferencesService.setAccessInfo(
              'vacc_delete_access', vaccineAccess['delete']);
          //Covid Access
          await preferencesService.setAccessInfo(
              'covid_view_access', covidAccess['view']);
          await preferencesService.setAccessInfo(
              'covid_edit_access', covidAccess['edit']);
          await preferencesService.setAccessInfo(
              'covid_add_access', covidAccess['add']);
          await preferencesService.setAccessInfo(
              'covid_delete_access', covidAccess['delete']);
          // Role Access
          await preferencesService.setAccessInfo(
              'role_view_access', roleAccess['view']);
          await preferencesService.setAccessInfo(
              'role_edit_access', roleAccess['edit']);
          await preferencesService.setAccessInfo(
              'role_add_access', roleAccess['add']);
          await preferencesService.setAccessInfo(
              'role_delete_access', roleAccess['delete']);
          // Subscription Access
          await preferencesService.setAccessInfo(
              'subs_view_access', subscriptionAccess['view']);
          await preferencesService.setAccessInfo(
              'subs_edit_access', subscriptionAccess['edit']);
          await preferencesService.setAccessInfo(
              'subs_add_access', subscriptionAccess['add']);
          await preferencesService.setAccessInfo(
              'subs_delete_access', subscriptionAccess['delete']);
        }
        if (response.data['user'] != null) {
          preferencesService.adminInfo = response.data['user'];
          await preferencesService.setAdminInfo(
              'role', response.data['user']['role']);
        }
        return true;
      } else {
        return false;
      }
    } on Dio.DioError catch (e) {
      print('===============deio=============');
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> tokenValidation(String azureToken) async {
    try {
      var response = await client.post('$endPoint/adminuser/tokenvalidation',
          data: {},
          options: Dio.Options(
              headers: {'Authorization': 'Bearer $azureToken'},
              extra: {'endpoint': 'access_token'}));
      // print("Tokenresponse----->"+response.data);
      return response.data;
    } on Dio.DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<dynamic> checkUserEmailExist(String email) async {
    try {
      print('-----------check user EMAIL exit--->>>>');
      var response =
          await client.get('$endPoint/adminuser/admincheck?email=$email');
      print('response===========' + response.data.toString());

      return response.data['msg'];
    } on Dio.DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> adminlogin(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);
      var formData = FormData.fromMap(post);
      var response =
          await client.post('$endPoint/adminuser/login', data: formData);
      if (response.statusCode == 200) {
        if (response.data['admin'] != null) {
          print(response.data['admin']);
          preferencesService.adminInfo = response.data['admin'];
        }
        if (response.data['token'] != null) {
          print(response.data['token']);
          preferencesService.logintoken = response.data['token'];
        }
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  //@@@@@@@@@@@@@----Dashboard-PieChart--------@@@@@@@@@@@@@
  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//get user count
  Future<dynamic> getUserCountList() async {
    try {
      var response =
          await client.get('$endPoint/auth/activeanddeactiveuserlist');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

//get subsscription count
  Future<dynamic> getUsersubsscriptionList() async {
    try {
      var response = await client.get('$endPoint/auth/subscriptioncount');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  //@@@@@@@@@@@@@----User & Member--------@@@@@@@@@@@@@
  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// Get Countries
  Future<List<dynamic>> getCountries() async {
    try {
      var response = await client.get('$endPoint/countries');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  //get user list
  Future<dynamic> getUserList() async {
    try {
      // var response = await client.get('$endPoint/users?limit=15&page=$page');
      var response = await client.get('$endPoint/users');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  //get user listtt
  Future<List<dynamic>> getparticularUserList(String userId) async {
    try {
      var response = await client.get('$endPoint/users/$userId');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getUserMembersList(String userId) async {
    try {
      var response = await client.get(
          '$endPoint/members?user_Id=$userId&role_name=60c381bc36cf932d305a572b');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Update Active Or Deactive in user
  Future<bool> updateactiveStatus(String userID, String status) async {
    try {
      //   var formData = FormData.fromMap({'covidDose_Id':doseID});
      var response = await client.patch(
          '$endPoint/users/$userID/activeanddeactivemember?user_status=$status');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@----Covid Related API's--------@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  // Get Covid does list
  Future<List<dynamic>> getdoeslist() async {
    try {
      var response = await client.get('$endPoint/coviddose');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get Covid does list
  Future<List<dynamic>> getcovidvaccinelist(String countryid) async {
    try {
      var response =
          await client.get('$endPoint/covidvaccination?country_id=$countryid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Add COVID Dose
  Future<bool> addCovidDose(String dose) async {
    try {
      var formData = FormData.fromMap({'dose': dose});
      var response = await client.post('$endPoint/coviddose', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Add COVID Lab Test
  Future<bool> addCovidtest(String testname, String country_id) async {
    try {
      var formData =
          FormData.fromMap({'test_name': testname, 'country_Id': country_id});
      var response =
          await client.post('$endPoint/covidlabtest', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Add COVID Vaccination
  Future<bool> addcovidvaccine(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);
      var formData = FormData.fromMap(post);
      var response =
          await client.post('$endPoint/covidvaccination', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Update COVID Vaccination
  Future<bool> updatecovidvaccine(
      String vaccineID, Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);
      var formData = FormData.fromMap(post);
      var response = await client.patch('$endPoint/covidvaccination/$vaccineID',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Get Countries
  Future<List<dynamic>> getcovidCountries() async {
    try {
      var response =
          await client.get('$endPoint/vaccinecountry?vaccination=covid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Get Countries vaccine
  Future<List<dynamic>> getCountry_vaccine(String countryid) async {
    try {
      var response =
          await client.get('$endPoint/covidvaccination?country_id=$countryid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Get Countries labtest
  Future<List<dynamic>> getCountry_labtest(String countryid) async {
    try {
      var response =
          await client.get('$endPoint/covidlabtest?country_id=$countryid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Update COVID Vaccine Name
  Future<bool> edit_covid_vaccineName(
      String vaccineId, String vaccinename) async {
    try {
      var formData = FormData.fromMap({'vaccination_name': vaccinename});
      var response = await client.patch(
          '$endPoint/covidvaccination/$vaccineId/vaccinenameupdate',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Remove COVID Test Name
  Future<bool> delete_covid_Vaccine(String vaccineId) async {
    try {
      var response =
          await client.delete('$endPoint/covidvaccination/$vaccineId');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Remove COVID Test Name
  Future<bool> delete_covid_Vaccine_dose(
      String vaccineId, String doseId) async {
    try {
      var response = await client.patch(
          '$endPoint/covidvaccination/doseremove/$vaccineId?dose_Id=$doseId');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Update COVID Test Name
  Future<bool> edit_covid_testName(String testid, String testname) async {
    try {
      var formData =
          FormData.fromMap({'doc_Id': testid, 'test_name': testname});
      var response =
          await client.patch('$endPoint/covidlabtest', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Remove COVID Test Name
  Future<bool> delete_covid_testName(String testid) async {
    try {
      var response = await client.delete('$endPoint/covidlabtest/$testid');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Update COVID dose
  Future<bool> edit_covid_dose(String doseid, String dosename) async {
    try {
      var formData = FormData.fromMap({'dose_name': dosename});
      var response =
          await client.patch('$endPoint/coviddose/$doseid', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Remove COVID dose
  Future<bool> delete_covid_dose(String doseid) async {
    try {
      var response = await client.delete('$endPoint/coviddose/$doseid');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@----Vaccination Related API's--------@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  // Get User vaccine list
  Future<List<dynamic>> getuservaccinelist(String countryid) async {
    try {
      var response =
          await client.get('$endPoint/vaccinemaster?country_id=$countryid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Remove COVID Test Nametett
  Future<bool> delete_vaccination_Vaccine(String vaccineId) async {
    try {
      var response = await client.delete('$endPoint/vaccinemaster/$vaccineId');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Get Countries vaccine
  Future<List<dynamic>> getCountry_vaccination(String countryid) async {
    try {
      var response =
          await client.get('$endPoint/vaccinemaster?country_id=$countryid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

// Update COVID dose
  Future<bool> edit_vaccine_type(String vaccinename, String vaccineId) async {
    try {
      var formData = FormData.fromMap({'vaccine_name': vaccinename});
      var response = await client.patch('$endPoint/vaccinetype/$vaccineId',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Add COVID Dose
  Future<bool> addmastervaccine(String vaccine_name) async {
    try {
      var formData = FormData.fromMap({'vaccine_name': vaccine_name});
      var response = await client.post('$endPoint/vaccinetype', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Remove COVID dose
  Future<bool> delete_vaccine_type(String vaccine_Id) async {
    try {
      var response = await client.delete('$endPoint/vaccinetype/$vaccine_Id');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Add COVID Vaccination
  Future<bool> adddvaccination(
      String countryID, String vaccineID, String age) async {
    try {
      var formData = FormData.fromMap(
          {'country_Id': countryID, 'vaccine_Id': vaccineID, 'age': age});
      var response =
          await client.post('$endPoint/vaccinemaster', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Update Vaccine
  Future<bool> updatevaccine(String masterID, String vaccineId) async {
    try {
      var formData = FormData.fromMap({'vaccine_Id': vaccineId});
      var response = await client.patch('$endPoint/vaccinemaster/$masterID',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Get Master Countries
  Future<List<dynamic>> getmasterCountries() async {
    try {
      var response =
          await client.get('$endPoint/vaccinecountry?vaccination=vaccine');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get User vaccine Type
  Future<List<dynamic>> getuservaccinetype() async {
    try {
      var response = await client.get('$endPoint/vaccinetype');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Add Master Vaccination
  Future<bool> addmastervaccination(String vaccine) async {
    try {
      var formData = FormData.fromMap({
        //'vaccine_Id': vaccineId,
        'vaccine_name': vaccine
        //'vaccination_name': vaccine
      });
      var response =
          await client.post('$endPoint/vaccinemaster', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addmasterage(String age, String countryID) async {
    try {
      var formData = FormData.fromMap({
        //'country_Id': countryID,
        //'covidDose_Id': doseID,
        'age': age,
        'country_Id': countryID
      });
      var response =
          await client.post('$endPoint/vaccinemaster', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Update Vaccine Age
  Future<bool> edit_age_vaccineName(String vaccineId, String age) async {
    try {
      var formData = FormData.fromMap({'age': age});
      var response = await client.patch(
          '$endPoint/vaccinemaster/agechange/$vaccineId',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Remove inner vaccine
  Future<bool> delete_inner_Vaccine(String vaccineId, String docId) async {
    try {
      var response = await client.patch(
          '$endPoint/vaccinemaster/vaccinneremove/$vaccineId?vacc_id=$docId');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Remove Vacccination Age
  Future<bool> delete_age_Vaccine(String vaccineId) async {
    try {
      var response = await client.delete('$endPoint/vaccinemaster/$vaccineId');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Add new vaccine
  Future<bool> addnewvaccine(String vaccine) async {
    try {
      var formData = FormData.fromMap({'vaccine_name': vaccine});
      var response = await client.post('$endPoint/vaccinetype', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Update master vaccine
  Future<bool> edit_master_vaccine(String docid, String vacc_name) async {
    try {
      var formData = FormData.fromMap({'vaccine_name': vacc_name});
      var response =
          await client.patch('$endPoint/vaccinetype/$docid', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

// Remove master vaccine
  Future<bool> delete_master_vaccine(String docid) async {
    try {
      var response = await client.delete('$endPoint/vaccinetype/$docid');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

//////////// SafeArea //////////////

  Future addstatus(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);
      FormData1.FormData postParams1 = FormData1.FormData.fromMap(post);
      var response = await client.post('$endPoint/feeds', data: postParams1);
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<dynamic> getProfile(String userid) async {
    try {
      var response = await client.get('$endPoint/users/$userid');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@-------Subscription Plan API's--------@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//get plan List
  Future<List<dynamic>> getplanList() async {
    try {
      var response = await client.get('$endPoint/subscriptionplans');
      return response.data;
    } on DioError catch (e) {
      print('getplanlist--------->>' + e.toString());
      return [];
    }
  }

  Future<dynamic> addplan(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);

      var formData = FormData.fromMap(post);
      var response =
          await client.post('$endPoint/subscriptionplans', data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e.toString());

      return {};
    }
  }

  Future<bool> edit_plan_list(String _id, String planname) async {
    try {
      var formData = FormData.fromMap({'subscription_plan': planname});
      var response = await client.patch('$endPoint/subscriptionplans/$_id',
          data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> delete_plan(String _id) async {
    try {
      var response = await client.delete('$endPoint/subscriptionplans/$_id');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@-------Role Management API's--------@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//get plan List
  Future<List<dynamic>> getroleList() async {
    try {
      var response = await client.get('$endPoint/adminrole');
      return response.data;
    } on DioError catch (e) {
      print('adminrole--------->>' + e.toString());
      return [];
    }
  }

//get plan List

  Future<dynamic> getparticularrole(String id) async {
    try {
      var response = await client.get('$endPoint/adminrole/$id');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {};
    }
  }

  // Update COVID Vaccine Name
  Future<bool> editparticularrole(String roleId, String rolepermission) async {
    try {
      var formData = FormData.fromMap({'name': rolepermission});
      var response =
          await client.patch('$endPoint/adminrole/$roleId', data: formData);
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> addrole(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);

      var formData = FormData.fromMap(post);
      var response = await client.post('$endPoint/adminrole', data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e.toString());

      return {};
    }
  }

  Future<dynamic> updaterole(
      String docid, Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);
      var formData = FormData.fromMap(post);
      var response =
          await client.patch('$endPoint/adminrole/$docid', data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e.toString());

      return {};
    }
  }

// Remove Roles
  Future<bool> delete_roles(String roleid) async {
    try {
      var response = await client.delete('$endPoint/adminrole/$roleid');
      print(response.data);
      return true;
    } on DioError catch (e) {
      print(e.toString());
      return false;
    }
  }

  /////////////////////// Audit log //////////////////////////////////

  //get auditlog List
  Future<List<dynamic>> getauditList() async {
    try {
      var response = await client.get('$endPoint/auditlog');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getdatefilter(String start, String end) async {
    try {
      var response =
          await client.get('$endPoint/auditlog?startdate=$start&enddate=$end');
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return [];
    }
  }

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@-------Admin User API's--------@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Future<dynamic> addadminuser(Map<String, dynamic> postParams) async {
    try {
      Map<String, dynamic> post = Map.from(postParams);

      var formData = FormData.fromMap(post);
      var response = await client.post('$endPoint/adminuser', data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e.toString());

      return {};
    }
  }
}
