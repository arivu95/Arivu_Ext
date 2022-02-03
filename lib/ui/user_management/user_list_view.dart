import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jiffy/jiffy.dart';
import 'package:number_pagination/number_pagination.dart';
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
import 'package:swaradmin/ui/Tables/User%20Management/User_Management_View.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view_model.dart';
import 'package:swaradmin/ui/user_management/user_list_viewmodel.dart';
import 'package:swaradmin/ui/user_management/view_user.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:intl/intl.dart';

class UserControl extends StatefulWidget {
   UserControl({Key? key}) : super(key: key);
    static const String id = 'userlist';
  @override
  State<UserControl> createState() => _UserControlState();
}

class _UserControlState extends State<UserControl> {
  PreferencesService preferencesService = locator<PreferencesService>();
 String rolename = '';

  @override
  Widget build(BuildContext context) {
    
    SideBarWidget _sideBar = SideBarWidget();
   swaradminBar _appBar = swaradminBar();
    final desiredWidth = 20.0;
    return AdminScaffold(
        backgroundColor: activeColor,
        sideBar: _sideBar.sideBarMenus(context, UserControl.id),
        appBar: _appBar.AppBarMenus(),
        body: Center(
          child: UsersListView(),
        ));
  }
}

class UsersListView extends StatefulWidget {
  UsersListView({Key? key}) : super(key: key);
  static const String id = 'user-management';
  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameSearch = TextEditingController();
  TextEditingController countrySearch = TextEditingController();
  TextEditingController plansearch = TextEditingController();

  TextEditingController dateController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  dynamic selectedCountry;
  dynamic selectedPlan;

