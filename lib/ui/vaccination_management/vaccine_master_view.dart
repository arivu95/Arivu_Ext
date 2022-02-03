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
import 'package:swaradmin/ui/vaccination_management/vaccine_master_viewmodel.dart';

class MasterVaccineList extends StatefulWidget {
  MasterVaccineList({Key? key}) : super(key: key);
  @override
  _MasterVaccineListState createState() => _MasterVaccineListState();
}

class _MasterVaccineListState extends State<MasterVaccineList> {
  PreferencesService preferencesService = locator<PreferencesService>();
  TextEditingController searchController = TextEditingController();
  TextEditingController _editvaccineController = TextEditingController();
  TextEditingController _vaccine = TextEditingController();
  bool isload = false;

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
            .bold()
            .fontSize(16)
            .textColor(Colors.black)
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
          .fontSize(16)
          .textAlignment(TextAlign.center)
          .textColor(Colors.black),
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

  Future<void> _edit_dose_Dialog(BuildContext context,
      VaccinationCountryViewModel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Vaccine'),
            content: TextField(
              onChanged: (value) {},
              controller: _editvaccineController,
              decoration: InputDecoration(hintText: doc['vaccine_name']),
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
                  if(_editvaccineController.text.isNotEmpty){
                     await model.vaccineEdit(
                      doc['_id'], _editvaccineController.text);
                  isload = false;
                  _editvaccineController.clear();
                  }                
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _delete_test_Dialog(BuildContext context,
      VaccinationCountryViewModel model, dynamic doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('COVID Dose'),
            content: Text('Are you want to Remove the ' +
                doc['vaccine_name'] +
                ' Vaccine' +
                '?'),
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
                  await model.vaccinedelete(doc['_id']);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget iconcolumn(BuildContext context, IconData editData,
      IconData deleteData, VaccinationCountryViewModel model, dynamic doc) {
    return Container(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              _editvaccineController.text=doc['vaccine_name'];
              await _edit_dose_Dialog(context, model, doc);
            },
            child: Icon(editData),
          ),
          UIHelper.horizontalSpaceSmall,
          GestureDetector(
            onTap: () async {
              await _delete_test_Dialog(context, model, doc);
            },
            child: Icon(deleteData),
          ),
        ],
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      VaccinationCountryViewModel model, dynamic data, String rootDocId) {
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
            child: Text(data['vaccine_name'])
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

  Future<void> _New_vaccine_Dialog(
      BuildContext context, VaccinationCountryViewModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Vaccine'),
            content: TextField(
              onChanged: (value) {},
              controller: _vaccine,
              decoration: InputDecoration(hintText: 'Enter a Vaccine Name'),
            ),
            actions: <Widget>[
              model.isBusy
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        UIHelper.horizontalSpaceSmall,
                        FlatButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text('OK'),
                          onPressed: () async {
                            await model.addnewvaccine(_vaccine.text);
                            _vaccine.clear();

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
            ],
          );
        });
  }

  Widget showSearchField(
      BuildContext context, VaccinationCountryViewModel model) {
    return Container(
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          model.getvaccine_search(value);
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
                      model.getvaccine_search('');
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
            hintText: "Search By Vaccine...",
            fillColor: fieldBgColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: 500,
          child: ViewModelBuilder<VaccinationCountryViewModel>.reactive(
              onModelReady: (model) async {
                Loader.show(context);
                await model.getuservaccinetype();
                Loader.hide();
              },
              builder: (context, model, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Flexible(
                            child: showSearchField(context, model),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          GestureDetector(
                            onTap: () async {
                              await _New_vaccine_Dialog(context, model);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: activeColor,
                                  size: 25,
                                ),
                                // Text('Add Vaccine')
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
                              headerItem('Vaccine', Color(0xffbdbdbd)),
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
                              itemCount: model.listvaccine.length,
                              itemBuilder: (context, index) {
                                return addMatDataItem(context, index, model,
                                    model.listvaccine[index], '');
                              }),
                        ],
                      ),
                    ),
                  ],
                );
              },
              viewModelBuilder: () => VaccinationCountryViewModel())),
    );
  }
}
