import 'dart:convert';
import 'package:bs_flutter_card/bs_flutter_card.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swaradmin/ui/Tables/User%20Management/User%20Table/user_table.dart';
import 'package:swaradmin/ui/Tables/User%20Management/User_table.dart';

class MyApp extends StatelessWidget {
  final _router = FluroRouter.appRouter;
///////////// Route for Tables new/////////////////
  MyApp() {
    _router.define('/',
        handler: Handler(
          handlerFunc: (context, parameters) => Userstable(),
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
    return Scaffold(
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
class Userstable extends StatefulWidget {
  @override
  _UserstableState createState() => _UserstableState();
}

class _UserstableState extends State<Userstable> {
  ClientTableSource _source = ClientTableSource();
  final _router = FluroRouter.appRouter;

  @override
  void initState() {
    _source.controller = BsDatatableController();
    super.initState();
  }

  Future loadApi(Map<String, dynamic> params) {
    return http
        .get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      //body: params,
    )
        .then((value) {
      Map<String, dynamic> json = jsonDecode(value.body);
      setState(() {
        _source.response = BsDatatableResponse.createFromJson(json['data']);
        _source.onEditListener = (typeid) {
          _source.controller.reload();
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Flutter Datatables.net'),
        // ),

        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: BsCard(
                children: [
                  BsCardContainer(title: Text(''), actions: [
                    ElevatedButton(
                      onPressed: () => _router.navigateTo(context, '/test'),
                      child: Text('Test'),
                    )
                  ]),
                  BsCardContainer(
                    child: BsDatatable(
                      source: _source,
                      title: Text('User Mangement'),
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
                          perPageLabel: 'Page Length',
                          searchLabel: 'Search Form'),
                      serverSide: loadApi,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
