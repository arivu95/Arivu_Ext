import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/dont_access_msg.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/Subscription_and_payment/add_plan.dart';
import 'package:swaradmin/ui/Subscription_and_payment/plan_list_view_model.dart';

class PlanListViewControl extends StatelessWidget {
  static const String id = 'plan-list-control';
  PreferencesService preferencesService = locator<PreferencesService>();
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    final desiredWidth = 20.0;
    return AdminScaffold(
        backgroundColor: activeColor,
        sideBar: _sideBar.sideBarMenus(context, PlanListViewControl.id),
        appBar: _appBar.AppBarMenus(),
        body: Center(
          //    padding: EdgeInsets.all(25),
          child: PlanListView(),
          //child: Text('PlanListMgt'),
        ));
  }
}

//test
class PlanListView extends StatefulWidget {
  PlanListView({Key? key}) : super(key: key);
  static const String id = 'plan-management';
  @override
  _PlanListViewState createState() => _PlanListViewState();
}

class _PlanListViewState extends State<PlanListView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _editplanController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();

  Widget showSearchField(BuildContext context, PlanListViewmodel model) {
    return Container(
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          model.getPlan_search(value);
        },
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: activeColor,
              size: 20,
            ),
            suffixIcon: searchController.text.isEmpty
                ? SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      model.getPlan_search('');
                      searchController.clear();
                    }),
            contentPadding: EdgeInsets.only(left: 20),
            enabledBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            focusedBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            focusedErrorBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            errorBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: "Search...",
            fillColor: fieldBgColor),
      ),
    );
  }

  Future<void> _edit_plan_Dialog(
      BuildContext context, PlanListViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('plan'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = valuetestt;
                });
              },
              controller: _editplanController,
              decoration: InputDecoration(hintText: doc['subscription_plan']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () async {
                  await model.edit_plan_list(
                      doc['_id'], _editplanController.text);
                  _editplanController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_plan_Dialog(
      BuildContext context, PlanListViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Subscription Plan'),
            content: Text('Are you want to Remove the ' +
                doc['subscription_plan'] +
                ' ?'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () async {
                  await model.delete_plan(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _addplan_Dialog(
      BuildContext context, PlanListViewmodel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Plan'),
                GestureDetector(
                  onTap: () async {
                    await model.getplan();
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.disabled_by_default,
                    color: activeColor,
                    size: 35,
                  ),
                ),
              ],
            ),
            content: Container(
              width: 580,
              child: AddPlanView(),
            ),
          );
        });
  }

  Widget showIcon(BuildContext context, PlanListViewmodel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // GestureDetector(
        //   onTap: () async {
        //     await _addplan_Dialog(context, model);
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.add_circle,
        //         color: activeColor,
        //         size: 25,
        //       ),
        //       Text('Add Plan')
        //     ],
        //   ),
        // ),
        UIHelper.horizontalSpaceMedium,
        // GestureDetector(
        //   onTap: () async tes{
        //     await _dose_Dialog(context);
        //   },
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.data_saver_on_outlined,
        //         color: activeColor,
        //         size: 25,
        //       ),
        //       Text('Vaccine')
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.grey),
            left: BorderSide(width: 0.5, color: Colors.grey),
            top: BorderSide(width: 0.5, color: Colors.grey),
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        height: 60,
        alignment: Alignment.centerLeft,
        //padding: EdgeInsets.only(left: 5.0),
        padding: EdgeInsets.only(left: 10),
        //color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(14)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.grey),
            left: BorderSide(width: 0.5, color: Colors.grey),
            top: BorderSide(width: 0.5, color: Colors.grey),
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        height: 60,
        alignment: Alignment.center,
        // padding: EdgeInsets.only(left: 10.0),
        // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        //color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(14)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItemMobile(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30.0),
        // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        color: bgColor,
        child: Text(title).bold().fontSize(8.5).textAlignment(TextAlign.center),
      ),
    );
  }

  Future<void> _viewuser_Dialog(
      BuildContext context, PlanListViewmodel model, dynamic data) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('View plan'),
                    GestureDetector(
                      onTap: () async {
                        await model.getplan();
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(
                        Icons.disabled_by_default,
                        color: activeColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                content: Container(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Plan name :",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            new Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['subscription_plan'],
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Amount :",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            new Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['amount'] != null
                                        ? data['amount']
                                        : '-',
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Start Date :",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            new Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['createdAt'],
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget addMatDataItem(BuildContext context, int index,
      PlanListViewmodel model, dynamic data, String rootDocId) {
    // String plan_active_from_date = '';
    // if (data['plan_active_from_date'] == null) {
    //   plan_active_from_date = "";
    // } else {
    //   Jiffy dt = Jiffy(data['plan_active_from_date']);
    //   plan_active_from_date = dt.format('yyy-MM-dd');
    // }

    // String plan_active_to_date = '';
    // if (data['plan_active_to_date'] == null) {
    //   plan_active_to_date = "";
    // } else {
    //   Jiffy dt = Jiffy(data['plan_active_from_date']);
    //   plan_active_to_date = dt.format('dd-MM-yyyy');
    // }

    String date_time = '';

    if (data['createdAt'] != null) {
      Jiffy dt = Jiffy(data['createdAt']);
      //Jiffy da = Jiffy(data['updatedAt']);
      date_time = dt.format('dd-MMM-yyyy, h:mm a');
    } else {
      // Jiffy dt = Jiffy(data['createdAt']);
      date_time = "";
    }
    String date_active = '';
    if (data['updatedAt'] != null) {
      Jiffy dt = Jiffy(data['updatedAt']);
      //Jiffy da = Jiffy(data['updatedAt']);
      date_active = dt.format('dd-MMM-yyyy, h:mm a');
    } else {
      // Jiffy dt = Jiffy(data['createdAt']);
      date_active = "";
    }

    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child:
                Text('${index + 1}').fontSize(14).fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['subscription_plan'])
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['plan_validity'])
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(date_time).fontSize(14).fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(date_active).fontSize(14).fontWeight(FontWeight.w600),
          )),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 3.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: iconcolumn(
                  context,
                  Icons.edit_outlined,
                  Icons.remove_red_eye_outlined,
                  Icons.delete_outline_outlined,
                  model,
                  data),
            ),
          ),
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () async {
          //       await _viewuser_Dialog(context, model, data);
          //     },
          //     child: Container(
          //       alignment: Alignment.center,
          //       padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
          //       decoration: BoxDecoration(
          //         border: Border(
          //           right: BorderSide(width: 1.0, color: Colors.black12),
          //         ),
          //       ),
          //       child:
          //           Text('View').fontSize(14).textColor(Colors.black26).bold(),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget iconcolumn(
      BuildContext context,
      IconData editData,
      IconData deleteData,
      IconData viewData,
      PlanListViewmodel model,
      dynamic doc) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.subscription_accessInfo['view'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _viewuser_Dialog(context, model, doc);
                  },
                  child: Icon(deleteData),
                )
              : GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "Warning !",
                            descriptions: "You dont have Access.",
                            text: "OK",
                          );
                        });
                  },
                  child: Icon(deleteData, color: disabledColor),
                ),

          UIHelper.horizontalSpaceSmall,
          // GestureDetector(
          //   onTap: () async {
          //     await _edit_plan_Dialog(context, model, doc);
          //   },
          //   child: Icon(editData),
          // ),
          // UIHelper.horizontalSpaceSmall,
          // GestureDetector(
          //   onTap: () async {
          //     await _delete_plan_Dialog(context, model, doc);
          //   },
          //   child: Icon(viewData),
          // ),
        ],
      ),
    );
  }

  @override
  Widget tableData(BuildContext context, PlanListViewmodel model) {
    SideBarWidget _sideBar = SideBarWidget();
    return Scaffold(
      body: preferencesService.subscription_accessInfo['view'] == "false"
          ? withoutAccess()
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(25),
                  child: ViewModelBuilder<PlanListViewmodel>.reactive(
                      onModelReady: (model) async {
                        Loader.show(context);
                        await model.getplan();
                        Loader.hide();
                      },
                      builder: (context, model, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subscription & Payment')
                                .fontSize(20)
                                .fontWeight(FontWeight.w700),
                            UIHelper.verticalSpaceMedium,
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Flexible(
                                    child: showSearchField(context, model),
                                  ),
                                  new Flexible(
                                    child: showIcon(context, model),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpaceMedium,
                            Container(
                              //width: Screen.width(context),
                              decoration: UIHelper.roundedBorderWithColor(
                                  12, Colors.transparent,
                                  borderColor: Colors.black12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      headerItem('SI No.', Color(0xffbdbdbd)),
                                      headerItem(
                                          'Plan name', Color(0xffbdbdbd)),
                                      headerItem(
                                          'Plan Validity', Color(0xffbdbdbd)),
                                      headerItem(
                                          'Effective date', Color(0xffbdbdbd)),
                                      headerItem('End date', Color(0xffbdbdbd)),
                                      headerItem('Action', Color(0xffbdbdbd)),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.black12,
                                    height: 1,
                                  ),
                                  ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return SizedBox();
                                      },
                                      padding: EdgeInsets.only(top: 0),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: model.plan.length,
                                      itemBuilder: (context, index) {
                                        return addMatDataItem(context, index,
                                            model, model.plan[index], '');
                                      }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      viewModelBuilder: () => PlanListViewmodel())),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<PlanListViewmodel>.reactive(
          onModelReady: (model) async {
            Loader.show(context);
            await model.getplan();
            Loader.hide();
          },
          builder: (context, model, child) {
            return LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Container(
                    //padding: EdgeInsets.all(25),
                    child: tableData(context, model),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      //width: Screen.width(context),
                      width: 1500,
                      //padding: EdgeInsets.all(10),
                      child: tableData(context, model),
                    ),
                  );
                }
              },
            );
          },
          viewModelBuilder: () => PlanListViewmodel()),
    );
  }
}
