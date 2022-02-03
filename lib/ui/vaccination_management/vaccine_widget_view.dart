import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_viewmodel.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_list_view.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_view.dart';
import 'package:swaradmin/ui/vaccination_management/vaccine_master_view.dart';

class VaccineCommonView extends StatefulWidget {
  VaccineCommonView({Key? key}) : super(key: key);
  static const String id = 'vaccinepage';
  @override
  _VaccineTestViewState createState() => _VaccineTestViewState();
}

class _VaccineTestViewState extends State<VaccineCommonView> {
  TextEditingController searchController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();
  int selectedIndex = 0;

  Widget addheader(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AgeVaccinationView.id);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text('Vaccine Management').bold().fontSize(18),
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
                Text('Vaccine List').fontSize(16).fontWeight(FontWeight.w600),
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
            child: Text('Add Age wise vaccine')
                .fontSize(16)
                .fontWeight(FontWeight.w600),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService preferencesService = locator<PreferencesService>();
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
       appBar: _appBar.AppBarMenus(),
       sideBar: _sideBar.sideBarMenus(context, VaccineCommonView.id),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(25),
                  child: ViewModelBuilder<AddvaccineViewmodel>.reactive(
                      onModelReady: (model) async {
                        Loader.show(context);
                        await model.getCovidVaccines();
                        Loader.hide();
                      },
                      builder: (context, model, child) {
                        return Column(
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
                                        Text('Vaccine List').bold(),
                                        Text('Add Age Wise vaccine').bold(),
                                      ]),
                                  UIHelper.verticalSpaceMedium,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: MasterVaccineList(),
                                      ),
                                      UIHelper.horizontalSpaceLarge,
                                      Expanded(
                                        child: AddUserVaccineRecords(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      viewModelBuilder: () => AddvaccineViewmodel())),
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
                              ? MasterVaccineList()
                              : AddUserVaccineRecords(),
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
