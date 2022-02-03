import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/user_management/user_list_view.dart';
import 'package:swaradmin/ui/user_management/view_usermodel.dart';

class UserdetailsView extends StatefulWidget {
  dynamic usedData;
  dynamic userplan;
  UserdetailsView({Key? key, this.usedData, this.userplan}) : super(key: key);
  static const String id = 'user-management';
  @override
  _UserdetailsViewState createState() => _UserdetailsViewState();
}

class _UserdetailsViewState extends State<UserdetailsView> {
  TextEditingController searchController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  String isSort = 'asc';

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.grey),
            left: BorderSide(width: 0.5, color: Colors.grey),
            top: BorderSide(width: 0.5, color: Colors.grey),
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        //color: bgColor,
        child: Text(title.toUpperCase())
            .bold()
            .fontSize(16)
            .textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      width: width,
      height: 60,
      alignment: Alignment.center,
      color: bgColor,
      child: Text(title.toUpperCase())
          .bold()
          .fontSize(16)
          .textAlignment(TextAlign.center),
    );
  }

  Widget addHeader(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(UserControl.id);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text('User Profile').bold().fontSize(20),
        ],
      ),
    );
  }

  Widget personalDataItem(
    BuildContext context,
    //int index,
  ) {
    String img_url = '';
    if (widget.usedData['azureBlobStorageLink'] != null) {
      String imgurl = widget.usedData['azureBlobStorageLink'].toString();
      if (imgurl.isNotEmpty) {
        img_url = '${ApiService.fileStorageEndPoint}${imgurl}';
      }
    }
    String date_time = '';
    if (widget.usedData['createdAt'] != null) {
      Jiffy dt = Jiffy(widget.usedData['createdAt']);
      date_time = dt.format('dd-MM-yyyy');
    } else {
      // Jiffy dt = Jiffy(data['createdAt']);
      date_time = "";
    }
    String sub_date = '';
    if (widget.userplan['purchaseTime'] != null) {
      Jiffy dt = Jiffy(widget.userplan['purchaseTime']);
      sub_date = dt.format('dd-MM-yyyy');
    } else {
      sub_date = "";
    }
    String plan = '';
    if (widget.userplan['productId'] == "com.kat.swarapp.basic") {
      plan = "Basic";
    } else if (widget.userplan['productId'] == "com.kat.swarapp.yearly") {
      plan = "Yearly";
    } else if (widget.userplan['productId'] == "com.kat.swarapp.monthly") {
      plan = "Monthly";
    } else {
      plan = "";
    }
    String paymentmode = '';
    if (widget.userplan['platform'] == "Android") {
      paymentmode = "Play Store";
    } else if (widget.userplan['platform'] == "IOS") {
      paymentmode = "App Store";
    } else {
      paymentmode = "";
    }
    return Container(
      width: Screen.width(context) / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: <Widget>[
                  img_url == '' || img_url.contains('null')
                      ? Container(
                          child: Icon(Icons.account_circle,
                              size: 100, color: Colors.grey),
                          width: 100,
                          height: 100,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: UIHelper.getImage(img_url, 100, 100)),
                ],
              ),
              UIHelper.horizontalSpaceSmall,
              Text(widget.usedData['name'] != null
                      ? widget.usedData['name']
                      : '')
                  .fontSize(20)
                  .fontWeight(FontWeight.w800),
            ],
          ),
          UIHelper.verticalSpaceMedium,
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('User Information',
                style: TextStyle(
                  color: activeColor,
                )).fontSize(24).fontWeight(FontWeight.w700),
          ]),
          UIHelper.verticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(widget.usedData['name'] != null
                          ? widget.usedData['name']
                          : '')
                      .fontSize(18)
                      .fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Mail id ')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(widget.usedData['email'] != null
                          ? widget.usedData['email']
                          : '')
                      .fontSize(18)
                      .fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Subcription')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(plan).fontSize(18).fontWeight(FontWeight.w600),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Country')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(widget.usedData['country'] != null
                          ? widget.usedData['country']
                          : '')
                      .fontSize(18)
                      .fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Phone')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(widget.usedData['mobilenumber'] != null
                          ? widget.usedData['mobilenumber']
                          : '')
                      .fontSize(18)
                      .fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Subscription Date')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(sub_date).fontSize(18).fontWeight(FontWeight.w600),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  widget.usedData['active_flag'] == true
                      ? Text('Active').fontSize(18).fontWeight(FontWeight.w600)
                      : Text('Inactive')
                          .fontSize(18)
                          .fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Created on')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(date_time).fontSize(18).fontWeight(FontWeight.w600),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mode of Payment')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Text(paymentmode).fontSize(18).fontWeight(FontWeight.w600),
                  UIHelper.verticalSpaceMedium,
                  Text('Address')
                      .fontSize(18)
                      .fontWeight(FontWeight.w400)
                      .textColor(Colors.black38),
                  UIHelper.verticalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.usedData['address'] != null
                              ? widget.usedData['address']
                              : '')
                          .fontSize(14)
                          .fontWeight(FontWeight.w600),
                      Text(widget.usedData['city'] != null
                              ? widget.usedData['city']
                              : '')
                          .fontSize(14)
                          .fontWeight(FontWeight.w600),
                      Text(widget.usedData['state'] != null
                              ? widget.usedData['state']
                              : '')
                          .fontSize(14)
                          .fontWeight(FontWeight.w600),
                      Text(widget.usedData['zipcode'] != null
                              ? widget.usedData['zipcode']
                              : '')
                          .fontSize(14)
                          .fontWeight(FontWeight.w600),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget personalmobileData(BuildContext context) {
    String img_url = '';
    if (widget.usedData['azureBlobStorageLink'] != null) {
      String imgurl = widget.usedData['azureBlobStorageLink'].toString();
      if (imgurl.isNotEmpty) {
        img_url = '${ApiService.fileStorageEndPoint}${imgurl}';
      }
    }
    String date_time = '';
    if (widget.usedData['createdAt'] != null) {
      Jiffy dt = Jiffy(widget.usedData['createdAt']);
      date_time = dt.format('dd-MMM-yyyy');
    } else {
      // Jiffy dt = Jiffy(data['createdAt']);
      date_time = "";
    }
    String sub_date = '';
    if (widget.userplan['purchaseTime'] != null) {
      Jiffy dt = Jiffy(widget.userplan['purchaseTime']);
      sub_date = dt.format('dd-MM-yyyy');
    } else {
      sub_date = "";
    }
    String plan = '';
    if (widget.userplan['productId'] == "com.kat.swarapp.basic") {
      plan = "Basic";
    } else if (widget.userplan['productId'] == "com.kat.swarapp.yearly") {
      plan = "Yearly";
    } else if (widget.userplan['productId'] == "com.kat.swarapp.monthly") {
      plan = "Monthly";
    } else {
      plan = "";
    }
    String paymentmode = '';
    if (widget.userplan['platform'] == "Android") {
      paymentmode = "Play Store";
    } else if (widget.userplan['platform'] == "IOS") {
      paymentmode = "App Store";
    } else {
      paymentmode = "";
    }
    return Container(
      width: Screen.width(context),
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              img_url == '' || img_url.contains('null')
                  ? Container(
                      child: Icon(Icons.account_circle,
                          size: 100, color: Colors.grey),
                      width: 100,
                      height: 100,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: UIHelper.getImage(img_url, 100, 100)),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Text(widget.usedData['name'] != null ? widget.usedData['name'] : '')
              .fontSize(18)
              .fontWeight(FontWeight.w800),
          UIHelper.verticalSpaceMedium,
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('User Information', style: TextStyle(color: activeColor))
                .fontSize(20)
                .fontWeight(FontWeight.w700),
          ]),
          UIHelper.verticalSpaceMedium,
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Full Name')
                    .fontSize(14)
                    .fontWeight(FontWeight.w400)
                    .textColor(Colors.black38),
                Text(widget.usedData['name'] != null
                        ? widget.usedData['name']
                        : '')
                    .fontSize(14)
                    .fontWeight(FontWeight.w600),
              ]),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mail id ')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(widget.usedData['email'] != null
                      ? widget.usedData['email']
                      : '')
                  .fontSize(14)
                  .fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phone')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(widget.usedData['mobilenumber'] != null
                      ? widget.usedData['mobilenumber']
                      : '')
                  .fontSize(14)
                  .fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Country')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(widget.usedData['country'] != null
                      ? widget.usedData['country']
                      : '')
                  .fontSize(14)
                  .fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              widget.usedData['active_flag'] == true
                  ? Text('Active').fontSize(14).fontWeight(FontWeight.w600)
                  : Text('Inactive').fontSize(14).fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mode of Payment')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(paymentmode).fontSize(14).fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subscription Date')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(sub_date).fontSize(14).fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Address')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              Text(widget.usedData['address'] != null
                      ? widget.usedData['address']
                      : '')
                  .fontSize(14)
                  .fontWeight(FontWeight.w600),
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Created on')
                  .fontSize(14)
                  .fontWeight(FontWeight.w400)
                  .textColor(Colors.black38),
              UIHelper.verticalSpaceSmall,
              Text(date_time).fontSize(14).fontWeight(FontWeight.w600),
            ],
          ),
        ],
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      UserdetailsViewmodel model, dynamic data, String rootDocId) {
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 70,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child:
                Text('${index + 1}').fontSize(14).fontWeight(FontWeight.w600),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data[0]['member_first_name'] != null
                    ? data[0]['member_first_name']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data[0]['relation'] != null ? data[0]['relation'] : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: Text(data[0]['member_email'] != null
                    ? data[0]['member_email']
                    : '')
                .fontSize(14)
                .fontWeight(FontWeight.w600),
          )),
        ],
      ),
    );
  }

  @override
  Widget tableData(BuildContext context, UserdetailsViewmodel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // personalDataItem(context),
            UIHelper.verticalSpaceLarge,
            Text('Members list ', style: TextStyle(color: activeColor))
                .fontSize(24)
                .fontWeight(FontWeight.w700),
            UIHelper.verticalSpaceSmall,
            Container(
              decoration: UIHelper.roundedBorderWithColor(
                  12, Colors.transparent,
                  borderColor: Colors.black12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      headerItem1('SI No.', Color(0xffbdbdbd), 70),
                      headerItem('Name', Color(0xffbdbdbd)),
                      headerItem('Relation', Color(0xffbdbdbd)),
                      headerItem('Email', Color(0xffbdbdbd)),
                      // headerItem('Details', Color(0xFFECECEC)),
                    ],
                  ),
                  Container(
                    color: Colors.black12,
                    height: 1,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.members.length,
                    itemBuilder: (context, index) {
                      return addMatDataItem(
                          context, index, model, model.members[index], '');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
      appBar: _appBar.AppBarMenus(),
      sideBar: _sideBar.sideBarMenus(context, UserdetailsView.id),
      body: ViewModelBuilder<UserdetailsViewmodel>.reactive(
          onModelReady: (model) async {
            Loader.show(context);
            await model.getmembers(widget.usedData['_id']);
            Loader.hide();
          },
          builder: (context, model, child) {
            return LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addHeader(context),
                            UIHelper.verticalSpaceMedium,
                            personalDataItem(context),
                            tableData(context, model),
                          ],
                        )),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addHeader(context),
                            personalmobileData(context),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 650,
                                child: tableData(context, model),
                              ),
                            ),
                          ]),
                    ),
                  );
                }
              },
            );
          },
          viewModelBuilder: () => UserdetailsViewmodel()),
    );
  }
}
