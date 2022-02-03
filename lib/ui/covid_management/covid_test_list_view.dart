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

class CovidTestList extends StatefulWidget {
  CovidTestList({Key? key}) : super(key: key);
  @override
  _CovidTestListState createState() => _CovidTestListState();
}

class _CovidTestListState extends State<CovidTestList> {
  PreferencesService preferencesService = locator<PreferencesService>();
  TextEditingController searchController = TextEditingController();
  TextEditingController _covidtestController = TextEditingController();
  TextEditingController _addtestController = TextEditingController();

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

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 70,
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

  Widget columnItem(BuildContext context, String title, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 4),
      child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
      // color: Colors.red,
    );
  }

  Future<void> _edit_test_Dialog(
      BuildContext context, AddvaccineViewmodel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Lab Test'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = value;
                });
              },
              controller: _covidtestController,
              decoration: InputDecoration(hintText: doc['test_name']),
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
                  await model.edit_covid_testName(
                      doc['_id'], _covidtestController.text);
                  _covidtestController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _new_test_Dialog(
      BuildContext context, AddvaccineViewmodel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Lab Test'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  //valueText = value;
                });
              },
              controller: _addtestController,
              decoration: InputDecoration(hintText: "Enter a Test Name..."),
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
                  if (_addtestController.text.isNotEmpty) {
                    await model.addCovidtest(_addtestController.text);
                  }
                  _addtestController.clear();
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
            title: Text('COVID Lab Text'),
            content:
                Text('Are you want to Remove the ' + doc['test_name'] + ' ?'),
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
                  await model.delete_covid_testName(doc['_id']);
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
                    _covidtestController.text = doc['test_name'];
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
            child: Text(data['test_name'])
                .fontSize(14)
                .fontWeight(FontWeight.w600)
                .textColor(activeColor),
          )),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: ViewModelBuilder<AddvaccineViewmodel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getCovidLabtest();
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
                                  _new_test_Dialog(context, model);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: activeColor,
                                      size: 25,
                                    ),
                                    Text('Add Lab Test')
                                  ],
                                ),
                              )
                            : SizedBox(),
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
                              headerItem('Test', Color(0xffbdbdbd)),
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
                              itemCount: model.labtest.length,
                              itemBuilder: (context, index) {
                                return addMatDataItem(context, index, model,
                                    model.labtest[index], '');
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
