import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_view.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_viewmodel.dart';
import 'package:swaradmin/ui/covid_management/covid_dose_view.dart';

class CovidvaccineList extends StatefulWidget {
  CovidvaccineList({Key? key}) : super(key: key);
  @override
  _CovidvaccineListState createState() => _CovidvaccineListState();
}

class _CovidvaccineListState extends State<CovidvaccineList> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _covidVaccineController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();

  Future<void> _delete_vaccine_Dialog(
      BuildContext context, AddvaccineViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Vaccine'),
            content: Text(
                'Are you want to Remove the ' + doc['vaccination_name'] + ' ?'),
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
                  await model.delete_covid_vaccine(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_dose_Dialog(BuildContext context,
      AddvaccineViewmodel model, dynamic dosedata, dynamic vaccinedata) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Vaccine Dose'),
            content: Text('Are you want to Remove the ' +
                dosedata['dose'] +
                ' dose in a ' +
                vaccinedata['vaccination_name'] +
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
                  await model.delete_covid_Vaccine_dose(
                      vaccinedata['_id'], dosedata['_id']);
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
          .textColor(Colors.black),
    );
  }

  Widget rowItem(BuildContext context, String title, Color bgColor) {
    return Container(
      // width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title).bold().fontSize(14).textColor(activeColor),
      // color: Colors.red,
    );
  }

  Widget rowItem1(BuildContext context, IconData editData, IconData deleteData,
      AddvaccineViewmodel model, dynamic data) {
    return Container(
      width: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.covid_accessInfo['edit'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    _covidVaccineController.text = data['vaccination_name'];
                    await _vaccine_Dialog(context, model, data);
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
          preferencesService.covid_accessInfo['delete'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _delete_vaccine_Dialog(context, model, data);
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
      AddvaccineViewmodel model, dynamic dosedata, dynamic vaccinedata) {
    return Container(
      width: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.covid_accessInfo['delete'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _delete_dose_Dialog(
                        context, model, dosedata, vaccinedata);
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
        ],
      ),
    );
  }

  Widget getStatusItem(BuildContext context, int index, dynamic dosedata,
      AddvaccineViewmodel model, dynamic vaccinedata) {
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
            child: Text(dosedata['dose'])
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
                dosedata, vaccinedata),
          ),
        ],
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      AddvaccineViewmodel model, dynamic data, String rootDocId) {
    List dosestatus = data['dosestatus'] ?? [];
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
          Expanded(
            child: Container(
              child: rowItem(
                  context, data['vaccination_name'] ?? '', Colors.white),
            ),
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: dosestatus.length,
                itemBuilder: (context, index) {
                  return getStatusItem(
                      context, index, dosestatus[index], model, data);
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

  Future<void> _dose_Dialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('COVID Vaccine Dose'),
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
              child: CovidDoseList(),
            ),
          );
        });
  }

  Future<void> _vaccine_Dialog(
      BuildContext context, AddvaccineViewmodel model, dynamic data) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('COVID Vaccine'),
                GestureDetector(
                  onTap: () async {
                    await model.getCovidVaccines();
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
              width: 400,
              child: AddCovidRecords(selectData: data),
            ),
          );
        });
  }

  Widget showSearchField(BuildContext context, AddvaccineViewmodel model) {
    return SizedBox(
      height: 38,
      width: 250,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          //   padding: EdgeInsets.all(25),
          child: ViewModelBuilder<AddvaccineViewmodel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getCovidVaccines();
                Loader.hide();
              },
              builder: (context, model, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        preferencesService.covid_accessInfo['add'] == "true"
                            ? GestureDetector(
                                onTap: () async {
                                  await _vaccine_Dialog(context, model, {});
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: activeColor,
                                      size: 25,
                                    ),
                                    Text('Add Vaccine'),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        UIHelper.horizontalSpaceSmall,
                        GestureDetector(
                          onTap: () async {
                            await _dose_Dialog(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.data_saver_on_outlined,
                                color: activeColor,
                                size: 25,
                              ),
                              Text('Dose'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    showSearchField(context, model),
                    UIHelper.verticalSpaceSmall,
                    Container(
                      width: Screen.width(context),
                      decoration: UIHelper.roundedBorderWithColor(
                          6, Colors.transparent,
                          borderColor: Colors.black12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              headerItem1('SI No.', Color(0xffbdbdbd), 70),
                              headerItem('Vaccine & Dose', Color(0xffbdbdbd)),
                              headerItem1('Actions', Color(0xffbdbdbd), 90),
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
                                return addMatDataItem(context, index, model,
                                    model.vaccines[index], '');
                              }),
                        ],
                      ),
                    ),
                  ],
                );
              },
              viewModelBuilder: () => AddvaccineViewmodel())),
    );
  }
}
