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
import 'package:swaradmin/ui/role_management/add_role_view.dart';

import 'package:swaradmin/ui/role_management/role_access_list_view.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view_model.dart';
import 'add_adminuser_view.dart';

class RoleListViewControl extends StatelessWidget {
  static const String id = 'role-list-control';
  PreferencesService preferencesService = locator<PreferencesService>();

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    final desiredWidth = 20.0;
    return AdminScaffold(
        backgroundColor: activeColor,
        sideBar: _sideBar.sideBarMenus(context, RoleListViewControl.id),
        appBar: _appBar.AppBarMenus(),
        body: Center(
          //    padding: EdgeInsets.all(25),
          child: RoleManagementListView(),
          //child: Text('PlanListMgt'),
        ));
  }
}

class RoleManagementListView extends StatefulWidget {
  RoleManagementListView({Key? key}) : super(key: key);
  static const String id = 'role-management-list';
  @override
  _RoleManagementListViewState createState() => _RoleManagementListViewState();
}

class _RoleManagementListViewState extends State<RoleManagementListView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  String isSort = 'asc';

  Widget showSearchField(BuildContext context, RoleListViewmodel model) {
    return SizedBox(
      height: 38,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  model.getRole_search(value);
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
                              model.getRole_search('');
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
            ),
          ],
        ),
      ),
    );
  }

  Widget headerSort(
      String title, Color bgColor, IconData sortdata, RoleListViewmodel model) {
    return Expanded(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30.0),
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
                      model.role_asc_sort();
                    },
                    child: Icon(sortdata),
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSort = "asc";
                      });
                      model.role_desc_sort();
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
            .textAlignment(TextAlign.left),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
          left: BorderSide(width: 0.5, color: Colors.grey),
          top: BorderSide(width: 0.5, color: Colors.grey),
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      width: width,
      height: 60,
      alignment: Alignment.center,
      //color: bgColor,
      child: Text(title.toUpperCase())
          .bold()
          .fontSize(16)
          .textAlignment(TextAlign.center),
    );
  }

  Future<void> _activeStatus_Dialog(BuildContext context,
      RoleListViewmodel model, dynamic doc, String status) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Status'),
            content:
                Text('Are you change the ' + doc['name'] + ' status' + '?'),
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
                  //await model.updateactive(doc['_id'], status)testt;

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget addMatDataItem(BuildContext context, int index,
      RoleListViewmodel model, dynamic data, String rootDocId) {
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
          Container(
            height: 40,
            width: 70,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 30.0),
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
            padding: EdgeInsets.only(left: 30.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['admin_role_name'] != null
                    ? data['admin_role_name']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 30.0),
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
            padding: EdgeInsets.only(left: 30.0),
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
              padding: EdgeInsets.only(left: 30.0),
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
        ],
      ),
    );
  }

  Widget iconcolumn(
      BuildContext context,
      IconData editData,
      IconData deleteData,
      IconData viewData,
      RoleListViewmodel model,
      dynamic doc) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.role_accessInfo['view'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    preferencesService.roleManagementId = doc['_id'].toString();
                    print(preferencesService.roleManagementId);
                    Navigator.of(context).pushNamed(MasterRole.id);
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
                  child: Icon(
                    deleteData,
                    color: disabledColor,
                  ),
                ),
          UIHelper.horizontalSpaceSmall,
          preferencesService.role_accessInfo['edit'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _edit_test_Dialog(context, model, doc);
                  },
                  child: Icon(editData),
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
                  child: Icon(editData, color: disabledColor),
                ),
          UIHelper.horizontalSpaceSmall,
          preferencesService.role_accessInfo['delete'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _delete_test_Dialog(context, model, doc);
                  },
                  child: Icon(viewData),
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
                  child: Icon(viewData, color: disabledColor),
                ),
        ],
      ),
    );
  }

  Future<void> _edit_test_Dialog(
      BuildContext context, RoleListViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Role Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = value;
                });
              },
              controller: _roleController,
              decoration: InputDecoration(hintText: doc['admin_role_name']),
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
                  await model.updaterolemanagement(
                      doc['_id'], _roleController.text);
                  _roleController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_test_Dialog(
      BuildContext context, RoleListViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Admin Roles'),
            content: Text(
                'Are you want to Remove the ' + doc['admin_role_name'] + ' ?'),
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
                  await model.delete_roles(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget roleicon(BuildContext context, RoleListViewmodel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        preferencesService.role_accessInfo['add'] == "true"
            ? GestureDetector(
                onTap: () async {
                  await _adminuser_Dialog(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: activeColor,
                      size: 25,
                    ),
                    Text('Add Admin User')
                  ],
                ),
              )
            : SizedBox(),
        UIHelper.horizontalSpaceMedium,
        preferencesService.role_accessInfo['add'] == "true"
            ? GestureDetector(
                onTap: () async {
                  await _addRole_Dialog(context, model);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.data_saver_on_outlined,
                      color: activeColor,
                      size: 25,
                    ),
                    Text('Add Role')
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Future<void> _addRole_Dialog(
      BuildContext context, RoleListViewmodel model) async {
    var screenSize = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Role'),
                GestureDetector(
                  onTap: () async {
                    await model.getroleList();
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
              // width: 1100,
              width: screenSize.width,
              child: AddRoleView(),
            ),
          );
        });
  }

  Future<void> _adminuser_Dialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Admin User'),
                GestureDetector(
                  onTap: () async {
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
              width: 530,
              //width: Screen.width(context),
              //height: Screen.height(context),
              height: 300.0,
              child: AddAdminUserView(),
            ),
          );
        });
  }

  @override
  Widget tableData(BuildContext context, RoleListViewmodel model) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Role Management').fontSize(20).fontWeight(FontWeight.w700),
              UIHelper.verticalSpaceMedium,
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: showSearchField(context, model),
                    ),
                    new Flexible(
                      child: roleicon(context, model),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Container(
                decoration: UIHelper.roundedBorderWithColor(
                    12, Colors.transparent,
                    borderColor: Colors.black12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        headerItem1('SI No.', adminHeaderDark, 70),
                        headerSort('Role', adminHeaderDark,
                            Icons.import_export_outlined, model),
                        headerItem('Created at', adminHeaderDark),
                        headerItem('Updated at', adminHeaderDark),
                        headerItem('Actions', adminHeaderDark),
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
                      itemCount: model.role.length,
                      itemBuilder: (context, index) {
                        return addMatDataItem(
                            context, index, model, model.role[index], '');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: preferencesService.role_accessInfo['view'] == "false"
          ? withoutAccess()
          : ViewModelBuilder<RoleListViewmodel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getroleList();
                Loader.hide();
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
                          width: 650,
                          padding: EdgeInsets.all(25),
                          child: tableData(context, model),
                        ),
                      );
                    }
                  },
                );
              },
              viewModelBuilder: () => RoleListViewmodel()),
    );
  }
}
