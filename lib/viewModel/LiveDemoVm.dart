import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/model/OLD/Draw.dart';
import 'package:wizzsales/model/demoModel/demoNote.dart';
import 'package:wizzsales/model/demoModel/demoQuestions.dart';
import 'package:wizzsales/model/demoModel/demoUnsuccessModel.dart';
import 'package:wizzsales/model/demoModel/liveDemoList.dart';
import 'package:wizzsales/model/demoModel/postDemoQuestion.dart';
import 'package:wizzsales/model/demoModel/postLiveDemo.dart';
import 'package:wizzsales/model/expenseModel/expenseSale.dart';
import 'package:wizzsales/service/ServiceModule.dart';
import 'package:wizzsales/service/api/ApiService.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/notification/NotificationUtils.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class LiveDemoVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  String? assignSaleResponse;
  String? response;
  DemoQuestions? demoQuestions;
  String? cCountryCode;
  String? region;
  List<LiveDemoList>? demoList;
  String? postDemoQuestionResponse;
  List<LiveDemoList>? liveDemoList;
  bool arrivedCustomer=false;
  List<DemoUnsuccessModel>? demoUnResponse;
  String? demoNoteResponse;
  List<Draw>? leadList;
  String query="";
  String demoQuery ="";
  String? leadCode;
  int liveDemoType=0;
  List<String> answers = [];
  List<ExpenseSale>? expenseSale;
  String expenseQuery="";
  bool radioQuestion=true;
  bool checkBoxQuestion=false;
  bool boolNote=false;
  int questionStep=1;
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController appointment = TextEditingController();
  TextEditingController zipcode=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController county=TextEditingController();
  TextEditingController country=TextEditingController();

  setQaVisibilty(bool radio,bool checkBox){
    radioQuestion = radio;
    checkBoxQuestion = checkBox;

    notifyListeners();
  }

  setInformation(String cityy,String zipCode,String statee,String countyy,String name,String surname,String phone,String email,String homeAddress,String? code){
    city.text = cityy;
    zipcode.text=zipCode;
    state.text = statee;
    county.text =countyy;
    firstName.text = name;
    lastName.text = surname;
    cPhoneNumber.text = phone;
    emailController.text = email;
    address.text =homeAddress;
    appointment.text ="appointmentSelected".tr();
    leadCode=code;
    notifyListeners();

  }
  deleteInfo(){
    firstName.clear();
    lastName.clear();
    cPhoneNumber.clear();
    emailController.clear();
    address.clear();
    appointment.clear();
    leadCode=null;
    region = null;
    notifyListeners();
  }
  void setAnswerForQuestion(int index, String value) {
    if (index < answers.length) {
      answers[index] = value;
    } else {
      answers.add(value);
    }
    notifyListeners();
  }
  setArrivedCustomer(bool type){
    arrivedCustomer = type;
    notifyListeners();
  }

  setReason(int index, bool value, List<Reason> reasons) {
    for (int i = 0; i < reasons.length; i++) {
      if (i == index) {
        reasons[i].isChecked = value;
      } else {
        reasons[i].isChecked = false;
      }
    }



    notifyListeners();
  }

  String? getAnswerForQuestion(int index) {
    if (index < answers.length) {
      return answers[index];
    }
    return null;
  }
  setLiveViewType(int value){
    liveDemoType = value;
    notifyListeners();
  }

  setDemoQuery(String value){
    demoQuery = value;
    notifyListeners();
  }
  setExpenseQuery(String value){
    expenseQuery = value;
    notifyListeners();
  }

  List<ExpenseSale> searchSaleList(List<ExpenseSale> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<ExpenseSale> filteredList = list.where((resource) =>
    resource.cname!.toLowerCase().contains(query.toLowerCase()) || resource.serialid!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }

  List<Draw> searchAppointment(List<Draw> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<Draw> filteredList = list.where((resource) =>
    (resource.cname != null && resource.cname!.toLowerCase().contains(query.toLowerCase()))
        || (resource.cphone != null && resource.cphone!.toLowerCase().contains(query.toLowerCase()))
        || (resource.cemail != null && resource.cemail!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }

  setQuery(String value){
    query = value;
    notifyListeners();
  }
  List<LiveDemoList> searchDemos(List<LiveDemoList> list, String query) {
    if (query.isEmpty) {
      return list;
    }
    List<LiveDemoList> filteredList = list.where((resource) =>
    (resource.demoCustomerName != null && resource.demoCustomerName!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.demoCustomerPhone != null && resource.demoCustomerPhone!.toLowerCase().contains(query.toLowerCase())) ||
        (resource.status != null && resource.status!.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return filteredList;
  }
  changeCode(String code){
    cCountryCode = code;
    notifyListeners();
  }
  setType(String type){
    region = type;
    notifyListeners();
  }

  getDemoList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      demoList = await apiService.allDemos();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {

      notifyListeners();

    }

  }
  postDemoUnQuestion(BuildContext context,List<DemoUnsuccessModel> model) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postUnsuccessDemo(model).then((value) => {
        demoUnResponse=value,
      });
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }

  }

  postDemoNote(BuildContext context,DemoNote note) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postDemoNotes(note).then((value) => {
        demoNoteResponse=value,
        snackBarDesign(context, StringUtil.success, "questionSent".tr()),
        Navigator.pop(context),
      });
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }

  }

  postDemoDetail(BuildContext context,List<PostDemoQuestion> postDemoQuestion) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postDemoQuestions(postDemoQuestion).then((value) => {
        postDemoQuestionResponse=value,
        setQaVisibilty(false, true),
        questionStep =2

      });
    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();
    }

  }
  postSaleAssign(BuildContext context,int saleId,int demoId) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);


    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postAssignSale(saleId,demoId).then((value) => {
        assignSaleResponse =value,
        NotificationUtil().showNotification(title: "Successful",body: "saleRegistered".tr()),
        Navigator.pushNamedAndRemoveUntil(context, '/${PageName.mainHome}', (route) => route.isFirst,),
      });


    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {

        print("genel hata: $error");
      }
    } finally {
      notifyListeners();

    }

  }

  getLiveDemoList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      liveDemoList = await apiService.liveDemoList();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }

  getLeadList(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      leadList = await apiService.leadList();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      notifyListeners();
    }
  }

  postStartDemo(BuildContext context,PostLiveDemo demo) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.postStartDemo(demo).then((value) => {
        response =value,
        snackBarDesign(context, StringUtil.success, "demoAdded".tr()),
        Navigator.pop(context),

      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {
          snackBarDesign(context, StringUtil.error, res!.data);
        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }

  finishDemo(BuildContext context,int status,int id) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);

    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      await apiService.completeDemo(status,id).then((value) => {
        demoQuestions =value,
      });

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }
  getExpenseSale(BuildContext context) async{
    String token = await pref.getString(context, SharedUtils.userToken);
    String activeProfile = await pref.getString(context, SharedUtils.activeProfile);
    String salesRoleId = await pref.getString(context, SharedUtils.salesRoleId);
    showProgress(context, true);
    ApiService apiService = ApiService(ServiceModule().baseService(token,activeProfile,salesRoleId));
    notifyListeners();
    try {
      expenseSale = await apiService.saleList();

    } catch (error) {
      if (error is DioException) {
        final res = error.response;
        if (res?.statusCode == 400) {

        } else if (res?.statusCode == 401 || res?.statusCode == 403) {
          await deleteToken(context);
        }
      } else {
        // DioException değilse genel bir hata durumu
        print("General error: $error");
      }
    } finally {
      showProgress(context, false);
      notifyListeners();

    }

  }

}