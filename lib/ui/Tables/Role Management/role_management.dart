import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/sidebar.dart';

class RoleManagement extends StatelessWidget {
  static const String id = 'role-management';
  //const UserManagment({Key? key}) : super(key: key) testd;

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
      swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: _appBar.AppBarMenus(),
       sideBar: _sideBar.sideBarMenus(context, RoleManagement.id),
      body: Container(
        child: Center(
          child: RoleManagementPage(),
        ),
      ),
    );
  }
}

class RoleManagementPage extends StatefulWidget {
  const RoleManagementPage({Key? key}) : super(key: key);

  @override
  _RoleManagementPageState createState() => _RoleManagementPageState();
}

class _RoleManagementPageState extends State<RoleManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Container(
            //height: 700,
            child: Container(
              margin: const EdgeInsets.only(left: 50.0, right: 50.0, top: 50),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 7), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const ListTile(
                    //leading: Icon(Icons.album),
                    title: Text(
                      'Role Permission',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(''),
                  ),
                  const ListTile(
                    //leading: Icon(Icons.album),
                    title: Text(
                      'Role Management',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(''),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'View ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Add',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Delete',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      const ListTile(
                        //leading: Icon(Icons.album),
                        title: Text(
                          'Vaccination',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(''),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'View ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Add',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Delete',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      const ListTile(
                        //leading: Icon(Icons.album),
                        title: Text(
                          'User Management',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'View ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Add',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                      FormBuilderCheckbox(
                        name: 'accept_terms',
                        initialValue: false,
                        //onChanged: _onChanged,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Delete',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.equal(
                          context,
                          true,
                          errorText:
                              'You must accept terms and conditions to continue',
                        ),
                      ),
                    ],
                  ),

                  //const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            child: Text('Cancel'),
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFDE2128)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(18)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 18))),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            child: Text('Save'),
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF00C064)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(18)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 18))),
                          ),
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
}
