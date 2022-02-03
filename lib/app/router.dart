// import 'package:flutter/material.dart';
// import 'package:swaradmin/ui/dashboard/dashboard_view.dart';
// import 'package:swaradmin/ui/dashboard/slide_navigation.dart';
// import 'package:swaradmin/ui/medical_records/vacc_mat_list_view.dart';
// import 'package:swaradmin/ui/members/members_view.dart';
// import 'package:swaradmin/ui/splash/splash_view.dart';
// import 'package:swaradmin/ui/startup/language_select_view.dart';
// import 'package:swaradmin/ui/startup/signup_view.dart';
// import 'package:swaradmin/ui/startup/start_view.dart';

// class RoutePaths {
//   static const String Splash = 'splash';
//   static const String Signup = 'signup';
//   static const String Start = 'start';
//   static const String Dashboard = 'dashboard';
//   static const String Langugage = 'language';
//   static const String Slider = 'slider';
//   static const String VaccineMaternityList = 'vacmatlist';
//   static const String Members = 'members';
// }

// class Router {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutePaths.Splash:
//         return MaterialPageRoute(builder: (_) => SplashView());
//       case RoutePaths.Signup:
//         return MaterialPageRoute(builder: (_) => SignupView());
//       case RoutePaths.Dashboard:
//         return MaterialPageRoute(builder: (_) => DashboardView());
//       case RoutePaths.Start:
//         return MaterialPageRoute(builder: (_) => StartView());
//       case RoutePaths.Langugage:
//         return MaterialPageRoute(builder: (_) => LanguageSelectView());
//        case RoutePaths.Slider:
//          return MaterialPageRoute(builder: (_) => SliderView());
//       case RoutePaths.VaccineMaternityList:
//         return MaterialPageRoute(builder: (_) => VaccineMaternityListView());
//       case RoutePaths.Members:
//         return MaterialPageRoute(builder: (_) => MembersView());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                   appBar: AppBar(
//                     backgroundColor: Colors.red,
//                   ),
//                   body: Center(
//                     child: Text('Functionality being developed..'),
//                   ),
//                 ));
//     }
//   }
// }
