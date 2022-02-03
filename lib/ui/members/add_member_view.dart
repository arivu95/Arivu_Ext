import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/text_styles.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:intl/intl.dart';

//test
class AddMemberView extends StatefulWidget {
  bool isEditMode;
  AddMemberView({Key? key, required this.isEditMode}) : super(key: key);

  @override
  _AddMemberViewState createState() => _AddMemberViewState();
}

class _AddMemberViewState extends State<AddMemberView> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isAutoValidate = false;
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  Widget addInputFormControl(
      String nameField, String hintText, IconData iconData) {
    bool isEnabled = false;
    if (nameField == 'mobile' || nameField == 'email') {
      isEnabled = true;
    }
    return FormBuilderTextField(
      style: loginInputTitleStyle,
      name: nameField,
      autocorrect: false,
      onChanged: (value) {
        print(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        prefixIcon: Icon(
          iconData,
          color: activeColor,
        ),
        hintText: hintText,
        hintStyle: loginInputHintTitleStyle,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: UIHelper.getInputBorder(1),
        focusedBorder: UIHelper.getInputBorder(1),
        focusedErrorBorder: UIHelper.getInputBorder(1),
        errorBorder: UIHelper.getInputBorder(1),
      ),
      keyboardType: nameField == 'alternatemobilenumber' ||
              nameField == 'emergency_doctor_number' ||
              nameField == 'emergency_clinic_number'
          ? TextInputType.number
          : TextInputType.text,
    );
  }

  Widget formControls(BuildContext context) {
    Jiffy dob = Jiffy();
    String allergic = '';
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        padding: EdgeInsets.all(12),
        width: Screen.width(context),
        decoration: UIHelper.roundedBorderWithColor(8, subtleColor,
            borderColor: Color(0xFFE2E2E2)),
        child: FormBuilder(
            initialValue: widget.isEditMode
                ? {
                    'name': 'Arun',
                    'middlename': 'A',
                    'lastname': 'Kumar',
                    'email': 'arun@gmail.com',
                    'dateofbirth': dob.dateTime,
                    'age': '55',
                    'gender': 'Male',
                    'bloodgroup': 'A+',
                    'mobile': '9988776655',
                    'alternatemobilenumber': '5566445566',
                    'country': 'USA',
                    'state': 'LA',
                    'city': 'lorean',
                    'zipcode': '665756',
                    'allergicto': 'skin'
                  }
                : {},
            autovalidateMode: isAutoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            key: _fbKey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Color(0xFFEAEAEA),
                    child: widget.isEditMode
                        ? Image.asset('assets/img1.png')
                        : Icon(Icons.camera_alt, color: activeColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                addInputFormControl('name', 'First Name', Icons.person),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('middlename', 'Middle Name', Icons.person),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('lastname', 'Last Name', Icons.person),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('email', 'Email Id', Icons.email),
                UIHelper.verticalSpaceSmall,
                Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light(
                    primary: activeColor, //constant Color(0xFF16A5A6)
                  )),
                  child: FormBuilderDateTimePicker(
                      // initialDate: beginDate.add(Duration(days: 1)),
                      name: "dateofbirth",
                      // firstDate: beginDate.add(Duration(days: 1)),
                      // lastDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year - 18,
                          DateTime.now().month, DateTime.now().day),
                      inputType: InputType.date,
                      format: DateFormat("dd/MM/yyyy"),
                      onChanged: (DateTime? value) {
                        print(value);
                        Jiffy newDate = Jiffy(value);
                        final diff = Jiffy().diff(newDate, Units.YEAR);
                        print(diff);
                        if (diff > 0) {
                          ageController.text = diff.toString();
                        }
                      },

                      // validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: activeColor,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: UIHelper.getInputBorder(1),
                        focusedBorder: UIHelper.getInputBorder(1),
                        focusedErrorBorder: UIHelper.getInputBorder(1),
                        errorBorder: UIHelper.getInputBorder(1),
                        hintText: "Date of Birth",
                      )),
                ),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('age', 'Age', Icons.person_outline),
                UIHelper.verticalSpaceSmall,
                FormBuilderDropdown(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: activeColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UIHelper.getInputBorder(1),
                    focusedBorder: UIHelper.getInputBorder(1),
                    focusedErrorBorder: UIHelper.getInputBorder(1),
                    errorBorder: UIHelper.getInputBorder(1),
                  ),
                  name: "gender",
                  hint: Text('Gender'),
                  key: UniqueKey(),
                  items: ['Male', 'Female']
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text("$cat")
                                .textColor(Colors.black)
                                .fontSize(16),
                          ))
                      .toList(),
                ),
                UIHelper.verticalSpaceSmall,
                //  addInputFormControl('bloodgroup', 'Blood Group', Icons.person_outline),
                FormBuilderDropdown(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: activeColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UIHelper.getInputBorder(1),
                    focusedBorder: UIHelper.getInputBorder(1),
                    focusedErrorBorder: UIHelper.getInputBorder(1),
                    errorBorder: UIHelper.getInputBorder(1),
                  ),
                  name: "bloodgroup",
                  key: UniqueKey(),
                  hint: Text('BloodGroup'),
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map((grp) => DropdownMenuItem(
                            //value: grp,
                            value: grp,
                            child: Text("$grp")
                                .textColor(Colors.black)
                                .fontSize(16),
                          ))
                      .toList(),
                ),

                UIHelper.verticalSpaceSmall,
                addInputFormControl(
                    'mobile', 'Mobile Number', Icons.phone_android_outlined),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('alternatemobilenumber', 'Alternate Number',
                    Icons.phone_android_outlined),
                UIHelper.verticalSpaceSmall,
                // addInputFormControl('address', 'Address', Icons.location_on),
                //GestureDetector( onTap: () async { await Get.to(() => ProfileView()); setState(() {}); },
                FormBuilderTextField(
                  style: loginInputTitleStyle,
                  name: "address",
                  autocorrect: false,
                  controller: addressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: activeColor,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.search,
                        color: activeColor,
                      ),
                      onTap: () => {},
                    ),
                    hintText: "Address",
                    hintStyle: loginInputHintTitleStyle,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UIHelper.getInputBorder(1),
                    focusedBorder: UIHelper.getInputBorder(1),
                    focusedErrorBorder: UIHelper.getInputBorder(1),
                    errorBorder: UIHelper.getInputBorder(1),
                  ),
                ),

                //selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),

                UIHelper.verticalSpaceSmall,
                addInputFormControl('country', 'Country', Icons.language),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('state', 'State', Icons.location_city),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('city', 'City', Icons.location_city),
                UIHelper.verticalSpaceSmall,
                addInputFormControl('zipcode', 'ZIP', Icons.location_city),
                UIHelper.verticalSpaceSmall,
                addInputFormControl(
                    'allergicto', 'Allergies', Icons.drag_handle),

                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back(result: {'refresh': false});
                        },
                        child: Text('CANCEL').textColor(Colors.white),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(80, 32)),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(activeColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))))),
                    ElevatedButton(
                        onPressed: () async {},
                        child: Text('SAVE'),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(80, 32)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))))),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: swaradminBar(),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: Screen.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceMedium,
                UIHelper.addHeader(context,
                    widget.isEditMode ? 'Edit Member' : "Add Member", true),
                UIHelper.verticalSpaceMedium,
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      formControls(context),
                      UIHelper.verticalSpaceMedium
                    ],
                  ),
                ))
              ],
            )));
  }
}
