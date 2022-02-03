import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_viewmodel.dart';

class AddUserVaccineRecords extends StatefulWidget {
  AddUserVaccineRecords({Key? key}) : super(key: key);
  @override
  _AddUserVaccineRecordsState createState() => _AddUserVaccineRecordsState();
}

class _AddUserVaccineRecordsState extends State<AddUserVaccineRecords> {
  PreferencesService preferencesService = locator<PreferencesService>();
  TextEditingController _vaccinemasterController = TextEditingController();
  TextEditingController _vaccineAgeController = TextEditingController();
 
  dynamic selectedvaccine;
  dynamic selectedage;
  bool isload = false;

  String vaccine_new = 'false';
  String add_new_vaccine = '';

  // Widget countryselect(BuildContext context, AddMasterVaccineViewmodel model) {
  //   if (selectedCountry != null) {
  //     preferencesService.country = selectedCountry['country'].toString();
  //     _countryController.text = selectedCountry['_id'].toString();
  //   }
  //   return Container(
  //     height: 40,
  //     padding: EdgeInsets.only(left: 20),
  //     decoration: UIHelper.roundedBorderWithColor(15, fieldBgColor),
  //     child: DropdownButton(
  //       isExpanded: true,
  //       value: selectedCountry,
  //       hint: Text('Select Country').fontSize(16),
  //       underline: SizedBox(),
  //       elevation: 12,
  //       items: model.countries.map((dynamic value) {
  //         return new DropdownMenuItem(
  //           value: value,
  //           child: new Text(value['country']).fontSize(16),
  //         );
  //       }).toList(),
  //       onChanged: (value) {
  //         setState(() {
  //           selectedCountry = value!;
  //           model.getuservaccinelist(selectedCountry['_id']);
  //         });
  //       },
  //     ),
  //   );
  // }

  Widget selectage(BuildContext context, AddMasterVaccineViewmodel model) {
    return vaccine_new == 'false'
        ? DropdownButtonFormField(
            isExpanded: true,
            value: selectedage,
            hint: Text('Select Age').fontSize(16),
            elevation: 12,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    vaccine_new = 'true';
                    add_new_vaccine = 'true';
                    selectedage = null;
                  });
                },
                child: Icon(
                  Icons.add_circle,
                  color: activeColor,
                  size: 25,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedErrorBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              errorBorder: UIHelper.getInputBorder(1, borderColor: activeColor),
            ),
            items: model.uservaccine.map((dynamic value) {
              return new DropdownMenuItem(
                value: value,
                child: new Text(value['age']).fontSize(16),
              );
            }).toList(),
            onChanged: (value) => {
              setState(() {
                selectedage = value!;
                add_new_vaccine = 'false';
              })
            },
          )
        : TextField(
            controller: _vaccineAgeController,
            onChanged: (value) {},
            style: TextStyle(fontSize: 16),
            // inputFormatters: [
            //   new WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))testt,
            // ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    vaccine_new = 'false';
                    model.getuservaccinelist();
                  });
                },
                child: Icon(
                  Icons.remove_circle,
                  color: activeColor,
                  size: 25,
                ),
              ),
              filled: true,
              hintText: 'Enter a Age',
              fillColor: Colors.white,
              enabledBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedErrorBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              errorBorder: UIHelper.getInputBorder(1, borderColor: activeColor),
            ),
          );
  }

  Widget selectvaccinetype(
      BuildContext context, AddMasterVaccineViewmodel model) {
    return DropdownButtonFormField(
      isExpanded: true,
      value: selectedvaccine,
      hint: Text('Select Vaccine').fontSize(16),
      elevation: 12,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: UIHelper.getInputBorder(1, borderColor: Colors.black),
        focusedBorder: UIHelper.getInputBorder(1, borderColor: Colors.black),
        focusedErrorBorder:
            UIHelper.getInputBorder(1, borderColor: Colors.black),
        errorBorder: UIHelper.getInputBorder(1, borderColor: activeColor),
      ),
      items: model.vaccinenew.map((dynamic value) {
        return new DropdownMenuItem(
          value: value,
          child: new Text(value['vaccine_name']).fontSize(16),
        );
      }).toList(),
      onChanged: (value) => {
        setState(() {
          selectedvaccine = value!;
        })
      },
    );
  }

  Widget buttonWidget(BuildContext context, AddMasterVaccineViewmodel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: isload == true
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text('Save'),
                    onPressed: () async {
                      if (add_new_vaccine == 'true') {
                        if ((_vaccineAgeController.text.isNotEmpty) &&
                            (selectedvaccine != null)) {
                          isload = true;

                          await model.addmastervaccine(
                              selectedvaccine['_id'],
                              _vaccineAgeController.text);
                          _vaccineAgeController.clear();
                          isload = false;
                          selectedvaccine = null;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Done",
                                  descriptions: "Vaccine Saved !!!",
                                  text: "OK",
                                );
                              });
                        } else {
                            if((_vaccineAgeController.text.isNotEmpty) &&
                            (selectedvaccine == null)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Vaccine is mandatory ",
                                  text: "OK",
                                );
                              });
                            }else if((_vaccineAgeController.text.isEmpty) &&
                            (selectedvaccine != null)) {
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Age is mandatory ",
                                  text: "OK",
                                );
                              });
                            }else{
                               showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Age and Vaccine's are mandatory ",
                                  text: "OK",
                                );
                              });
                            }
                          isload = false;
                        }
                      } 
                      else {
                        isload = true;

                        if ((selectedvaccine != null) &&
                            (selectedage != null)) {
                          isload = true;
                          await model.mastervaccineupdated(
                              selectedage['_id'], selectedvaccine['_id']);
                          selectedvaccine = null;
                          selectedage = null;
                          isload = false;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Done",
                                  descriptions: "Vaccine Saved !!!",
                                  text: "OK",
                                );
                              });
                        } else {
                          if((selectedage !=null) &&
                            (selectedvaccine == null)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Vaccine is mandatory ",
                                  text: "OK",
                                );
                              });
                            }else  if((selectedage ==null) &&
                            (selectedvaccine != null)){
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Age is mandatory ",
                                  text: "OK",
                                );
                              });
                            }else{
                               showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:
                                      "Age and Vaccine's are mandatory ",
                                  text: "OK",
                                );
                              });
                            }
                          isload = false;
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        activeColor,
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(15),
                      ),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return SingleChildScrollView(
        child: ViewModelBuilder<AddMasterVaccineViewmodel>.reactive(
            onModelReady: (model) async {
              Loader.show(context);
              await model.init();
              await model.getuservaccinelist();
              Loader.hide();
            },
            builder: (context, model, child) {
              return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   //   countryselect(context, model),
                      UIHelper.verticalSpaceSmall,
                      selectage(context, model),
                      UIHelper.verticalSpaceSmall,
                      selectvaccinetype(context, model),
                      UIHelper.verticalSpaceSmall,
                      buttonWidget(context, model)
                    ],
                  ));
            },
            viewModelBuilder: () => AddMasterVaccineViewmodel()));
  }
}

class Fontsize {}
