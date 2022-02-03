import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';

import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/background_view.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/dashboard/admin_dashboard.dart';
import 'package:swaradmin/ui/splash/flutter_appauth_web.dart';
import 'package:swaradmin/ui/splash/splash_view.dart';
import 'package:swaradmin/ui/splash/start_viewmodel.dart';

class StartViewWeb extends StatefulWidget {
  StartViewWeb({Key? key}) : super(key: key);
  static const String id = 'login_screen';
  @override
  _StartViewWebState createState() => _StartViewWebState();
}

class _StartViewWebState extends State<StartViewWeb> {
  NavigationService navigationService = locator<NavigationService>();
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  // String radioValue = "phone";
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
  late String loginType;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<bool> checkUserExist() async {
    String oid = await preferencesService.getUserInfo('userkey');
    // String oid = '61cfd804-30f0-43b7-bdff-175f32a83d7e';
    if (oid.length > 0) {
      final response = await apiService.checkUserExist(oid);
      return response;
    }

    return false;
  }

  Future<AuthorizationTokenResponse?> initialize() async {
    late AuthorizationTokenRequest request;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      signInOrUp = (prefs.getString('key') ?? '');
      signType = (prefs.getString('keyType') ?? '');
    });

    print("USER REGISTER**********" + signInOrUp);
    String issuerurl = phoneSignInSignup;
    if (emailSignin != '') {
      issuerurl = emailSignin;
    } else {
      issuerurl = emailSignup;
    }
    // AppAuthWebPlugin _appAuth = AppAuthWebPlugin()testt;
    print("Running b2c web startup process...");
    // print("Session storage: " + window.sessionStorage.toString());
    //await openIdAuthClient.processStartupAuthentication();
    if (signType == 'email') {
      request = AuthorizationTokenRequest(
          // '5c73d323-db67-44f4-a04a-12aa9c0bfede',
          //'020dd9a6-3518-446d-8983-5acc163e7365',
          '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          //'https://swaradmindev02.azurewebsites.net/callback.html',
          'http://localhost:3000/callback.html',
          issuer: issuerurl,
          scopes: ["openid", "profile", '925f7658-e4b7-46de-8ce2-a39b3dd160fd'],
          promptValues: ['login'],
          discoveryUrl:
              // "https://swaradb2c.b2clogin.com/swaradb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/v2.0/.well-known/openid-configuration",
              "https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignIn/v2.0/.well-known/openid-configuration",
          serviceConfiguration: AuthorizationServiceConfiguration(
              signInOrUp == "Register" ? _authoriseURL1 : _authoriseURL,
              signInOrUp == "Register" ? _tokenURL1 : _tokenURL),
          allowInsecureConnections: true);
    } else {
      request = AuthorizationTokenRequest(
          // '5c73d323-db67-44f4-a04a-12aa9c0bfede',
          //'020dd9a6-3518-446d-8983-5acc163e7365',
          '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
          //'https://swaradmindev02.azurewebsites.net/callback.html',
          'http://localhost:3000/callback.html',
          issuer: issuerurl,
          scopes: ["openid", "profile", '925f7658-e4b7-46de-8ce2-a39b3dd160fd'],
          promptValues: ['login'],
          discoveryUrl:
              // "https://swaradb2c.b2clogin.com/swaradb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignUp/v2.0/.well-known/openid-configuration",
              "https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1A_B2C_1_PH_SUSI/v2.0/.well-known/openid-configuration",
          serviceConfiguration: AuthorizationServiceConfiguration(
              signInOrUp == "Register"
                  ? _authoriseURLPhone
                  : _authoriseURLPhone,
              signInOrUp == "Register" ? _tokenURLPhone : _tokenURLPhone),
          allowInsecureConnections: true);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('key');
    await preferences.remove('keyType');
    try {
      AuthorizationTokenResponse? _authTokenResponse =
          await AppAuthWebPlugin.processStartup(request);
      if (_authTokenResponse != null) {
        print("Startup response: " + _authTokenResponse.idToken!);
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(_authTokenResponse.idToken!);
        print(decodedToken);
        if (decodedToken['sub'] != null) {
          String oid = decodedToken['sub'];
          await preferencesService.setUserInfo(
              'token', _authTokenResponse.idToken!);
          await preferencesService.setUserInfo('oid', oid);
          bool isEmailLogin = false;
          if (decodedToken['emails'] != null) {
            List emails = decodedToken['emails'];
            if (emails.length > 0) {
              String useremail = emails.first;
              await preferencesService.setUserInfo('email', useremail);
              preferencesService.email = useremail;
              print(useremail);
              isEmailLogin = true;
              await preferencesService.setUserInfo(
                  'userkey', 'email=$useremail');
            }
          }
          if (decodedToken['name'] != null && !isEmailLogin) {
            await preferencesService.setUserInfo('phone', decodedToken['name']);
            preferencesService.phone = decodedToken['name'];
            await preferencesService.setUserInfo(
                'userkey', 'mobilenumber=${decodedToken['name']}');
          }
          if (decodedToken['countryCode'] != null) {
            await preferencesService.setUserInfo(
                'countryCode', decodedToken['countryCode']);
          }
          final response =
              await apiService.tokenValidation(_authTokenResponse.accessToken!);
          if (response['token'] != null) {
            dynamic tokenObject = response['token'];
            if (tokenObject['accessToken'] != null) {
              await preferencesService.setUserInfo(
                  'swartoken', tokenObject['accessToken']);
              await preferencesService.setUserInfo(
                  'refreshtoken', tokenObject['refreshToken']);
            }
          }
          bool isUserExists = await checkUserExist();

          if (isUserExists) {
            Navigator.of(context).pushNamed(Dashboard.id);
          } else {
            Navigator.of(context).pushNamed(SplashView.id);
          }
        }
      }

      return _authTokenResponse;
    } catch (e, s) {
      print("B2C Process Startup Error.");
      print(e);
      print(s);
      return null;
    }
  }

  void azureSignup(String type, bool isSignup) async {
    String issuerurl = phoneSignInSignup;
    if (type == 'email') {
      issuerurl = isSignup ? emailSignup : emailSignin;
    }

    AuthorizationTokenRequest request = AuthorizationTokenRequest(
        '925f7658-e4b7-46de-8ce2-a39b3dd160fd',
        //'5c73d323-db67-44f4-a04a-12aa9c0bfede',
        //'https://swaradmindev02.azurewebsites.net/callback.html',
        'http://localhost:3000/callback.html',
        issuer: emailSignin,
        scopes: ["openid", "profile", '925f7658-e4b7-46de-8ce2-a39b3dd160fd'],
        promptValues: ['login'],
        discoveryUrl:
            "https://swarprodadb2c.b2clogin.com/swarprodadb2c.onmicrosoft.com/B2C_1_SWAR_Email_SignIn/v2.0/.well-known/openid-configuration",
        serviceConfiguration: AuthorizationServiceConfiguration(
            isSignup ? _authoriseURL1 : _authoriseURL,
            isSignup ? _tokenURL1 : _tokenURL),
        allowInsecureConnections: true);

    AppAuthWebPlugin _appAuth = AppAuthWebPlugin();
    print("Starting authentication on WEB");

    try {
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(request);

      print("AppAuth Sign In Response ID Token: " + result.toString());
    } catch (e, s) {
      print("B2C Web Sign In Error");
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<StartViewModel>.reactive(
          builder: (context, model, child) {
            return BackgroundView(
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/swar_logo.png'),
                    UIHelper.verticalSpaceMedium,
                    Text("Let's get started")
                        .fontWeight(FontWeight.w600)
                        .fontSize(20),
                    UIHelper.verticalSpaceSmall,
                    UIHelper.verticalSpaceMedium,
                    UIHelper.horizontalSpaceLarge,
                    UIHelper.horizontalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Loader.show(context);
                                    print("check 1");
                                    bool result = await model.azureWebSignup(
                                        'email', false);
                                    if (result == false) {
                                      Loader.hide();
                                      return;
                                    }

                                    bool isUserExists =
                                        await model.checkUserExist();
                                    Loader.hide();
                                    if (isUserExists) {
                                      Navigator.of(context)
                                          .pushNamed(Dashboard.id);
                                    } else {
                                      Navigator.of(context)
                                          .pushNamed(SplashView.id);
                                    }
                                  },
                                  child: Text('Login').fontSize(15),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(120, 36)),
                                    backgroundColor:
                                        MaterialStateProperty.all(activeColor),
                                  )),
                            ),
                          ],
                        ),
                        UIHelper.horizontalSpaceMedium,
                      ],
                    ),
                  ],
                )),
              ),
            );
          },
          viewModelBuilder: () => StartViewModel()),
    );
  }
}
