// import 'package:editable/editable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:stacked/stacked.dart';
// import 'package:swaradmin/shared/app_colors.dart';
// import 'package:swaradmin/shared/flutter_overlay_loader.dart';
// import 'package:swaradmin/shared/screen_size.dart';
// import 'package:swaradmin/shared/sidebar.dart';
// import 'package:swaradmin/shared/ui_helpers.dart';
// import 'package:swaradmin/ui/role_management/role_access_list_viewmodel.dart';

// class TestManagementView extends StatelessWidget {
//   static const String id = 'tsy-management';
//   //const UserManagment({Key? key}) : super(key: key) test;

//   @override
//   Widget build(BuildContext context) {
//     SideBarWidget _sideBar = SideBarWidget();
//     return AdminScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         //title: const Text('Sample'),
//       ),
//       sideBar: _sideBar.sideBarMenus(context, TestMyHomePage.id),
//       body: Container(
//         child: Center(
//           child: TestMyHomePage(),
//         ),
//       ),
//     );
//   }
// }

// class TestMyHomePage extends StatefulWidget {
//   static const String id = 'tst-management';
//   //MyHomePage(Key key) : super(key: key);

//   @override
//   _TestMyHomePageState createState() => _TestMyHomePageState();
// }

// class _TestMyHomePageState extends State<TestMyHomePage> {
//   /// Create a Key for EditableState
//   final _editableKey = GlobalKey<EditableState>();

//   List rows = [
//     {
//       "name": 'James LongName Joe',
//       "date": '23/09/2020',
//       "month": 'June',
//       "status": 'completed'
//     },
//     {
//       "name": 'Daniel Paul',
//       "month": 'March',
//       "status": 'new',
//       "date": '12/4/2020',
//     },
//     {
//       "month": 'May',
//       "name": 'Mark Zuckerberg',
//       "date": '09/4/1993',
//       "status": 'expert'
//     },
//     {
//       "name": 'Jack',
//       "status": 'legend',
//       "date": '01/7/1820',
//       "month": 'December',
//     },
//   ];
//   List cols = [
//     {"title": 'Name', 'widthFactor': 0.2, 'key': 'name', 'editable': false},
//     {"title": 'Date', 'widthFactor': 0.2, 'key': 'date'},
//     {"title": 'Month', 'widthFactor': 0.2, 'key': 'month'},
//     {"title": 'Status', 'key': 'status'},
//   ];

//   /// Function to add a new row
//   /// Using the global key assigined to Editable widget
//   /// Access the current state of Editable
//   void _addNewRow() {
//     setState(() {
//       _editableKey.currentState!.createRow();
//     });
//   }

//   ///Print only edited rows.
//   void _printEditedRows() {
//     List editedRows = _editableKey.currentState!.editedRows;
//     print(editedRows);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           width: 1000,
//           child: ViewModelBuilder<RoleViewmodel>.reactive(
//               onModelReady: (model) async {
//                 Loader.show(context);
//                 await model.getrole();
//                 Loader.hide();
//               },
//               builder: (context, model, child) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Row(
//                         //mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           //new Flexible(
//                           // child: showSearchField(context, model),
//                           // ),
//                           UIHelper.horizontalSpaceSmall,
//                           GestureDetector(
//                             onTap: () async {
//                               //await _New_vaccine_Dialog(context, model);
//                             },
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.add_circle,
//                                   color: activeColor,
//                                   size: 25,
//                                 ),
//                                 Text('Add Vaccine')
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     UIHelper.verticalSpaceSmall,
//                     Container(
//                       width: Screen.width(context),
//                       decoration: UIHelper.roundedBorderWithColor(
//                           6, Colors.transparent,
//                           borderColor: Colors.black12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [],
//                           ),
//                           Container(
//                             color: Colors.black12,
//                             height: 1,
//                           ),
//                           ListView.separated(
//                               separatorBuilder: (context, index) {
//                                 return SizedBox();
//                               },
//                               padding: EdgeInsets.only(top: 0),
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: model.recentDatas.length,
//                               itemBuilder: (context, index) {
//                                 return Container();
//                               }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               viewModelBuilder: () => RoleViewmodel())),
//     );
//   }
// }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leadingWidth: 200,
// //         leading: TextButton.icon(
// //             onPressed: () => _addNewRow(),
// //             icon: Icon(Icons.add),
// //             label: Text(
// //               'Add',
// //               style: TextStyle(fontWeight: FontWeight.bold),
// //             )),
// //         //title: Text(widget.title),
// //         actions: [
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: TextButton(
// //                 onPressed: () => _printEditedRows(),
// //                 child: Text('Print Edited Rows',
// //                     style: TextStyle(fontWeight: FontWeight.bold))),
// //           )
// //         ],
// //       ),
// //       body: Editable(
// //         key: _editableKey,
// //         columns: cols,
// //         rows: rows,
// //         zebraStripe: true,
// //         // stripeColor1: Colors.blue[50],
// //         // stripeColor2: Colors.grey[200],
// //         onRowSaved: (value) {
// //           print(value);
// //         },
// //         onSubmitted: (value) {
// //           print(value);
// //         },
// //         borderColor: Colors.blueGrey,
// //         tdStyle: TextStyle(fontWeight: FontWeight.bold),
// //         trHeight: 80,
// //         thStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
// //         thAlignment: TextAlign.center,
// //         thVertAlignment: CrossAxisAlignment.end,
// //         thPaddingBottom: 3,
// //         showSaveIcon: true,
// //         saveIconColor: Colors.black,
// //         showCreateButton: true,
// //         tdAlignment: TextAlign.left,
// //         tdEditableMaxLines: 100, // don't limit and allow data to wrap
// //         tdPaddingTop: 0,
// //         tdPaddingBottom: 14,
// //         tdPaddingLeft: 10,
// //         tdPaddingRight: 8,
// //         focusedBorder: OutlineInputBorder(
// //             borderSide: BorderSide(color: Colors.blue),
// //             borderRadius: BorderRadius.all(Radius.circular(0))),
// //       ),
// //     );
// //   }
// // }
