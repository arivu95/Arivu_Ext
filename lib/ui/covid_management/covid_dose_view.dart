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
import 'package:swaradmin/ui/covid_management/add_vaccine_viewmodel.dart';

class CovidDoseList extends StatefulWidget {
  CovidDoseList({Key? key}) : super(key: key);
  @override
  _CovidDoseListState createState() => _CovidDoseListState();
}

class _CovidDoseListState extends State<CovidDoseList> {
  PreferencesService preferencesService = locator<PreferencesService>();
  TextEditingController searchController = TextEditingController();
  TextEditingController _covidtestController = TextEditingController();
  TextEditingController _covidadd_dose = TextEditingController();

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 50,
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
            .textColor(Colors.black)
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
          .textColor(Colors.black)
          .fontSize(16)
          .textAlignment(TextAlign.center),
    );
  }

//test
  Widget columnItem(BuildContext context, String title, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
      // color: Colors.red,
    );
  }

  Future<void> _edit_dose_Dialog(
      BuildContext context, AddvaccineViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Dose'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = value;
                });
              },
              controller: _covidtestController,
              decoration: InputDecoration(hintText: doc['dose']),
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
                  await model.coviddoseupdated(
                      doc['_id'], _covidtestController.text);
                  _covidtestController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_test_Dialog(
      BuildContext context, AddvaccineViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Dose'),
            content: Text(
                'Are you want to Remove the ' + doc['dose'] + 'dose' + ' ?'),
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
                  print(doc['_id']);
                  await model.coviddosedelete(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget iconcolumn(BuildContext context, IconData editData,
      IconData deleteData, AddvaccineViewmodel model, dynamic doc) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preferencesService.covid_accessInfo['edit'] == "true"
              ? GestureDetector(
                  onTap: () async {
                    await _edit_dose_Dialog(context, model, doc);
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
                    await _delete_test_Dialog(context, model, doc);
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

  Widget addMatDataItem(BuildContext context, int index,
      AddvaccineViewmodel model, dynamic data, String rootDocId) {
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: columnItem(context, '${index + 1}', 70),
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
              child: Text(data['dose'])
                  .fontSize(14)
                  .fontWeight(FontWeight.w600)
                  .textColor(activeColor),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: iconcolumn(context, Icons.edit_outlined,
                Icons.delete_outline_outlined, model, data),
          ),
        ],
      ),
    );
  }

  Future<void> _New_Dose_Dialog(
      BuildContext context, AddvaccineViewmodel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID New Dose'),
            content: TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: _covidadd_dose,
              decoration: InputDecoration(hintText: 'Enter a Dose Name'),
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
                  await model.addCoviddose(_covidadd_dose.text);
                  _covidadd_dose.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: 500,
          child: ViewModelBuilder<AddvaccineViewmodel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getdoselist();
                Loader.hide();
              },
              builder: (context, model, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //Text('COVID Dose List').bold(),

                          GestureDetector(
                            onTap: () async {
                              await _New_Dose_Dialog(context, model);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: activeColor,
                                  size: 25,
                                ),
                                Text('Add Dose')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              headerItem('Dose', Color(0xffbdbdbd)),
                              headerItem1('Actions', Color(0xffbdbdbd), 100),
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
                              itemCount: model.coviddose.length,
                              itemBuilder: (context, index) {
                                return addMatDataItem(context, index, model,
                                    model.coviddose[index], '');
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
