// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:swaradmin/shared/sidebar.dart';
// import 'package:swaradmin/ui/Tables/Covid%20Records/AddLabTest.dart';
// import 'package:swaradmin/ui/Tables/Covid%20Records/add_covid_dose.dart';
// import 'package:swaradmin/ui/Tables/Covid%20Records/add_covid_vaccine.dart';
// import 'package:swaradmin/ui/Tables/Covid%20Records/covid_country_select.dart';

// class AddEditCovidRecords extends StatelessWidget {
//   static const String id = 'add-covid-records';
//   //const UserManagment({Key? key}) : super(key: key) testd;

//   @override
//   Widget build(BuildContext context) {
//     SideBarWidget _sideBar = SideBarWidget();
//     return AdminScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         //title: const Text('Sample'),
//       ),
//       sideBar: _sideBar.sideBarMenus(context, AddEditCovidRecords.id),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CovidCountrySelect()),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("Vaccine",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0,
//                         )),
//                   ),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: AddCovidVaccine()),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0), child: AddDose()),
//                 ),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: ElevatedButton(
//                       child: Text('Cancel'),
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFFDE2128)),
//                           padding:
//                               MaterialStateProperty.all(EdgeInsets.all(10)),
//                           textStyle: MaterialStateProperty.all(
//                               TextStyle(fontSize: 16))),
//                     ),
//                   ),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: ElevatedButton(
//                       child: Text('Save'),
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFF00C064)),
//                           padding:
//                               MaterialStateProperty.all(EdgeInsets.all(10)),
//                           textStyle: MaterialStateProperty.all(
//                               TextStyle(fontSize: 16))),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("Lab Test",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0,
//                         )),
//                   ),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0), child: AddLabTest()),
//                 ),
//                 new Flexible(
//                   child: Padding(padding: const EdgeInsets.all(8.0)),
//                 ),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: ElevatedButton(
//                       child: Text('Cancel'),
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFFDE2128)),
//                           padding:
//                               MaterialStateProperty.all(EdgeInsets.all(10)),
//                           textStyle: MaterialStateProperty.all(
//                               TextStyle(fontSize: 16))),
//                     ),
//                   ),
//                 ),
//                 new Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: ElevatedButton(
//                       child: Text('Save'),
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFF00C064)),
//                           padding:
//                               MaterialStateProperty.all(EdgeInsets.all(10)),
//                           textStyle: MaterialStateProperty.all(
//                               TextStyle(fontSize: 16))),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),

//         // child: Center(
//         //   child: Container(
//         //     width: 100,
//         //     child: PlayerList(),
//         //   ),
//         // ),
//       ),
//     );
//   }
// }

// class Fontsize {}
