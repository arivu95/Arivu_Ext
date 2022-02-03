import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/preferences_service.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/custom_dialog_box.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/covid_management/add_vaccine_viewmodel.dart';

//testt
class AddCovidRecords extends StatefulWidget {
  dynamic selectData;
   AddCovidRecords( {Key? key,this.selectData}) : super(key: key);
  static const String id = 'add-covid-records';
  @override
  _LanguSelectViewState createState() => _LanguSelectViewState();
}

class _LanguSelectViewState extends State<AddCovidRecords> {
  PreferencesService preferencesService = locator<PreferencesService>();
   TextEditingController _covidvaccineController = TextEditingController();
   
  String vaccine_new = 'true';
  bool isload = false;
  List<String> docIds = [];
  List<String> doc = [];
 
  Widget selectvaccine(BuildContext context, AddvaccineViewmodel model) {
      if (widget.selectData['vaccination_name'] != null) {
    _covidvaccineController.text= widget.selectData['vaccination_name'].toString();
   vaccine_new='false';
     }
    if (widget.selectData['dosestatus'] != null) {
    List dosestatus = widget.selectData['dosestatus'] ?? [];
   //  doc.clear();   
     for(int i=0;i<dosestatus.length;i++){
     doc.add(dosestatus[i]['_id']);
    }
   }
    return TextField(
            controller: _covidvaccineController,
            onChanged: (value) {
            },
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              filled: true,
              hintText: 'Enter a Vaccine Name',
              fillColor: Colors.white,
              enabledBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              focusedErrorBorder:
                  UIHelper.getInputBorder(1, borderColor: Colors.black),
              errorBorder: UIHelper.getInputBorder(1, borderColor: activeColor),
            ),
          );
  }

  Widget covidbutton(BuildContext context, AddvaccineViewmodel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: isload == true
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text('Save'),
                    onPressed: () async {
                  if(vaccine_new=='true'){
                    if ((_covidvaccineController.text.isNotEmpty) &&(docIds.length >0) ){
                         await model.covidaddvaccine(                             
                              docIds,
                              _covidvaccineController.text);
                 _covidvaccineController.clear();
                          docIds.clear();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Done",
                                  descriptions:
                                      "Covid Vaccine Successfully Added",
                                  text: "OK",
                                );
                              });
                        } else {
                          if ((_covidvaccineController.text.isEmpty) &&(docIds.length >0) ){
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:"Vaccine name is mandatory",
                                  text: "OK",
                                );
                              });
                          }else if ((_covidvaccineController.text.isNotEmpty) &&(docIds.length == 0) ){
                             showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:"Dose is mandatory",
                                  text: "OK",
                                );
                              });
                          }else{
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                  descriptions:"Vaccine name and Dose is mandatory",
                                  text: "OK",
                                );
                              });
                          }
                        
                        }
                  }else{
                   if (_covidvaccineController.text.isNotEmpty){ 
                 await model.covidvaccineupdated(widget.selectData['_id'], docIds,_covidvaccineController.text);
                  widget.selectData['vaccination_name']=_covidvaccineController.text;
                  
                   await Future.forEach(docIds, (String url) async {
                     setState(() {
                       doc.add(url);
                      });
                     docIds.clear();
                //  print('tam'+doc.toString());
                //     
               
                // print('tamil'+doc.toString());

                   
                    });
                       
                         } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Warning !",
                                   descriptions:"Require Vaccine Name",
                                   text: "OK",
                                );
                              });
                        }                      
                  }    
               
                 
                        },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFDE2128)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18))),
                  ),
          ),
        ),
      ],
    );
  }

 Widget headerItem(String title, Color bgColor) {
    return Expanded(
      child: Container(
        height: 30,
        alignment: Alignment.center,
        color: bgColor,
        child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
      ),
    );
  }

  Widget headerItem1(String title, Color bgColor, double width) {
    return Container(
      height: 30,
      width: width,
      alignment: Alignment.center,
      // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          left: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: Text(title).bold().fontSize(14).textAlignment(TextAlign.center),
    );
  }
  
  void onDocSelect(String docid) {
    if (docIds.contains(docid)) {
       docIds.remove(docid);
      } else {
      docIds.add(docid);
     }
      setState(() {});
    if (vaccine_new=='false') {
       setState(() {
        widget.selectData['vaccination_name']=_covidvaccineController.text;  
     });
    }
     }
  
  Widget addMatDataItem(BuildContext context, int index, AddvaccineViewmodel model, dynamic data, String rootDocId) {
    return Container(
      color: index % 2 == 0 ? Colors.white : fieldBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Expanded(
        child:Container(
          //   width:70,
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
             child: Text('${index + 1}').bold().fontSize(14).textAlignment(TextAlign.center),
         ),  ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2, 8, 0, 8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child:doc.contains(data['_id'])?
              Text(data['dose'])
                  .fontSize(16)
                  .fontWeight(FontWeight.w600)
                  .textColor(disabledColor)
            :
             Text(data['dose'])
                  .fontSize(16)
                  .fontWeight(FontWeight.w600)
                  .textColor(activeColor)
            ) 
          ),
           Expanded(
         child: Container(
          //  width:100,
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            child: doc.contains(data['_id'])?
            Icon(Icons.check_box,
                  color:disabledColor,
                ):
            docIds.contains(data['_id'])?
            GestureDetector(
                      onTap: () async {
                          onDocSelect(data['_id']);
                      },
                      child: Icon(
                        Icons.check_box,
                        color:addToCartColor,
                      ),
                    ):
            GestureDetector(
                      onTap: () async {
                   onDocSelect(data['_id']);
                     },
                      child: Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                    ),
          ),
           ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ViewModelBuilder<AddvaccineViewmodel>.reactive(
          onModelReady: (model) async {
           await model.getdoselist();
          },
          builder: (context, model, child) {
            return   model.isBusy
                      ? Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ): 
             Container(
                padding: EdgeInsets.all(10),
                child:
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   selectvaccine(context, model),
                    UIHelper.verticalSpaceSmall,
                  
                    Container(
                      width: Screen.width(context),
                      decoration: UIHelper.roundedBorderWithColor(
                          6, Colors.transparent,
                          borderColor: Colors.black12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              headerItem('SI No.', Color(0xFFECECEC)),
                              headerItem('Dose', fieldBgColor),
                              headerItem('Actions', Color(0xFFECECEC)),
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
                              itemCount: model.coviddose.length,
                              itemBuilder: (context, index) {
                                return addMatDataItem(context, index, model,
                                    model.coviddose[index], '');
                              }),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    covidbutton(context, model),
                    UIHelper.verticalSpaceMedium,
                 ],
                ));
          },
          viewModelBuilder: () => AddvaccineViewmodel()),
    );
  }
}

class Fontsize {}
