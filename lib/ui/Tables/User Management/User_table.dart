import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swaradmin/ui/Tables/User%20Management/user_management.dart';

class UserTableSource extends BsDatatableSource {
  static List<BsDataColumn> get columns => <BsDataColumn>[
        BsDataColumn(
            label: Text('SI No.'),
            orderable: true,
            searchable: false,
            width: 100.0),
        BsDataColumn(label: Text('Name'), columnName: 'userId', width: 200.0),
        BsDataColumn(label: Text('Plan'), columnName: '_id'),
        BsDataColumn(label: Text('Country'), columnName: 'email'),
        BsDataColumn(label: Text('Storage Used'), columnName: 'typenm'),
      ];

set onEditListener(Function(UserManagment) onEditListener) {}

  @override
  BsDataRow getRow(int index) {
    ValueChanged<dynamic> onEditListener = (value) {};
    ValueChanged<dynamic> onDeleteListener = (value) {};
    ////////////// on changed new testb  ////////////////////////
    return BsDataRow(index: index, cells: <BsDataCell>[
      BsDataCell(Text('${controller.start + index + 1}')),
      //BsDataCell(Text('Test')),
      BsDataCell(Text('${response.data[index]['userId']}')),
      BsDataCell(Text('${response.data[index]['_id']}')),
      BsDataCell(Text('${response.data[index]['email']}')),
      BsDataCell(Text('${response.data[index]['typenm']}')),
    ]);
  }
}

class typeid {}
