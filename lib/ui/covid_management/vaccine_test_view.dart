import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/dont_access_msg.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/covid_management/covid_test_list_view.dart';
import 'package:swaradmin/ui/covid_management/covid_vaccine_list_view.dart';

class VaccineTestView extends StatefulWidget {
  VaccineTestView({Key? key}) : super(key: key);
  static const String id = 'test-covid';
  @override
  _VaccineTestViewState createState() => _VaccineTestViewState();
}

class _VaccineTestViewState extends State<VaccineTestView> {
  TextEditingController searchController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  int selectedIndex = 0;

  Widget addheader(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // GestureDetector(
          //   onTap: () {
          //  //   Navigator.of(context).pushNamed(CountryListView.id);
          //   },
          //   child: Icon(
          //     Icons.arrow_back_ios,
          //     size: 20,
          //   ),
          // ),
          Text('COVID Record Management').bold().fontSize(18),
        ],
      ),
    );
  }

  Widget selectCatgory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          child: Container(
            decoration: selectedIndex == 0
                ? UIHelper.rowSeperator(activeColor)
                : UIHelper.rowSeperator(Colors.white),
            padding: EdgeInsets.all(4),
            child:
                Text('COVID Vaccine').fontSize(16).fontWeight(FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
          child: Container(
            decoration: selectedIndex == 1
                ? UIHelper.rowSeperator(activeColor)
                : UIHelper.rowSeperator(Colors.white),
            padding: EdgeInsets.all(4),
            child: Text('Lab Test').fontSize(16).fontWeight(FontWeight.w600),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
     swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
       appBar: _appBar.AppBarMenus(),
      sideBar: _sideBar.sideBarMenus(context, VaccineTestView.id),
      body: preferencesService.covid_accessInfo['view'] == "false"
          ? withoutAccess()
          : LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                addheader(context),
                                UIHelper.verticalSpaceMedium,
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('COVID Vaccine').bold(),
                                      Text('Lab Test').bold(),
                                    ]),
                                UIHelper.verticalSpaceMedium,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CovidvaccineList(),
                                    ),
                                    UIHelper.horizontalSpaceLarge,
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: CovidTestList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                addheader(context),
                                UIHelper.verticalSpaceMedium,
                                selectCatgory(context),
                                UIHelper.verticalSpaceMedium,
                                selectedIndex == 0
                                    ? CovidvaccineList()
                                    : CovidTestList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