  @override
  Set<PointerDeviceKind> get dragDevices => {
        //PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
  String isSort = 'asc';
  bool isSwitched = false;
  String indexid = '';
  String fillter = 'off';
  Widget showSearchField(BuildContext context, UserListViewmodel model) {
    return SizedBox(
      height: 38,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // model.updateOnTextSearch(value);
                  model.getMembers_search(value);
                },
                style: TextStyle(fontSize: 14),
                decoration: new InputDecoration(
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
                              model.getMembers_search('');
                              searchController.clear();
                              // FocusManager.instance.primaryFocus!.unfocus();
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
            ),
          ],
        ),
      ),
    );
  }

  Widget headerBar(
    String title,
    Color bgColor,
    IconData sortdata,
    RoleListViewmodel model,
    dynamic data,
  ) {
    return (new Text(
            data['admin_role_name'] != null ? data['admin_role_name'] : '')
        .fontSize(14)
        .fontWeight(FontWeight.w600));
  }

  Widget headerSort(
      String title, Color bgColor, IconData sortdata, UserListViewmodel model) {
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
        padding: EdgeInsets.only(left: 30.0),
        //color: bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title.toUpperCase())
                .bold()
                .fontSize(16)
                .textAlignment(TextAlign.left),
            UIHelper.horizontalSpaceSmall,
            (isSort == "asc")
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSort = "desc";
                      });
                      model.members_asc_sort();
                    },
                    child: Icon(sortdata),
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSort = "asc";
                      });
                      model.members_desc_sort();
                    },
                    child: Icon(sortdata),
                  ),
          ],
        ),
      ),
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
        padding: EdgeInsets.only(left: 30.0),
        //color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerbar(String title, Color bgColor) {
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
        padding: EdgeInsets.only(left: 30.0),
        color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      width: width,
      height: 60,
      alignment: Alignment.center,
      // color: bgColor,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
          left: BorderSide(width: 0.5, color: Colors.grey),
          top: BorderSide(width: 0.5, color: Colors.grey),
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Text(title.toUpperCase())
          .bold()
          .fontSize(16)
          .textAlignment(TextAlign.center),
    );
  }

  Future<void> _activeStatus_Dialog(BuildContext context,
      UserListViewmodel model, dynamic doc, String status) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Status'),
            content: Text(' Do you want to ' +
                status +
                ' the user ' +
                doc['name'] +
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
                  await model.updateactive(doc['_id'], status);

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget iconcolumn(
    BuildContext context,
    IconData viewData,
    UserListViewmodel model,
    dynamic data,
    dynamic plan,
  ) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserdetailsView(usedData: data, userplan: plan),
                ),
              );
            },
            child: Icon(viewData),
          ),
        ],
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      UserListViewmodel model, dynamic data, String rootDocId) {
    String plan = '';
    if (model.subscription[index]['productId'] == "com.kat.swarapp.basic") {
      plan = "Basic";
    } else if (model.subscription[index]['productId'] ==
        "com.kat.swarapp.yearly") {
      plan = "Yearly";
    } else if (model.subscription[index]['productId'] ==
        "com.kat.swarapp.monthly") {
      plan = "Monthly";
    }
    model.members[index]['active_flag'] == true
        ? isSwitched = true
        : isSwitched = false;
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 70,
            alignment: Alignment.center,
            //padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            padding: EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child:
                Text('${index + 1}').fontSize(14).fontWeight(FontWeight.w600),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40.0, top: 15.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: Text(
                model.members[index]['name'] != null
                    ? model.members[index]['name']
                    : '',
              )
                  .fontSize(14)
                  .fontWeight(FontWeight.w600)
                  .textAlignment(TextAlign.left),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40.0, top: 15.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(model.members[index]['country'] != null
                    ? model.members[index]['country']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40.0, top: 15.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(model.members[index]['create'] != null
                    ? model.members[index]['create']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40.0, top: 15.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(model.members[index]['product'] != null
                    ? model.members[index]['product']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Container(
            width: 70,
            padding: EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: iconcolumn(context, Icons.visibility_outlined, model, data,
                model.subscription[index]),
          ),
          Container(
            width: 70,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 8.0),
            child: preferencesService.user_accessInfo['edit'] == "true"
                ? (data['active_flag'] == false)
                    ? GestureDetector(
                        onTap: () async {
                          await _activeStatus_Dialog(
                              context, model, data, 'active');
                        },
                        child: Icon(
                          Icons.toggle_off,
                          color: disabledColor,
                          size: 30,
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await _activeStatus_Dialog(
                              context, model, data, 'deactive');
                        },
                        child: Icon(Icons.toggle_on,
                            color: submitBtnColor, size: 30),
                      )
                : GestureDetector(
                    onTap: () {
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
                    child: Icon(
                      Icons.edit,
                      color: disabledColor,
                      size: 20,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget filterWidget(BuildContext context, UserListViewmodel model) {
    return Container(
      // width: Screen.width(context),
      height: 50,
      decoration: UIHelper.roundedBorderWithColor(12, Colors.white,
          borderColor: Colors.black12),
      child: Row(
        children: [
          UIHelper.horizontalSpaceSmall,
          Expanded(
            child: SizedBox(
                height: 35,
                child: TextField(
                  controller: nameSearch,
                  onChanged: (value) {
                    model.getfilter_search(countrySearch.text, plansearch.text,
                        dateController.text, nameSearch.text);
                  },
                  style: TextStyle(fontSize: 14),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    contentPadding: EdgeInsets.only(left: 20),
                    enabledBorder: UIHelper.getInputBorder(0,
                        radius: 5, borderColor: Colors.transparent),
                    focusedBorder: UIHelper.getInputBorder(0,
                        radius: 5, borderColor: Colors.transparent),
                    hintStyle: new TextStyle(color: Colors.black54),
                    hintText: "Filter by Name",
                  ),
                )),
          ),
          UIHelper.horizontalSpaceMedium,
          Container(
              height: 35,
              width: 200,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Color(0xFFCCCCCC)),
              ),
              child: DropdownButton(
                value: selectedCountry,
                underline: SizedBox(),
                elevation: 12,
                hint: Text('Country'),
                items: model.countries.map((dynamic value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(value['country']),
                  );
                }).toList(),
                onChanged: (value) => {
                  setState(() {
                    selectedCountry = value!;
                    countrySearch.text = selectedCountry['country'];
                    model.getfilter_search(countrySearch.text, plansearch.text,
                        dateController.text, nameSearch.text);
                  }),
                },
              )),
          UIHelper.horizontalSpaceMedium,
          Container(
              height: 35,
              width: 200,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Color(0xFFCCCCCC)),
              ),
              child: DropdownButton(
                value: selectedPlan,
                elevation: 12,
                underline: SizedBox(),
                hint: Text('Subscription'),
                items: model.planList.map((dynamic value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(value['subscription_plan']),
                  );
                }).toList(),
                onChanged: (value) => {
                  setState(() {
                    selectedPlan = value!;
                    plansearch.text = selectedPlan['subscription_plan'];
                    model.getfilter_search(countrySearch.text, plansearch.text,
                        dateController.text, nameSearch.text);
                  }),
                },
              )),
          UIHelper.horizontalSpaceMedium,
          SizedBox(
            height: 35,
            width: 150,
            child: Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                primary: activeColor,
              )),
              child: FormBuilderDateTimePicker(
                name: "date",
                controller: dateController,
                initialDate: DateTime(DateTime.now().year - 0,
                    DateTime.now().month, DateTime.now().day),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                inputType: InputType.date,
                format: DateFormat("dd-MM-yyyy"),
                onChanged: (DateTime? value) {
                  Jiffy dt = Jiffy(value);
                  String dateTime = dt.format('dd-MM-yyyy');
                  print(dateTime);
                  dateController.text = dateTime;
                  model.getfilter_search(countrySearch.text, plansearch.text,
                      dateController.text, nameSearch.text);
                },
                decoration: InputDecoration(
                  hintText: 'Create on',
                  contentPadding: EdgeInsets.only(left: 20),
                  suffixIcon: Icon(Icons.calendar_today,
                      color: Colors.black38, size: 20),
                  enabledBorder: UIHelper.getInputBorder(1,
                      borderColor: Color(0xFFCCCCCC)),
                ),
              ),
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          GestureDetector(
              onTap: () async {
                setState(() {
                  model.getMembers_search('');
                  nameSearch.text = '';
                  dateController.text = '';
                  selectedCountry = null;
                  selectedPlan = null;
                });
              },
              child:
                  Icon(Icons.close_outlined, color: Colors.black38, size: 30)),
          UIHelper.horizontalSpaceSmall,
        ],
      ),
    );
  }

  Widget tableData(BuildContext context, UserListViewmodel model) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Management').fontSize(20).fontWeight(FontWeight.w700),
              UIHelper.verticalSpaceMedium,
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: showSearchField(context, model),
                    ),
                    new Flexible(
                        child: fillter == "off"
                            ? GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    fillter = "on";
                                  });
                                },
                                child: Icon(Icons.filter_alt_outlined,
                                    color: Colors.black38, size: 30))
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    fillter = "off";
                                  });
                                },
                                child: Icon(Icons.filter_alt,
                                    color: activeColor, size: 30))),
                  ],
                ),
              ),
              UIHelper.verticalSpaceSmall,
              fillter == 'on' ? filterWidget(context, model) : SizedBox(),
              UIHelper.verticalSpaceSmall,
              model.isBusy
                  ? Container(
                      height: 100,
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      decoration: UIHelper.roundedBorderWithColor(
                          12, Colors.transparent,
                          borderColor: Colors.black12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              headerItem1('SI No.', Color(0xffbdbdbd), 70),
                              headerSort('Name', Color(0xffbdbdbd),
                                  Icons.import_export_outlined, model),
                              headerItem('Country', Color(0xffbdbdbd)),
                              headerItem('Created on', Color(0xffbdbdbd)),
                              headerItem('Subscription', Color(0xffbdbdbd)),
                              headerItem1('Action', Color(0xffbdbdbd), 140),
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
                            //itemCount: model.members.length,
                            itemCount: model.members.length,
                            itemBuilder: (context, index) {
                              return addMatDataItem(context, index, model,
                                  model.members[index], '');
                            },
                          ),
                        ],
                      ),
                    ),
              UIHelper.verticalSpaceSmall,
              NumberPagination(
                listner: (int selectedPage) {
                  setState(() {
                    model.listofusers(selectedPage);
                  });
                },
                totalPage: model.totalPage,
                currentPage: 1, // picked number when init page
                primaryColor: activeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: preferencesService.user_accessInfo['view'] == "false"
          ? withoutAccess()
          : ViewModelBuilder<UserListViewmodel>.reactive(
              onModelReady: (model) async {
                await model.getCountries();
              },
              builder: (context, model, child) {
                return LayoutBuilder(
                  builder: (_, constraints) {
                    if (constraints.maxWidth >= 600) {
                      return Container(
                        padding: EdgeInsets.all(25),
                        child: tableData(context, model),
                      );
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 800,
                          padding: EdgeInsets.all(25),
                          child: tableData(context, model),
                        ),
                      );
                    }
                  },
                );
              },
              viewModelBuilder: () => UserListViewmodel()),
    );
  }
}
