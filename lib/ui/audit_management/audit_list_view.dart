import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/audit_management/audit_list_view_model.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class AuditListViewControl extends StatelessWidget {
  static const String id = 'audit-list-control';
  PreferencesService preferencesService = locator<PreferencesService>();

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    final desiredWidth = 20.0;
    return AdminScaffold(
        backgroundColor: activeColor,
        sideBar: _sideBar.sideBarMenus(context, AuditListViewControl.id),
        appBar: _appBar.AppBarMenus(),
        body: Center(
          child: AuditListView(),
        ));
  }
}
//test
class AuditListView extends StatefulWidget {
  AuditListView({Key? key}) : super(key: key);
  static const String id = 'audit-list-management';
  @override
  _AuditListViewState createState() => _AuditListViewState();
}

class _AuditListViewState extends State<AuditListView> {
  ScrollController _controller = ScrollController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  bool isAutoValidate = false;
  List<bool> _values = [true, false, true, false, false];
  TextEditingController ageController = TextEditingController();
  dynamic address_search = {};
  String localPath = '';
  String pageno = '1';
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget formControls(BuildContext context, PlanListViewmodel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        padding: EdgeInsets.all(12),
        width: Screen.width(context),
        decoration: UIHelper.roundedBorderWithColor(8, subtleColor,
            borderColor: Color(0xFFE2E2E2)),
        child: FormBuilder(
            initialValue: {},
            autovalidateMode: isAutoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            key: _fbKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            //  UIHelper.verticalSpaceSmalltest,
                            Theme(
                          data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                            primary: activeColor,
                          )),
                          child: FormBuilderDateTimePicker(
                            name: "date_of_birth",
                            controller: fromController,
                            initialDate: DateTime(DateTime.now().year - 0,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            onChanged: (DateTime? value) {
                              Jiffy newDate = Jiffy(value);
                              final diff = Jiffy().diff(newDate, Units.YEAR);
                              print(diff);
                              if (diff > -1) {
                                ageController.text = diff.toString();
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'From',
                              contentPadding: EdgeInsets.only(left: 20),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: activeColor,
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: UIHelper.getInputBorder(1),
                              focusedBorder: UIHelper.getInputBorder(1),
                              focusedErrorBorder: UIHelper.getInputBorder(1),
                              errorBorder: UIHelper.getInputBorder(1,
                                  borderColor: activeColor),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            // UIHelper.verticalSpaceSmall,
                            Theme(
                          data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                            primary: activeColor,
                          )),
                          child: FormBuilderDateTimePicker(
                            name: "date_of_birth",
                            controller: toController,
                            initialDate: DateTime(DateTime.now().year - 0,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            onChanged: (DateTime? value) {
                              Jiffy newDate = Jiffy(value);
                              final diff = Jiffy().diff(newDate, Units.YEAR);
                              print(diff);
                              if (diff > -1) {
                                ageController.text = diff.toString();
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'To',
                              contentPadding: EdgeInsets.only(left: 20),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: activeColor,
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: UIHelper.getInputBorder(1),
                              focusedBorder: UIHelper.getInputBorder(1),
                              focusedErrorBorder: UIHelper.getInputBorder(1),
                              errorBorder: UIHelper.getInputBorder(1,
                                  borderColor: activeColor),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                ElevatedButton(
                    onPressed: () async {
                      Loader.show(context);
                      await model.getdatefilter(
                          fromController.text, toController.text);
                      Loader.hide();
                    },
                    child: Text('Submit').bold(),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(160, 36)),
                      backgroundColor: MaterialStateProperty.all(activeColor),
                    )),
              ],
            )),
      ),
    );
  }

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

  Widget headerItemDark(String title, Color bgColor) {
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
            width: Screen.width(context),
            height: 60,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            //color: bgColor,
            child: Text(title.toUpperCase())
                .bold()
                .textElevation(30)
                .fontWeight(FontWeight.w900)
                .fontSize(14)
                .textAlignment(TextAlign.left)
                .textColor(Colors.black)));
  }

  Widget addMatDataItem(BuildContext context, int index,
      PlanListViewmodel model, dynamic data, String rootDocId) {
    String date_time = '';
    if (data['createdAt'] != null) {
      Jiffy dt = Jiffy(data['createdAt']);
      date_time = dt.format('dd-MM-yyyy, h:mm a');
    } else {
      date_time = "";
    }
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            //padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(date_time).fontSize(13).fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['name'] != null ? data['name'] : '')
                .fontSize(13)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['action_type'] != null ? data['action_type'] : '')
                .fontSize(13)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['email'] != null ? data['email'] : '')
                .fontSize(13)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child:
                Text(data['mobile_number'] != null ? data['mobile_number'] : '')
                    .fontSize(13)
                    .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['module'] != null ? data['module'] : '')
                .fontSize(13)
                .fontWeight(FontWeight.w600),
          )),
        ],
      ),
    );
  }

  Widget tableData(BuildContext context, PlanListViewmodel model) {
    SideBarWidget _sideBar = SideBarWidget();
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(25),
        child: ViewModelBuilder<PlanListViewmodel>.reactive(
            onModelReady: (model) async {
              await model.getplan();
            },
            builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Audit Log').fontSize(20).fontWeight(FontWeight.w700),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Container(
                          width: Screen.width(context),
                          padding: const EdgeInsets.all(8.0),
                          child: showSearchField(context, model),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: formControls(context, model),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  model.isBusy
                      ? Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          // width: Screen.width(context),
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
                                  headerItemDark(
                                      'Date & Time', adminHeaderDark),
                                  headerItemDark('User', adminHeaderDark),
                                  headerItemDark('Activity', adminHeaderDark),
                                  headerItemDark('Email', adminHeaderDark),
                                  headerItemDark('Mobile No', adminHeaderDark),
                                  headerItemDark('Module', adminHeaderDark),
                                ],
                              ),
                              Container(
                                color: Colors.black12,
                                height: 1,
                              ),
                              ListView.separated(
                                  controller: _controller,
                                  separatorBuilder: (context, index) {
                                    return SizedBox();
                                  },
                                  padding: EdgeInsets.only(top: 0),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.plan.length,
                                  itemBuilder: (context, index) {
                                    return addMatDataItem(context, index, model,
                                        model.plan[index], '');
                                  }),
                              //UIHelper.verticalSpaceMedium,
                            ],
                          ),
                        ),
                  UIHelper.verticalSpaceSmall,
                  NumberPagination(
                    listner: (int selectedPage) {
                      setState(() {
                        pageno = selectedPage.toString();
                        model.auditList(selectedPage);
                      });
                    },
                    totalPage: 100,
                    currentPage: 1, // picked number when init page
                    primaryColor: activeColor,
                  ),
                ],
              );
            },
            viewModelBuilder: () => PlanListViewmodel()),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<PlanListViewmodel>.reactive(
          onModelReady: (model) async {
            await model.getplan();
          },
          builder: (context, model, child) {
            return LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Container(
                    width: Screen.width(context),
                    child: tableData(context, model),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Container(
                        width: 1000,
                        child: tableData(context, model),
                      ),
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
