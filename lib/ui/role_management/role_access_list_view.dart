import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
import 'package:swaradmin/ui/role_management/role_access_list_viewmodel.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view.dart';

class MasterRole extends StatefulWidget {
  MasterRole({Key? key}) : super(key: key);
  static const String id = 'master-role-list';
  @override
  _MasterRoleState createState() => _MasterRoleState();
}

class _MasterRoleState extends State<MasterRole> {
  PreferencesService preferencesService = locator<PreferencesService>();
  TextEditingController searchController = TextEditingController();
  bool isload = false;

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
        height: 50,
        alignment: Alignment.center,
        //color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      height: 50,
      width: width,
      alignment: Alignment.center,
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

  Widget columnItem(BuildContext context, String title, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
      // color: Colors.redtest,
    );
  }

  Future<void> _edit_role_Dialog(
    BuildContext context,
    RoleViewmodel model,
    String name,
    String view,
    String add,
    String edit,
    String delete,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text('Are you want to change the \n' + name + ' Access' + '?'),
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
                      name, view, add, edit, delete);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget addMatDataItem(BuildContext context, int index, RoleViewmodel model,
      dynamic data, String rootDocId) {
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            //   child: columnItem(context, , 70),
            child: Text('${index + 1}')
                .bold()
                .fontSize(14)
                .textAlignment(TextAlign.center),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data['name'])
                .fontSize(14)
                .fontWeight(FontWeight.w600)
                .textColor(activeColor),
          )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: (data['view'] == "true")
                  ? GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          "false",
                          data['add'],
                          data['edit'],
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box,
                        color: addToCartColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          "true",
                          data['add'],
                          data['edit'],
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Container(
              //width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: (data['add'] == "true")
                  ? GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          "false",
                          data['edit'],
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box,
                        color: addToCartColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          "true",
                          data['edit'],
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: (data['edit'] == "true")
                  ? GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          data['add'],
                          "false",
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box,
                        color: addToCartColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          data['add'],
                          "true",
                          data['delete'],
                        );
                      },
                      child: Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Container(
              // width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: (data['delete'] == "true")
                  ? GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          data['add'],
                          data['edit'],
                          "false",
                        );
                      },
                      child: Icon(
                        Icons.check_box,
                        color: addToCartColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await _edit_role_Dialog(
                          context,
                          model,
                          data['name'],
                          data['view'],
                          data['add'],
                          data['edit'],
                          "true",
                        );
                      },
                      child: Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                    ),
              //Text(data['delete']).fontSize(14).fontWeight(FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget addHeader(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RoleListViewControl.id);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text('Role Management').bold().fontSize(18),
        ],
      ),
    );
  }

  Widget showSearchField(BuildContext context, RoleViewmodel model) {
    return Container(
      height: 38,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          model.getrole_search(value);
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
                      model.getrole_search('');
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
            hintText: "Search By title...",
            fillColor: fieldBgColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService preferencesService = locator<PreferencesService>();
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
       appBar: _appBar.AppBarMenus(),
        sideBar: _sideBar.sideBarMenus(context, MasterRole.id),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
                // width: 1000,
                child: ViewModelBuilder<RoleViewmodel>.reactive(
                    onModelReady: (model) async {
                      Loader.show(context);
                      await model.getrole();
                      Loader.hide();
                    },
                    builder: (context, model, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addHeader(context),
                          UIHelper.verticalSpaceMedium,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                UIHelper.verticalSpaceMedium,
                                new Flexible(
                                  child: showSearchField(context, model),
                                ),
                                new Flexible(
                                  child: Text(''),
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
                            child: Container(
                              width: Screen.width(context),
                              decoration: UIHelper.roundedBorderWithColor(
                                  6, Colors.transparent,
                                  borderColor: Colors.black12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      headerItem1(
                                          'SI No.', adminHeaderDark, 70),
                                      headerItem('Title', adminHeaderDark),
                                      headerItem('View', adminHeaderDark),
                                      headerItem('Add', adminHeaderDark),
                                      headerItem(
                                        'Edit',
                                        adminHeaderDark,
                                      ),
                                      headerItem('Delete', adminHeaderDark),
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
                                      itemCount: model.recentDatas.length,
                                      itemBuilder: (context, index) {
                                        return addMatDataItem(
                                            context,
                                            index,
                                            model,
                                            model.recentDatas[index],
                                            '');
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    viewModelBuilder: () => RoleViewmodel())),
          ),
        ));
  }
}
