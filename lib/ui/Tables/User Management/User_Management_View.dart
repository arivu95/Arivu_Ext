import 'dart:convert';
import 'package:bs_flutter_card/bs_flutter_card.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:swaradmin/ui/Tables/User%20Management/User_table.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  final _router = FluroRouter.appRouter;
///////////// Route for Tables new/////////////////
  MyApp() {
    _router.define('/',
        handler: Handler(
          handlerFunc: (context, parameters) => UserTable(),
        ));
    _router.define('/test',
        handler: Handler(
          handlerFunc: (context, parameters) => Test(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing',
      // debugShowCheckedModeBanner: false testb,
      initialRoute: '/',
      onGenerateRoute: _router.generator,
    );
  }
}

class Test extends StatelessWidget {
  final _router = FluroRouter.appRouter;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () => _router.navigateTo(context, '/'),
              child: Text('Test'),
            )
          ],
        ),
      ),
    );
  }
}

///////// Table Class //////////////////
class UserTable extends StatefulWidget {
  @override
  _UserTableState createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  UserTableSource _source = UserTableSource();
  // UserTableSource _source1 = UserTableSource(data: [
  //   {'typeid': 0, 'typecd': 'TP1', 'typenm': 'Type 1'},
  //   {'typeid': 0, 'typecd': 'TP2', 'typenm': 'Type 2'},
  //   {'typeid': 0, 'typecd': 'TP3', 'typenm': 'Type 3'},
  //   {'typeid': 0, 'typecd': 'TP4', 'typenm': 'Type 4'},
  //   {'typeid': 0, 'typecd': 'TP5', 'typenm': 'Type 5'},
  // ]);

  @override
  void initState() {
    _source.controller = BsDatatableController();
    super.initState();
  }

  Future loadApi(Map<String, dynamic> params) {
    return http
        .post(
      Uri.parse('https://flutter_crud/api/public/types/datatables'),
      body: params,
    )
        .then((value) {
      Map<String, dynamic> json = jsonDecode(value.body);
      setState(() {
        _source.response = BsDatatableResponse.createFromJson(json['data']);
        // _source.onEditListener = (typeid, index) {
        //   _source.controller.reload();
        // };
        // _source1.onEditListener = (typeid, index) {
        //   final data = _source1.get(index);
        //   data['typenm'] = 'Edited';

        //   _source1.put(index, data);
        // };
        // _source1.onDeleteListener = (typeid, index) {
        //   _source1.removeAt(index);
        // };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: BsCard(
                children: [
                  BsCardContainer(title: Text('User Management'), actions: [
                    TextButton(
                      onPressed: () {
                        _source.add({
                          'typecd': 'TP1',
                          'typenm': 'Type ${_source.datas.length}'
                        });
                      },
                      child: Text('Add Row'),
                    )
                  ]),
                  BsCardContainer(
                    child: BsDatatable(
                      source: _source,
                      //title: Text('Datatables Data'),
                      columns: UserTableSource.columns,
                      language: BsDatatableLanguage(
                          nextPagination: 'Next',
                          previousPagination: 'Previous',
                          information:
                              'Show __START__ to __END__ of __FILTERED__ entries',
                          informationFiltered:
                              'filtered from __DATA__ total entries',
                          firstPagination: 'First Page',
                          lastPagination: 'Last Page',
                          hintTextSearch: 'Search data ...',
                          perPageLabel: null,
                          searchLabel: null),
                      serverSide: loadApi,
                    ),
                  ),
                  // BsCardContainer(
                  //   child: BsDatatable(
                  //     source: UserTableSource(),
                  //     title: Text('Datatables Data'),
                  //     columns: UserTableSource.columns,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
