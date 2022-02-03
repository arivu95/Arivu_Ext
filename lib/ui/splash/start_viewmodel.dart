import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:swaradmin/ui/splash/flutter_appauth_web.dart';

class StartViewModel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  FlutterAppAuth appAuth = FlutterAppAuth();
  AppAuthWebPlugin _appAuthWeb = AppAuthWebPlugin();
  String _authToken = '';
  String signInOrUp = '';
  String signType = '';

  // String phoneSignInSignup =
  //     'https://swartestadb2c.b2clogin.com/swartestadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/v2.0/';
  // String emailSignup =
  //     'https://swartestadb2c.b2clogin.com/swartestadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/v2.0/';
  // String emailSignin =
  //     'https://swartestadb2c.b2clogin.com/swartestadb2c.onmicrosoft.com/B2C_1_SWAR_Admin_Signin/v2.0/';

////// Go Live /////////

  String phoneSignInSignup =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/v2.0/';
  String emailSignup =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/v2.0/';
  String emailSignin =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignIn/v2.0/';

  //////////////////////////////

  String _tokenURL =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Admin_Signin/oauth2/v2.0/token';
  String _authoriseURL =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Admin_Signin/oauth2/v2.0/authorize';

  String _tokenURL1 =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/oauth2/v2.0/token';
  String _authoriseURL1 =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/oauth2/v2.0/authorize';

  String _tokenURLPhone =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/oauth2/v2.0/token';
  String _authoriseURLPhone =
      'https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/oauth2/v2.0/authorize';

  Future<bool> azureSignup(String type, bool isSignup) async {
    String issuerurl = phoneSignInSignup;
    if (type == 'email') {
      issuerurl = isSignup ? emailSignup : emailSignin;
    }
    AuthorizationTokenRequest request = AuthorizationTokenRequest(
        //'020dd9a6-3518-446d-8983-5acc163e7365',
        '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
        'msauth.com.kat.swarapp://auth/',
        issuer: issuerurl,
        scopes: [
          "offline_access",
          "profile",
          "email",
          "phone",
          //'020dd9a6-3518-446d-8983-5acc163e7365',
          '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
        ],
        promptValues: ['login'],
        allowInsecureConnections: true);

    try {
      AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(request);
      print(result!.idToken);

      Map<String, dynamic> decodedToken = JwtDecoder.decode(result.idToken!);
      print(decodedToken);
      _authToken = result.accessToken!;
      if (decodedToken['sub'] != null) {
        String oid = decodedToken['sub'];
        await preferencesService.setUserInfo('token', result.accessToken!);

        bool isEmailLogin = false;
        if (decodedToken['emails'] != null) {
          List emails = decodedToken['emails'];
          if (emails.length > 0) {
            String useremail = emails.first;
            await preferencesService.setUserInfo('email', useremail);
            preferencesService.email = useremail;
            print(useremail);
            isEmailLogin = true;
            await preferencesService.setUserInfo('userkey', 'email=$useremail');
          }
        }
        if (decodedToken['nationalNumber'] != null && !isEmailLogin) {
          await preferencesService.setUserInfo(
              'phone', decodedToken['nationalNumber']);
          preferencesService.phone = decodedToken['nationalNumber'];
          await preferencesService.setUserInfo(
              'userkey', 'mobilenumber=${decodedToken['nationalNumber']}');
        }
        if (decodedToken['countryCode'] != null) {
          await preferencesService.setUserInfo(
              'countryCode', decodedToken['countryCode']);
        }

        // Adding token validation :: START
        final response = await apiService.tokenValidation(result.accessToken!);
        if (response['token'] != null) {
          dynamic tokenObject = response['token'];
          if (tokenObject['accessToken'] != null) {
            await preferencesService.setUserInfo(
                'swartoken', tokenObject['accessToken']);
            await preferencesService.setUserInfo(
                'refreshtoken', tokenObject['refreshToken']);
          }
          print(response);
          await preferencesService.setUserInfo('oid', oid);
        }
        return true;
      }

      return false;
    } on PlatformException catch (err) {
      print(err.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> azureWebSignup(String type, bool isSignup) async {
    late AuthorizationTokenRequest request;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    if (isSignup) {
      signInOrUp = "Register";
    } else {
      signInOrUp = '';
    }
    signType = type;
    // });
    prefs.setString('key', signInOrUp);
    prefs.setString('keyType', signType);
    String issuerurl = phoneSignInSignup;
    if (type == 'email') {
      issuerurl = isSignup ? emailSignup : emailSignin;

      request = AuthorizationTokenRequest(
          // '5c73d323-db67-44f4-a04a-12aa9c0bfede',
          //'020dd9a6-3518-446d-8983-5acc163e7365',
          '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          // 'https://swaradmindev02.azurewebsites.net/callback.html',
          'http://localhost:3000/callback.html',
          // issuer: emailSignin,
          issuer: issuerurl,
          scopes: [
            "openid",
            "profile",
            "email",
            "phone",
            //'020dd9a6-3518-446d-8983-5acc163e7365'
            '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          ],
          promptValues: ['login'],
          discoveryUrl:
              "https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/v2.0/.well-known/openid-configuration",
          serviceConfiguration: AuthorizationServiceConfiguration(
              isSignup ? _authoriseURL1 : _authoriseURL,
              isSignup ? _tokenURL1 : _tokenURL),
          allowInsecureConnections: true);
    } else {
      request = AuthorizationTokenRequest(
          // '5c73d323-db67-44f4-a04a-12aa9c0bfede',
          //'020dd9a6-3518-446d-8983-5acc163e7365',
          '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          'http://localhost:3000/callback.html',
          //'https://swaradmindev02.azurewebsites.net/callback.html',
          // issuer: emailSignin,
          issuer: issuerurl,
          scopes: [
            "openid",
            "profile",
            "email",
            "phone",
            //'020dd9a6-3518-446d-8983-5acc163e7365'
            '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          ],
          promptValues: ['login'],
          discoveryUrl:
              //"https://swartestadb2c.b2clogin.com/swartestadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/v2.0/.well-known/openid-configuration",
              "https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/v2.0/.well-known/openid-configuration",
          serviceConfiguration: AuthorizationServiceConfiguration(
              isSignup ? _authoriseURLPhone : _authoriseURLPhone,
              isSignup ? _tokenURLPhone : _tokenURLPhone),
          allowInsecureConnections: true);
    }

    try {
      AuthorizationTokenResponse? result =
          await _appAuthWeb.authorizeAndExchangeCode(request);
      print(result!.idToken);

      Map<String, dynamic> decodedToken = JwtDecoder.decode(result.idToken!);
      print(decodedToken);
      _authToken = result.accessToken!;
      if (decodedToken['sub'] != null) {
        String oid = decodedToken['sub'];
        await preferencesService.setUserInfo('token', result.accessToken!);

        bool isEmailLogin = false;
        if (decodedToken['emails'] != null) {
          List emails = decodedToken['emails'];
          if (emails.length > 0) {
            String useremail = emails.first;
            await preferencesService.setUserInfo('email', useremail);
            preferencesService.email = useremail;
            print(useremail);
            isEmailLogin = true;
            await preferencesService.setUserInfo('userkey', 'email=$useremail');
          }
        }

        // Adding token validation :: START
        final response = await apiService.tokenValidation(result.accessToken!);
        if (response['token'] != null) {
          dynamic tokenObject = response['token'];
          if (tokenObject['accessToken'] != null) {
            await preferencesService.setUserInfo(
                'swartoken', tokenObject['accessToken']);
            await preferencesService.setUserInfo(
                'refreshtoken', tokenObject['refreshToken']);
          }

          print(response);
          await preferencesService.setUserInfo('oid', oid);
        }
        return true;
      }

      return false;
    } on PlatformException catch (err) {
      print(err.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> checkUserExist() async {
    String email = await preferencesService.getUserInfo('email');
    if (email != "") {
      final response = await apiService.checkUserEmailExist(email);
      return response;
    }
  }
}
