import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_bar.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/sidebar.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/ui/vaccination_management/age_master_list_view.dart';
import 'package:swaradmin/ui/vaccination_management/vaccination_country_viewmodel.dart';
import 'package:swaradmin/ui/vaccination_management/vaccine_master_view.dart';
import 'age_master_view.dart';

class VaccineCountryControl extends StatelessWidget {
  static const String id = 'vaccination-country-mgt';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    swaradminBar _appBar = swaradminBar();
    return AdminScaffold(
        backgroundColor: activeColor,
          appBar: _appBar.AppBarMenus(),
           sideBar: _sideBar.sideBarMenus(context, VaccineCountryControl.id),
        body: Center(
          child: VaccinationListView(),
        ));
  }
}

//test
class VaccinationListView extends StatefulWidget {
  VaccinationListView({Key? key}) : super(key: key);
  static const String id = 'vaccine-country';
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<VaccinationListView> {
  TextEditingController searchController = TextEditingController();
  PreferencesService preferencesService = locator<PreferencesService>();

  Widget showSearchField(
      BuildContext context, VaccinationcountryViewModel model) {
    return Container(
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          model.getcountry_search(value);
        },
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: activeColor,
              size: 20,
            ),
            suffixIcon: searchController.text.isEmpty
                ? SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      model.getcountry_search('');
                      searchController.clear();
                    }),
            contentPadding: EdgeInsets.only(left: 20),
            enabledBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            focusedBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            focusedErrorBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            errorBorder: UIHelper.getInputBorder(0,
                radius: 12, borderColor: Color(0xFFCCCCCC)),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: "Search By Country...",
            fillColor: fieldBgColor),
      ),
    );
  }

  Future<void> _addvaccine_Dialog(
      BuildContext context, VaccinationcountryViewModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('USER Vaccine'),
                GestureDetector(
                  onTap: () async {
                    await model.getCountries();
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.disabled_by_default,
                    color: activeColor,
                    size: 35,
                  ),
                ),
              ],
            ),
            content: Container(
              width: 580,
              child: AddUserVaccineRecords(),
            ),
          );
        });
  }

  Future<void> _vaccine_dialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vaccine'),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.disabled_by_default,
                    color: activeColor,
                    size: 35,
                  ),
                ),
              ],
            ),
            content: Container(
              width: 580,
              child: MasterVaccineList(),
            ),
          );
        });
  }

  Widget showIcon(BuildContext context, VaccinationcountryViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () async {
            await _addvaccine_Dialog(context, model);
           },
          child: Row(
            children: [
              Icon(
                Icons.add_circle,
                color: activeColor,
                size: 25,
              ),
              Text('Country wise Vaccine')
            ],
          ),
        ),
        UIHelper.horizontalSpaceMedium,
        GestureDetector(
          onTap: () async {
          
         await _vaccine_dialog(context);
          },
          child: Row(
            children: [
              Icon(
                Icons.data_saver_on_outlined,
                color: activeColor,
                size: 25,
              ),
              Text('Vaccine')
            ],
          ),
        ),
      ],
    );
  }

  Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 60,
        alignment: Alignment.center,
        // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
        color: bgColor,
        child: Text(title).bold().fontSize(16).textAlignment(TextAlign.center),
      ),
    );
  }

  Widget addMatDataItem(BuildContext context, int index,
      VaccinationcountryViewModel model, dynamic data, String rootDocId) {
    String create_date = '';
    if (data['createdAt'] == null) {
      create_date = "";
    } else {
      Jiffy dt = Jiffy(data['createdAt']);
      create_date = dt.format('dd-MM-yyyy');
    }

    String update_date = '';
    if (data['updatedAt'] == null) {
      update_date = "";
    } else {
      Jiffy dt = Jiffy(data['updatedAt']);
      update_date = dt.format('dd-MM-yyyy');
    }

    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child:
                Text('${index + 1}').fontSize(14).fontWeight(FontWeight.w600),
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
            child:
                Text(data['country']).fontSize(14).fontWeight(FontWeight.w600),
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
              child: Text(create_date).fontSize(14).fontWeight(FontWeight.w600),
            ),
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
              child: Text(update_date).fontSize(14).fontWeight(FontWeight.w600),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AgeVaccinationView(countryid: data['country_Id'].toString()),
              //   ),
              // );
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black12),
                  ),
                ),
                child:Icon(Icons.visibility_outlined),

               //     Text('View').fontSize(14).textColor(Colors.black26).bold(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget tableData(BuildContext context,VaccinationcountryViewModel model) {
    SideBarWidget _sideBar = SideBarWidget();
    return Scaffold(
    body:SingleChildScrollView(
        child: Container(
           child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vaccination').fontSize(20).fontWeight(FontWeight.w700),
                      UIHelper.verticalSpaceMedium,
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: showSearchField(context, model),
                            ),
                            new Flexible(
                              child: showIcon(context, model),
                            ),
                          ],
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Container(
                       // width: Screen.width(context),
                        decoration: UIHelper.roundedBorderWithColor(
                            12, Colors.transparent,
                            borderColor: Colors.black12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                headerItem('SI No.', Color(0xFFECECEC)),
                                headerItem('Country', fieldBgColor),
                                headerItem('Created Date', Color(0xFFECECEC)),
                                headerItem('Updated Date', fieldBgColor),
                                headerItem('Details', Color(0xFFECECEC)),
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
                                itemCount: model.countries.length,
                                itemBuilder: (context, index) {
                                  return addMatDataItem(context, index, model,
                                      model.countries[index], '');
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                
                ),
      ),
      
    );
  }

   Widget build(BuildContext context) {
    return Scaffold(
    body: ViewModelBuilder<VaccinationcountryViewModel>.reactive(
                onModelReady: (model) async {
                  Loader.show(context);
                  await model.getCountries();
                  Loader.hide();
                },
                builder: (context, model, child) {
           return  LayoutBuilder(
            builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
          return Container(
            padding: EdgeInsets.all(25),
             child:tableData(context,model),
           );
                } else {
                  return SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                  child: Container(
                    width:650,
                    padding: EdgeInsets.all(25),
                    child:tableData(context,model),
                  ),
                  );
          }
              },
            );
        },
                viewModelBuilder: () => VaccinationcountryViewModel()),
    );}

}
