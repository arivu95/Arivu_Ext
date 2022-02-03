import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/background_view.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swaradmin/ui/splash/splash_view.dart';

class SignoutView extends StatefulWidget {
  const SignoutView({Key? key}) : super(key: key);
  static const String id = 'signout_screen';
  @override
  _SignoutState createState() => _SignoutState();
}

class _SignoutState extends State<SignoutView> {
  NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    PreferencesService preferencesService = locator<PreferencesService>();
    return Scaffold(
      body: BackgroundView(
        child: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/swar_logo.png'),
              UIHelper.verticalSpaceMedium,
              Text('Signout Confirmation')
                  .fontWeight(FontWeight.w600)
                  .fontSize(20),
              UIHelper.verticalSpaceMedium,
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
                              await preferencesService.cleanAllPreferences();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              Loader.hide();
                              Navigator.of(context).pushNamed(SplashView.id);
                            },
                            child: Text('Signout').fontSize(15),
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(120, 36)),
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
      ),
    );
  }
}
//testt