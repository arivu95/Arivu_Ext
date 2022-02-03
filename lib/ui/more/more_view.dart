// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:swaradmin/app/locator.dart';
// import 'package:swaradmin/app/router.dart';
// import 'package:swaradmin/services/preferences_service.dart';
// import 'package:swaradmin/shared/app_bar.dart';
// import 'package:swaradmin/shared/app_colors.dart';
// import 'package:swaradmin/shared/flutter_overlay_loader.dart';
// import 'package:swaradmin/shared/screen_size.dart';
// import 'package:styled_widget/styled_widget.dart';
// import 'package:swaradmin/shared/ui_helpers.dart';
// import 'package:swaradmin/ui/medical_records/add_maternity_view.dart';
// import 'package:swaradmin/ui/medical_records/add_vaccination_view.dart';
// import 'package:swaradmin/ui/medical_records/show_maternity_view.dart';
// import 'package:swaradmin/ui/medical_records/show_vaccination_view.dart';
// import 'package:swaradmin/ui/medical_records/vacc_mat_list_view.dart';

// class MoreView extends StatelessWidget {
//   const MoreView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     PreferencesService preferencesService = locator<PreferencesService>();
//     NavigationService navigationService = locator<NavigationService>();
//     return Scaffold(
//       appBar: swaradminBar(),
//       body: Container(
//         width: Screen.width(context),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ElevatedButton(
//                 // onPressed: () async {
//                   await preferencesService.cleanAllPreferences();
//                   await navigationService.clearStackAndShow(RoutePaths.Splash);
//                   // Loader.show(context);
//                   // Future.delayed(Duration(seconds: 5), () {
//                   //   Loader.hide();
//                   // });
//                 },
//                 child: Text('Signout').bold(),
//                 style: ButtonStyle(
//                   minimumSize: MaterialStateProperty.all(Size(160, 36)),
//                   backgroundColor: MaterialStateProperty.all(activeColor),
//                 )),
//             UIHelper.verticalSpaceSmall
//           ],
//         ),
//       ),
//     );
//   }
// }
