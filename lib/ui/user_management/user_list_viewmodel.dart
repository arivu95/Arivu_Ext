import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/app/locator.dart';
import 'package:swaradmin/services/api_services.dart';
import 'package:swaradmin/services/preferences_service.dart';

class UserListViewmodel extends BaseViewModel {
  PreferencesService preferencesService = locator<PreferencesService>();
  ApiService apiService = locator<ApiService>();
  dynamic user = {};
  List<dynamic> members = [];
  List<dynamic> memberSec = [];
  List<dynamic> subscription = [];
  List<dynamic> memberSections = [];
  List<dynamic> filteredName = [];
  List<dynamic> countries = [];
  List<dynamic> labtestSections = [];
  List<dynamic> planList = [];
  int pageno = 1;
  int totalPage=0;
  dynamic userData = {};
  dynamic addSubId = {};

  Future getCountries() async {
    setBusy(true);
    countries = await apiService.getCountries();
    await getplan();
    setBusy(false);
  }

  Future getplan() async {
    setBusy(true);
    planList = await apiService.getplanList();
    await getmembers();
    setBusy(false);
  }

  Future getmembers() async {
    setBusy(true);
    String plan = '';
    String sub_id = '';
    user = await apiService.getUserList();
    if (user['records'] != null) {
      for (int i = 0; i < user['records'].length; i++) {
        addSubId = user['records'][i];

        String dateTime = '';
        if (user['records'][i]['createdAt'] != null) {
          Jiffy dt = Jiffy(user['records'][i]['createdAt']);
          dateTime = dt.format('dd-MM-yyyy');
        } else {
          dateTime = "";
        }
        sub_id = user['userplan'][i]['productId'];

        if (sub_id == "com.kat.swarapp.basic") {
          plan = "Basic";
        }
        if (sub_id == "com.kat.swarapp.yearly") {
          plan = "Yearly";
        }
        if (sub_id == "com.kat.swarapp.monthly") {
          plan = "Monthly";
        }
        addSubId['product'] = plan;
        addSubId['create'] = dateTime;
        members.add(addSubId);
      }
      memberSections = members.toList();
      memberSec = members.toList();
    }

    if (user['userplan'] != null) {
      subscription = user['userplan'];
    }
    await listofusers(1);
    setBusy(false);
  }

  void getMembers_search(String search) {
    memberSec = memberSections.where((e) {
      return e.toString().toLowerCase().contains(search.toLowerCase());
    }).toList();
    listofusers(pageno);
    setBusy(false);
  }

  Future listofusers(int page) async {
    members.clear();
    pageno = page;
    int startIndex = (page - 1) * 15;
    int endIndex1 = startIndex + 15;
    int totalCount = memberSec.length;
    int balance = totalCount-startIndex;
    int endIndex2 = balance+startIndex;
    
 for(int i=0;i<=totalCount/15;i++){
  totalPage= i+1;
 }
   if(balance<15){
       for (int i = startIndex; i <endIndex2; i++) {
            members.add(memberSec[i]);
      }
    }else{
       for (int i = startIndex; i <endIndex1; i++) {
            members.add(memberSec[i]);
      }
    }
    setBusy(false);
  }


  void getfilter_search(String country, String plan, String date,String name) {
      members.clear();
     memberSec = memberSections.where((e) {
      return e['name'].toString().toLowerCase().contains(name.toLowerCase())
      && e['country'].toString().toLowerCase().contains(country.toLowerCase())
      && e['product'].toString().toLowerCase().contains(plan.toLowerCase())
      && e['create'].toString().toLowerCase().contains(date.toLowerCase());
    }).toList();
    listofusers(pageno);
      setBusy(false);
     }

  void members_asc_sort() {
    members.sort((a, b) {
      return a['name']
          .toString()
          .toLowerCase()
          .compareTo(b['name'].toString().toLowerCase());
    });
    setBusy(false);
  }

  void members_desc_sort() {
    members.sort((a, b) {
      return b['name']
          .toString()
          .toLowerCase()
          .compareTo(a['name'].toString().toLowerCase());
    });
    setBusy(false);
  }

  Future updateactive(String userID, String status) async {
    final response = await apiService.updateactiveStatus(userID, status);
    await getmembers();
  }
}
