import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientTableSource extends BsDatatableSource {
  static List<BsDataColumn> get columns => <BsDataColumn>[
        BsDataColumn(
            label: Text('SI No.'),
            orderable: false,
            searchable: false,
            width: 100.0),
        BsDataColumn(label: Text('Code'), columnName: 'typecd', width: 200.0),
        BsDataColumn(label: Text('Name'), columnName: 'typenm'),
      ];

  set onEditListener(Null Function(typeid) onEditListener) {}

  @override
  BsDataRow getRow(int index) {
    ValueChanged<dynamic> onEditListener = (value) {};
    ValueChanged<dynamic> onDeleteListener = (value) {};
    ////////////// on changed new testb  ////////////////////////
    return BsDataRow(index: index, cells: <BsDataCell>[
      BsDataCell(Text('${controller.start + index + 1}')),
      BsDataCell(Text('${response.data[index]['typecd']}')),
      BsDataCell(Text('${response.data[index]['typenm']}')),
    ]);
  }
}

class typeid {}
//BsDataColumn