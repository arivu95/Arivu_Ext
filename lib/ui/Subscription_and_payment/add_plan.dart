import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/app/router.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/text_styles.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:intl/intl.dart';
//import 'package:swaradmin/ui/Subscription%20and%20payment/add_plan_model.dart';
import 'package:swaradmin/ui/Subscription_and_payment/add_plan_model.dart';

class AddPlanView extends StatefulWidget {
  AddPlanView({Key? key}) : super(key: key);
  static const String id = 'add-plan-view';
  @override
  _AddPlanViewState createState() => _AddPlanViewState();
}

const APIKeys = "AIzaSyA_76M-Sca9mXdpkJKVHSeUkFRgvvQ3icI";

class _AddPlanViewState extends State<AddPlanView> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  PreferencesService preferencesService = locator<PreferencesService>();
  NavigationService navigationService = locator<NavigationService>();
  bool isAutoValidate = false;
  String localPath = '';
  TextEditingController ageController = TextEditingController();
  TextEditingController plannameController = TextEditingController();
  TextEditingController planstatusController = TextEditingController();
  TextEditingController activefromController = TextEditingController();
  TextEditingController validityController = TextEditingController();
  TextEditingController activetoController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController userroleController = TextEditingController();
  TextEditingController permonthController = TextEditingController();
  TextEditingController peryearController = TextEditingController();

  //Map<String, dynamic> get postParams ;
  //final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget addInputFormControl(String nameField, String hintText, String label) {
    bool isEnabled = false;

    return FormBuilderTextField(
      style: loginInputTitleStyle,
      // readOnly: nameField == 'age' ? true : false,
      name: nameField,
      autocorrect: false,
      controller: nameField == 'subscription_plan'
          ? plannameController
          : nameField == 'plan_status'
              ? planstatusController
              : nameField == 'plan_validity'
                  ? validityController
                  : nameField == 'amount'
                      ? priceController
                      : null,
      onChanged: (value) {
        print(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        //  prefixIcon: Icon(
        //  iconData,
        //  color: activeColor,
        // ),
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.black, fontStyle: FontStyle.normal, fontSize: 30),
        hintText: hintText,
        hintStyle: loginInputHintTitleStyle,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: UIHelper.getInputBorder(1),
        focusedBorder: UIHelper.getInputBorder(1),
        focusedErrorBorder: UIHelper.getInputBorder(1),
        errorBorder: UIHelper.getInputBorder(1, borderColor: activeColor),
      ),
    );
  }

  Widget formControls(BuildContext context) {
    return Container(
      height: 370,
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 1),
        child: Container(
          height: 370,
          padding: EdgeInsets.all(12),
          width: Screen.width(context),
          decoration: UIHelper.roundedBorderWithColor(8, subtleColor,
              borderColor: Color(0xFFE2E2E2)),
          child: Container(
            height: 370,
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
                            child: FormBuilderTextField(
                              style: loginInputTitleStyle,
                              name: 'subscription_plan',
                              autocorrect: false,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: activeColor,
                                // ),
                                hintText: 'plan name',
                                hintStyle: loginInputHintTitleStyle,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormBuilderTextField(
                              style: loginInputTitleStyle,
                              name: 'plan_status',
                              autocorrect: false,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: activeColor,
                                // ),
                                // labelText: 'plan status',
                                // labelStyle: TextStyle(
                                //     color: Colors.black,
                                //     fontStyle: FontStyle.normal,
                                //     fontSize: 20),

                                hintText: 'plan status',
                                hintStyle: loginInputHintTitleStyle,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
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
                            child: Theme(
                              data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                primary: activeColor,
                              )),
                              child: FormBuilderDateTimePicker(
                                name: "plan_active_from_date",
                                initialDate: DateTime(DateTime.now().year - 0,
                                    DateTime.now().month, DateTime.now().day),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                inputType: InputType.date,
                                format: DateFormat("dd/MM/yyyy"),
                                onChanged: (DateTime? value) {
                                  print(value);
                                  Jiffy newDate = Jiffy(value);
                                  final diff =
                                      Jiffy().diff(newDate, Units.YEAR);
                                  print(diff);
                                  if (diff > -1) {
                                    activefromController.text = diff.toString();
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Plan activate from date',
                                  hintStyle: loginInputHintTitleStyle,
                                  contentPadding: EdgeInsets.only(left: 20),
                                  // prefixIcon: Icon(
                                  //   Icons.calendar_today,
                                  //   color: activeColor,
                                  // ),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: UIHelper.getInputBorder(1),
                                  focusedBorder: UIHelper.getInputBorder(1),
                                  focusedErrorBorder:
                                      UIHelper.getInputBorder(1),
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
                            child: FormBuilderTextField(
                              style: loginInputTitleStyle,
                              name: 'plan_validity',
                              // inputFormatters: [
                              //   new WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                              // ],
                              autocorrect: false,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: activeColor,
                                // ),
                                hintText: 'plan validity',
                                hintStyle: loginInputHintTitleStyle,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
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
                            child: Theme(
                              data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                primary: activeColor,
                              )),
                              child: FormBuilderDateTimePicker(
                                name: "plan_active_to_date",
                                initialDate: DateTime(DateTime.now().year - 0,
                                    DateTime.now().month, DateTime.now().day),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                inputType: InputType.date,
                                format: DateFormat("dd/MM/yyyy"),
                                onChanged: (DateTime? value) {
                                  print(value);
                                  Jiffy newDate = Jiffy(value);
                                  final diff =
                                      Jiffy().diff(newDate, Units.YEAR);
                                  print(diff);
                                  if (diff > -1) {
                                    activetoController.text = diff.toString();
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Plan activate to date',
                                  hintStyle: loginInputHintTitleStyle,
                                  contentPadding: EdgeInsets.only(left: 20),
                                  // prefixIcon: Icon(
                                  //   Icons.calendar_today,
                                  //   color: activeColor,
                                  // ),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: UIHelper.getInputBorder(1),
                                  focusedBorder: UIHelper.getInputBorder(1),
                                  focusedErrorBorder:
                                      UIHelper.getInputBorder(1),
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
                            child: FormBuilderDropdown(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person_outlined,
                                //   color: activeColor,
                                // ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              name: "user_role",
                              hint: Text(' select role '),
                              items: ['User', 'Member', 'Friends']
                                  .map((grp) => DropdownMenuItem(
                                        value: grp,
                                        child: Text("$grp")
                                            .textColor(Colors.grey)
                                            .fontSize(16),
                                      ))
                                  .toList(),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
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
                            child: FormBuilderTextField(
                              style: loginInputTitleStyle,
                              name: 'price_per_month',
                              // inputFormatters: [
                              //   new WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                              // ],
                              autocorrect: false,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: activeColor,
                                // ),
                                hintText: 'plan price per month',
                                hintStyle: loginInputHintTitleStyle,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormBuilderTextField(
                              style: loginInputTitleStyle,
                              name: 'price_per_year',
                              // inputFormatters: [
                              //   new WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                              // ],
                              autocorrect: false,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: activeColor,
                                // ),
                                hintText: 'Plan price per year',
                                hintStyle: loginInputHintTitleStyle,
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: UIHelper.getInputBorder(1),
                                focusedBorder: UIHelper.getInputBorder(1),
                                focusedErrorBorder: UIHelper.getInputBorder(1),
                                errorBorder: UIHelper.getInputBorder(1,
                                    borderColor: activeColor),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    ViewModelBuilder<AddPlanViewmodel>.reactive(
                        builder: (context, model, child) {
                          return model.isBusy
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_fbKey.currentState!
                                        .saveAndValidate()) {
                                      print(_fbKey.currentState!.value);
                                      // DateTime dob = _fbKey
                                      //     .currentState!.value['date_of_birth'];
                                      // Jiffy fromDate_ = Jiffy(dob);
                                      Map<String, dynamic> postParams =
                                          Map.from(_fbKey.currentState!.value);

                                      final response =
                                          await model.addplan(postParams);

                                      if (response) {
                                        locator<PreferencesService>()
                                            .isReload
                                            .value = true;
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                title: "Done",
                                                descriptions: "Plan Saved !!!",
                                                text: "OK",
                                              );
                                            });
                                        Get.back();
                                      }

                                      locator<PreferencesService>()
                                          .isReload
                                          .value = true;
                                    } else {
                                      setState(() {
                                        isAutoValidate = true;
                                      });
                                    }
                                  },
                                  child: Text('Create').bold(),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(160, 36)),
                                    backgroundColor:
                                        MaterialStateProperty.all(activeColor),
                                  ));
                        },
                        viewModelBuilder: () => AddPlanViewmodel())
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return Container(
      height: 450,
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.red,
          // ),
          // sideBar: _sideBar.sideBarMenus(context, AddPlanView.idr),

          // child: SingleChildScrollView(
          // backgroundColor: Colors.white,
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              // width: Screen.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpaceSmall,
                  // UIHelper.addHeader(context, "Add plan", true),
                  UIHelper.verticalSpaceMedium,
                  Expanded(
                      child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          formControls(context),
                          UIHelper.verticalSpaceMedium
                        ],
                      ),
                    ),
                  ))
                ],
              ))),
    );
  }
}
