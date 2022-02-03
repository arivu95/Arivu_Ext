import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/CustomDialogBoxNew.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/text_styles.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'add_role_view_model.dart';

//test
class AddRoleView extends StatefulWidget {
  AddRoleView({Key? key}) : super(key: key);
  static const String id = 'add-role-view';
  @override
  _AddRoleViewState createState() => _AddRoleViewState();
}

const APIKeys = "AIzaSyA_76M-Sca9mXdpkJKVHSeUkFRgvvQ3icI";

class _AddRoleViewState extends State<AddRoleView> {
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
  //final picker = ImagePicker()r;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget addInputFormControl(String nameField, String hintText, String label) {
    bool isEnabled = false;

    return SingleChildScrollView(
        child: FormBuilderTextField(
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
    ));
  }

  Widget formControls(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Container(
        width: 1500,
        height: 1100,
        child: Container(
          width: 800,
          padding: EdgeInsets.all(12),
          //width: Screen.width(context),
          decoration: UIHelper.roundedBorderWithColor(8, subtleColor,
              borderColor: Color(0xFFE2E2E2)),
          //child: SingleChildScrollView(
          child: Container(
            height: 1100,
            width: Screen.width(context),
            child: FormBuilder(
              initialValue: {},
              autovalidateMode: isAutoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              key: _fbKey,
              child: Column(
                children: [
                  // new Flexible(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: FormBuilderTextField(
                  //       style: loginInputTitleStyle,
                  //       name: '',
                  //       autocorrect: false,
                  //       onChanged: (value) {
                  //         print(value);
                  //       },
                  //       decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.only(left: 20),
                  //         // prefixIcon: Icon(
                  //         //   Icons.person,
                  //         //   color: activeColor,
                  //         // ),
                  //         // labelText: 'plan status',
                  //         // labelStyle: TextStyle(
                  //         //     color: Colors.black,
                  //         //     fontStyle: FontStyle.normal,
                  //         //     fontSize: 20),

                  //         hintText: 'Role Name',
                  //         hintStyle: loginInputHintTitleStyle,
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         enabledBorder: UIHelper.getInputBorder(1),
                  //         focusedBorder: UIHelper.getInputBorder(1),
                  //         focusedErrorBorder: UIHelper.getInputBorder(1),
                  //         errorBorder: UIHelper.getInputBorder(1,
                  //             borderColor: activeColor),
                  //       ),
                  //       validator: FormBuilderValidators.compose([
                  //         FormBuilderValidators.required(context),
                  //       ]),
                  //       keyboardType: TextInputType.text,
                  //     ),
                  //   ),
                  // ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child:
                            //padding: const EdgeInsets.all(8.0),
                            //child:
                            FormBuilderTextField(
                          style: loginInputTitleStyle,
                          name: 'admin_role_name',
                          autocorrect: false,
                          onChanged: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(left: 20),
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: activeColor,
                            // ),
                            // labelText: 'plan status',
                            // labelStyle: TextStyle(
                            //     color: Colors.black,
                            //     fontStyle: FontStyle.normal,
                            //     fontSize: 20),

                            hintText: 'Role Name',
                            hintStyle: loginInputHintTitleStyle,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: UIHelper.getInputBorder(1),
                            focusedBorder: UIHelper.getInputBorder(1),
                            focusedErrorBorder: UIHelper.getInputBorder(1),
                            errorBorder: UIHelper.getInputBorder(1,
                                borderColor: activeColor),
                          ),
                          // validator: FormBuilderValidators.compose([
                          // FormBuilderValidators.required(context),
                          //],
                          //),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: FormBuilderCheckbox(
                          //   name: 'accept_terms',
                          //   initialValue: false,
                          //   //onChanged: _onChanged,
                          //   title: RichText(
                          //     text: TextSpan(
                          //       children: [
                          //         TextSpan(
                          //           text: 'Add',
                          //           style: TextStyle(color: Colors.black),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   validator: FormBuilderValidators.equal(
                          //     context,
                          //     true,
                          //     errorText:
                          //         'You must accept terms and conditions to continue',
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Text('Role Management').bold().fontSize(14),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'rolemanagementView',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'View',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'rolemanagementAdd',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Add',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // t),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        // child:
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        child: Theme(
                          data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                            primary: activeColor,
                          )),
                          child: FormBuilderCheckbox(
                            name: 'rolemanagementEdit',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Edit',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'rolemanagementDelete',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title:
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //child:
                                RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Delete',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // validator: FormBuilderValidators.equal(
                          //   context,
                          //   true,
                          //   errorText:
                          //       'You must accept terms and conditions to continue',
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Vaccination').bold().fontSize(14),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'vaccinationView',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'View',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'vaccinationAdd',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Add',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
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
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'vaccinationEdit',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Edit',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'vaccinationDelete',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5.0, top: 5.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Delete',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('User Management').bold().fontSize(14),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'usermanagementView',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'View',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'usermanagementAdd',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Add',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
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
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'usermanagementEdit',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Edit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'usermanagementDelete',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Delete',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Covid Records').bold().fontSize(14),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'covidrecordsView',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'View',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'covidrecordsAdd',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Add',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
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
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'covidrecordsEdit',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Edit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'covidrecordsDelete',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5.0, top: 5.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Delete',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Subscription and Payments').bold().fontSize(14),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'subscriptionandpaymentsView',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'View',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'subscriptionandpaymentsAdd',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Add',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
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
                          padding: const EdgeInsets.all(2.0),
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                              primary: activeColor,
                            )),
                            child: FormBuilderCheckbox(
                              name: 'subscriptionandpaymentsEdit',
                              initialValue: false,
                              //onChanged: _onChanged,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Edit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // validator: FormBuilderValidators.equal(
                              //   context,
                              //   true,
                              //   errorText:
                              //       'You must accept terms and conditions to continue',
                              // ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FormBuilderCheckbox(
                            name: 'subscriptionandpaymentsDelete',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5.0, top: 5.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Delete',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // validator: FormBuilderValidators.equal(
                            //   context,
                            //   true,
                            //   errorText:
                            //       'You must accept terms and conditions to continue',
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  ViewModelBuilder<AddRoleListViewmodel>.reactive(
                      builder: (context, model, child) {
                        return model.isBusy
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_fbKey.currentState!.saveAndValidate()) {
                                    print(_fbKey.currentState!.value);
                                    // DateTime dob = _fbKey
                                    //     .currentState!.value['date_of_birth'];
                                    // Jiffy fromDate_ = Jiffy(dob);
                                    Map<String, dynamic> postParams =
                                        Map.from(_fbKey.currentState!.value);

                                    final response =
                                        await model.addrole(postParams);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogBoxWeb(
                                            title: "Success",
                                            descriptions:
                                                "New Role Created !!!",
                                            text: "OK",
                                          );
                                        });
                                    // Navigator.of(context).pop();
                                    if (response) {
                                      locator<PreferencesService>()
                                          .isReload
                                          .value = true;
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBoxWeb(
                                              title: "Success",
                                              descriptions:
                                                  "New Role Created !!!",
                                              text: "OK",
                                            );
                                          });
                                      Navigator.of(context).pop();
                                      //Get.back();
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
                                child: Text('Create'),
                                style: ButtonStyle(
                                  // minimumSize:
                                  //     MaterialStateProperty.all(Size(160, 36)),
                                  // padding: MaterialStateProperty.all(
                                  //     EdgeInsets.all(15)),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 18)),
                                  backgroundColor:
                                      MaterialStateProperty.all(activeColor),
                                ));
                      },
                      viewModelBuilder: () => AddRoleListViewmodel())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////// Mobile //////////////////////////

  Widget formControlsMobile(BuildContext context) {
    return Container(
      width: 1200,
      child: Container(
        // decoration: UIHelper.roundedBorderWithColor(8, subtleColor,
        //     borderColor: Colors.black),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Container(
            child: FormBuilder(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: FormBuilderTextField(
                          style: loginInputTitleStyle,
                          name: 'admin_role_name',
                          autocorrect: false,
                          onChanged: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Test Name',
                            hintStyle: loginInputHintTitleStyle,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: UIHelper.getInputBorder(1),
                            focusedBorder: UIHelper.getInputBorder(1),
                            focusedErrorBorder: UIHelper.getInputBorder(1),
                            errorBorder: UIHelper.getInputBorder(1,
                                borderColor: activeColor),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formData(BuildContext context) {
    return Container(
      // width: Screen.width(context),
      height: 1100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.verticalSpaceMedium,
          Expanded(
            child:
                //  padding: const EdgeInsets.all(8.0),
                SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.black,
                //width: Screen.width(context),
                child: Column(
                  children: [
                    formControls(context),
                    UIHelper.verticalSpaceMedium
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(body: LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= 600) {
          return Container(
            // width: 1500,
            width: screenSize.width,
            // padding: EdgeInsets.all(25),
            child: formControls(context),
          );
        } else {
          return
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child:
              Container(
                  width: 1000,
                  height: 1900,
                  //width: screenSize.width,
                  //padding: EdgeInsets.all(25),
                  child: formControls(context));
          //   ),
          // );
        }
      },
    ));
  }
}
