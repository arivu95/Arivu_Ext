import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/sidebar.dart';

//void main() => runApp(MyApp());

class ViewUser extends StatelessWidget {
  static const String id = 'view-user';
  //const UserManagment({Key? key}) : super(key: key) testd;

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      backgroundColor: Colors.white,
        appBar: _appBar.AppBarMenus(),
         sideBar: _sideBar.sideBarMenus(context, ViewUser.id),
      body: Container(
        child: Center(
          child: UserForm(),
        ),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            // Even Padding On All Sides
            padding: EdgeInsets.all(80.0),
            //  margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Arun',
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Arun@gmail.com',
                          ),
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
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '9176678511',
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'chennai',
                          ),
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
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'active',
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Gpay',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFDE2128)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 16))),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF00C064)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 16))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //       child: TextField(
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //           hintText: 'Enter a search term',
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    //       child: TextFormField(
    //         decoration: InputDecoration(
    //           border: UnderlineInputBorder(),
    //           labelText: 'Enter your username',
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
