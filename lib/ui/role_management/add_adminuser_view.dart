import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/CustomDialogBoxNew.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/text_styles.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/role_management/role_management_list_view_model.dart';

class AddAdminUserView extends StatefulWidget {
  AddAdminUserView({Key? key}) : super(key: key);
  static const String id = 'add-adminuser-view';
  @override
  _AddAdminUserViewState createState() => _AddAdminUserViewState();
}

const APIKeys = "AIzaSyA_76M-Sca9mXdpkJKVHSeUkFRgvvQ3icI";

class _AddAdminUserViewState extends State<AddAdminUserView> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  PreferencesService preferencesService = locator<PreferencesService>();
  NavigationService navigationService = locator<NavigationService>();
  bool isAutoValidate = false;
  String localPath = '';
  TextEditingController usernameController = TextEditingController();
  dynamic selectedrole;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget addInputFormControl(String nameField, String hintText, String label) {
    bool isEnabled = false;

    return FormBuilderTextField(
      style: loginInputTitleStyle,
      name: nameField,
      autocorrect: false,
      onChanged: (value) {
        print(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
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

  Widget formControls(BuildContext context, RoleListViewmodel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        padding: EdgeInsets.all(12),
        width: 500,
        decoration: UIHelper.roundedBorderWithColor(8, Colors.white,
            borderColor: Colors.white),
        child: FormBuilder(
            initialValue: {},
            autovalidateMode: isAutoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            // key: _fbKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  style: loginInputTitleStyle,
                  controller: usernameController,
                  name: 'email',
                  autocorrect: false,
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    filled: true,
                    hintText: 'Enter a email id',
                    fillColor: Colors.white,
                    enabledBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    focusedBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    focusedErrorBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    errorBorder:
                        UIHelper.getInputBorder(1, borderColor: activeColor),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  keyboardType: TextInputType.text,
                ),
                UIHelper.verticalSpaceSmall,
                DropdownButtonFormField(
                  value: selectedrole,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    focusedBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    focusedErrorBorder:
                        UIHelper.getInputBorder(1, borderColor: Colors.black),
                    errorBorder:
                        UIHelper.getInputBorder(1, borderColor: activeColor),
                  ),
                  hint: Text(' select role '),
                  items: model.role.map((dynamic value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: new Text(value['admin_role_name']).fontSize(16),
                    );
                  }).toList(),
                  onChanged: (value) => {
                    setState(() {
                      selectedrole = value!;
                    })
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                UIHelper.verticalSpaceMedium,
                // ViewModelBuilder<RoleListViewmodel>.reactive(
                //     builder: (context, model, child) {
                //       return
                model.isBusy
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          // if (_fbKey.currentState!.saveAndValidate()) {
                          //   print(_fbKey.currentState!.value);
                          Map<String, dynamic> postParams = {};
                          postParams['email'] = usernameController.text;
                          postParams['role_id'] = selectedrole['_id'];
                          postParams['role'] = selectedrole['admin_role_name'];
                          print('testing1-----------' + postParams.toString());

                          final response = await model.addadminuser(postParams);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBoxWeb(
                                  title: "Success !!!",
                                  descriptions: "Mail Sent Successfully",
                                  text: "OK",
                                );
                              });
                          if (response) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBoxWeb(
                                    title: "Success !!!",
                                    descriptions: "Mail Sent Successfully",
                                    text: "OK",
                                  );
                                });
                            locator<PreferencesService>().isReload.value = true;

                            Get.back();
                          }

                          locator<PreferencesService>().isReload.value = true;
                          // } else {
                          //   setState(() {
                          //     isAutoValidate = true;
                          //   });
                          // }
                        },
                        child: Text('Send').bold(),
                        style: ButtonStyle(
                          //minimumSize: MaterialStateProperty.all(Size(160, 36)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 18)),
                          backgroundColor:
                              MaterialStateProperty.all(activeColor),
                        )),
                // },
                // viewModelBuilder: () => RoleListViewmodel())
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoleListViewmodel>.reactive(
        onModelReady: (model) async {
          Loader.show(context);
          await model.getroleList();
          Loader.hide();
        },
        builder: (context, model, child) {
          return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        formControls(context, model),
                        UIHelper.verticalSpaceMedium
                      ],
                    ),
                  ))
                ],
              ));
        },
        viewModelBuilder: () => RoleListViewmodel());
  }
}
