import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/shared/background_view.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:swaradmin/ui/dashboard/admin_dashboard.dart';
import 'package:swaradmin/ui/splash/splash_viewmodel.dart';
import 'package:swaradmin/ui/splash/start_view.dart';
import 'package:swaradmin/ui/splash/start_view_web.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
   static const String id = 'splash_screen';
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SplashMobile(),
      tablet: SplashWeb(),
    );
  }
}

class SplashWeb extends StatelessWidget {
  const SplashWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   NavigationService navigationService = locator<NavigationService>();
    return Scaffold(
      body: ViewModelBuilder<SplashViewModel>.reactive(
          onModelReady: (model) async {
            bool isUserLoggedIn = await model.checkUserLoggedIn();
            if (isUserLoggedIn) {
              bool isUserExist = await model.checkUserExist();
              if (isUserExist) {
                Navigator.of(context).pushNamed(Dashboard.id);
              } else {
                Navigator.of(context).pushNamed(StartViewWeb.id);
                }
            } else {
              Navigator.of(context).pushNamed(StartViewWeb.id);
            }
          },
          builder: (context, model, child) {
            return WebBackgroundView(
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/splash_logo.png'),
                    UIHelper.verticalSpaceLarge,
                    Image.asset('assets/splash_message.png')
                  ],
                )),
              ),
            );
          },
          viewModelBuilder: () => SplashViewModel()),
    );
  }
}

class SplashMobile extends StatelessWidget {
  const SplashMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  //  NavigationService navigationService = locator<NavigationService>();
    return Scaffold(
      body: ViewModelBuilder<SplashViewModel>.reactive(
          onModelReady: (model) async {
            bool isUserLoggedIn = await model.checkUserLoggedIn();
            if (isUserLoggedIn) {
              bool isUserExist = await model.checkUserExist();
              if (isUserExist) {
                 Navigator.of(context).pushNamed(Dashboard.id);
              } else {
                  Navigator.of(context).pushNamed(StartViewWeb.id);
              }
            } else {
              Navigator.of(context).pushNamed(StartViewWeb.id);
            }
          },
          builder: (context, model, child) {
            return BackgroundView(
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/splash_logo.png'),
                    UIHelper.verticalSpaceLarge,
                    Image.asset('assets/splash_message.png')
                  ],
                )),
              ),
            );
          },
          viewModelBuilder: () => SplashViewModel()),
    );
  }
}
