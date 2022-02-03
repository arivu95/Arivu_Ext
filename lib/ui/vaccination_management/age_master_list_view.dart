import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/dont_access_msg.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_list_viewmodel.dart';
import 'package:swaradmin/ui/vaccination_management/vaccine_widget_view.dart';

class AgeVaccinationView extends StatefulWidget {
  AgeVaccinationView({
    Key? key,
  }) : super(key: key);

  static const String id = 'Agevaccinelist';
  _AgevaccineListState createState() => _AgevaccineListState();
}

class _AgevaccineListState extends State<AgeVaccinationView> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _covidVaccineController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  bool isload = false;
  Future<void> _edit_vaccine_Dialog(
      BuildContext context, VaccineAgeViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Age'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = value;
                });
              },
              controller: _covidVaccineController,
              decoration: InputDecoration(hintText: doc['age']),
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
                  isload = true;
                  if (_covidVaccineController.text.isNotEmpty) {
                    await model.edit_age_vaccineName(
                        doc['_id'], _covidVaccineController.text);
                    isload = false;
                    _covidVaccineController.clear();
                  }
                  Navigator.pop(context);

                  // await model.edit_age_vaccineName(
                  //     doc['_id'], _covidVaccineController.text);
                  // _covidVaccineController.clear();
                  // Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_vaccine_Dialog(
      BuildContext context, VaccineAgeViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Vaccine'),
            content: Text('Are you want to Remove the ' + doc['age'] + ' ?'),
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
                  await model.delete_age_vaccine(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_inner_vaccine(BuildContext context,
      VaccineAgeViewmodel model, dynamic agedata, dynamic vaccinedata) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Vaccine'),
            content: Text('Are you want to Remove the ' +
                agedata['vaccine_name'] +
                ' vaccine in a ' +
                vaccinedata['age'] +
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
                  await model.delete_inner_vaccine(
                      vaccinedata['_id'], agedata['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 70,
        alignment: Alignment.center,
        // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        color: bgColor,
        child: Text(title)
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center)
            .textColor(activeColor),
      ),
    );
  }

  Widget headerItemBlack(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 70,
        alignment: Alignment.center,
        // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center)
            .textColor(Colors.black),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      height: 70,
      width: width,
      alignment: Alignment.center,
      // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
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
          .textAlignment(TextAlign.center)
          .fontWeight(FontWeight.w900)
          .textColor(Colors.black),
    );
  }

  Widget headerItem2(String title, Color bgColor, double width) {
    return Container(
      height: 70,
      width: width,
      alignment: Alignment.center,
      // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
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
          .textAlignment(TextAlign.center)
          .fontWeight(FontWeight.w900)
          .textColor(Colors.black),
    );
  }

  Widget rowItem(
      BuildContext context, String title, Color bgColor, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title.toUpperCase())
          .bold()
          .fontSize(14)
          .textColor(activeColor)
          .textAlignment(TextAlign.center),
      // color: Colors.red,
    );
  }

  Widget rowItemBlack(
      BuildContext context, String title, Color bgColor, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title)
          .bold()
          .fontSize(14)
          .textColor(Colors.black)
          .textAlignment(TextAlign.center),
      // color: Colors.red,
    );
  }

  Widget rowItem1(BuildContext context, IconData editData, IconData deleteData,
      VaccineAgeViewmodel model, dynamic data) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.vaccine_accessInfo['edit'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    _covidVaccineController.text = data['age'];
                    await _edit_vaccine_Dialog(context, model, data);
                  },
                  child: Icon(editData),
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
          UIHelper.horizontalSpaceSmall,
          preferencesService.vaccine_accessInfo['delete'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _delete_vaccine_Dialog(context, model, data);
                  },
                  child: Icon(deleteData),
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
                    deleteData,
                    color: disabledColor,
                    size: 20,
                  ),
                ),
        ],
      ),
    );
  }

  Widget rowItem2(
      BuildContext context, String title, Color bgColor, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
      // color: Colors.red,
    );
  }

  Widget columnItem(BuildContext context, IconData deleteData,
      VaccineAgeViewmodel model, dynamic agedata, dynamic vaccinedata) {
    return Container(
      width: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.vaccine_accessInfo['delete'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _delete_inner_vaccine(
                        context, model, agedata, vaccinedata);
                  },
                  child: Icon(deleteData),
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
                    deleteData,
                    color: disabledColor,
                    size: 20,
                  ),
                ),
        ],
      ),
    );
  }

  Widget getStatusItem(BuildContext context, int index, dynamic agedata,
      VaccineAgeViewmodel model, dynamic vaccinedata) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : fieldBgColor,
        border: Border(
          left: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(agedata['vaccine_name'])
                .textAlignment(TextAlign.center)
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: columnItem(context, Icons.delete_outline_outlined, model,
                agedata, vaccinedata),
          ),
        ],
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      VaccineAgeViewmodel model, dynamic data, String rootDocId) {
    List vaccinename = data['vaccine_name'] ?? [];
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : fieldBgColor,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: rowItem2(context, '${index + 1}', Colors.white, 70),
          ),
          Container(
            child: rowItem(context, data['age'] ?? '', Colors.white, 100),
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: vaccinename.length,
                itemBuilder: (context, index) {
                  return getStatusItem(
                      context, index, vaccinename[index], model, data);
                }),
          ),
          Container(
            child: rowItem1(context, Icons.edit_outlined,
                Icons.delete_outline_outlined, model, data),
          ),
        ],
      ),
    );
  }

  Widget showSearchField(BuildContext context, VaccineAgeViewmodel model) {
    return SizedBox(
      height: 40,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  model.vaccineTest_search(value);
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
                              model.vaccineTest_search('');
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

  Widget tableData(BuildContext context, VaccineAgeViewmodel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vaccine Management').bold().fontSize(18),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  child: showSearchField(context, model),
                ),
                new Flexible(
                  child: (preferencesService.vaccine_accessInfo['view'] ==
                              "false" &&
                          preferencesService.vaccine_accessInfo['edit'] ==
                              "false")
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VaccineCommonView(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: activeColor,
                                size: 25,
                              ),
                              Text('Manage Vaccination').bold()
                            ],
                          )),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Container(
              // width: Screen.width(context),
              decoration: UIHelper.roundedBorderWithColor(6, Colors.transparent,
                  borderColor: Colors.black12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      headerItem1('SI No.', Color(0xffbdbdbd), 70),
                      headerItem2('Age', Color(0xffbdbdbd), 100),
                      headerItemBlack('Vaccine', Color(0xffbdbdbd)),
                      headerItem1('Actions', Color(0xffbdbdbd), 170),
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
                      itemCount: model.vaccines.length,
                      itemBuilder: (context, index) {
                        return addMatDataItem(
                            context, index, model, model.vaccines[index], '');
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService preferencesService = locator<PreferencesService>();
    swaradminBar _appBar = swaradminBar();
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      appBar: _appBar.AppBarMenus(),
      sideBar: _sideBar.sideBarMenus(context, AgeVaccinationView.id),
      body: preferencesService.vaccine_accessInfo['view'] == "false"
          ? withoutAccess()
          : ViewModelBuilder<VaccineAgeViewmodel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getAgeVaccines();
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
              viewModelBuilder: () => VaccineAgeViewmodel()),
    );
  }
}
