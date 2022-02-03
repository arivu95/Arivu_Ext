import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/app/router.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/background_view.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/dashboard/admin_dashboard.dart';
import 'package:swaradmin/ui/splash/splash_view.dart';
import 'package:swaradmin/ui/splash/start_view_web.dart';
import 'package:swaradmin/ui/splash/start_viewmodel.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);
static const String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: StartViewMobile(),
      tablet: StartViewWeb(),
    );
  }
}

class StartViewMobile extends StatefulWidget {
  StartViewMobile({Key? key}) : super(key: key);

  @override
  _StartViewMobileState createState() => _StartViewMobileState();
}

class _StartViewMobileState extends State<StartViewMobile> {
  NavigationService navigationService = locator<NavigationService>();
  String radioValue = "phone";

  void radioButtonChanges(String value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('phone');
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
                    UIHelper.verticalSpaceLarge,
                    UIHelper.verticalSpaceMedium,
                    Text("Let's get started")
                        .fontWeight(FontWeight.w600)
                        .fontSize(20),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          visualDensity: VisualDensity.compact,
                          activeColor: activeColor,
                          value: 'phone',
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = 'phone';
                            });
                          },
                        ),
                        Text('Phone').fontWeight(FontWeight.w600),
                        UIHelper.horizontalSpaceMedium,
                        Radio(
                          visualDensity: VisualDensity.compact,
                          activeColor: activeColor,
                          value: 'email',
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = 'email';
                            });
                          },
                        ),
                        Text('Email').fontWeight(FontWeight.w600),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Existing user').fontSize(13),
                            ElevatedButton(
                                onPressed: () async {
                                  Loader.show(context);
                                  bool result = await model.azureSignup(
                                      radioValue, false);

                                  if (result == false) {
                                    Loader.hide();
                                     return;
                                  }

                                  bool isUserExists =
                                      await model.checkUserExist();
                                  Loader.hide();
                                  if (isUserExists) {
                                     Navigator.of(context).pushNamed(Dashboard.id);
                                  } else {
                                    Navigator.of(context).pushNamed(SplashView.id);
                                  }
                                },
                                child: Text('Login').fontSize(15),
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 36)),
                                  backgroundColor:
                                      MaterialStateProperty.all(activeColor),
                                )),
                          ],
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Column(
                          children: [
                            Text('New user').fontSize(13),
                            ElevatedButton(
                                onPressed: () async {
                                  Loader.show(context);
                                  bool result =
                                      await model.azureSignup(radioValue, true);

                                  if (result == false) {
                                    Loader.hide();
                                    // locator<DialogService>().showDialog(title: 'Error', description: 'Something went wrong. Try after sometime');
                                    return;
                                  }

                                  bool isUserExists =
                                      await model.checkUserExist();
                                  Loader.hide();
                                  if (isUserExists) {
                                     Navigator.of(context).pushNamed(Dashboard.id);
                                  } else {
                                    Navigator.of(context).pushNamed(SplashView.id);
                                  }

                                },
                                child: Text('Register').fontSize(15),
                                 style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 36)),
                                  backgroundColor:
                                      MaterialStateProperty.all(activeColor),
                                )),
                          ],
                        )
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
