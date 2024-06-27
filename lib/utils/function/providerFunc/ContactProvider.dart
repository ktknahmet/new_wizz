import 'package:easy_localization/easy_localization.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wizzsales/model/contactReferral/getReferral.dart';
import 'package:wizzsales/model/contactReferral/postReferral.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';

import '../../../model/contactModel/contactModel.dart';
// ignore_for_file: use_build_context_synchronously

class ContactProvider extends ChangeNotifier{
  bool? isChecked;
  String query="";
  List<ContactModel> contactModel=[];
  List<GetReferral> referral = [];
  String countryCode="1";


  changeCode(String code){
    countryCode = code;
    notifyListeners();
  }
  setQuery(String value){
    query = value;
    notifyListeners();
  }
  setCheck(List<ContactModel> list, String query,int index,bool value){
    searchContact(list,query)[index].isChecked = value;
    notifyListeners();
  }


  List<ContactModel> searchContact(List<ContactModel> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<ContactModel> filteredList = list.where((resource) => resource.displayName.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }
  Future<List<Contact>> getContact(BuildContext context) async{
    contactModel.clear();
    await FastContacts.allContacts.then((value) => {
      for(var i in value){
        contactModel.add(ContactModel(displayName: i.displayName,phones: i.phones[0].toString(), isChecked: false))
      }
    });
    print("kontaklar :${contactModel.length}");
    if(contactModel.isEmpty){
      snackBarDesign(context, StringUtil.warning, "notContactList".tr());
    }
    return await FastContacts.allContacts;

  }

  checkContactPermission(BuildContext context) async {
    PermissionStatus? status;

    await Permission.contacts.request().then((value) => {
      status = value
    });

    if (status!.isGranted) {
      isChecked=true;
      await getContact(context);
    } else{
      isChecked=false;
      snackBarDesign(context, StringUtil.error, "givePermissionContact".tr());
      Future.delayed(const Duration(seconds: 3)).then((_) => {
        openAppSettings(),
      });

    }
    notifyListeners();
  }

  getReferralList(BuildContext context) async{
     await UserVM.getReferral(context).then((value) => {
       referral=value!
     });
     notifyListeners();
  }

  addListFromContact(BuildContext context,List<ContactModel> contactList) async{

    List<PostReferral> customer =[];

    for(int i=0;i<contactList.length;i++){
      if(contactList[i].isChecked == true){
        String phone = await phoneFormat(contactList[i].phones);
        PostReferral postReferral = PostReferral(
            firstname: contactList[i].displayName,
            lastname: "",email: "",phone: phone);
        customer.add(postReferral);
      }
    }
    String data = postReferralToJson(customer);
    print("gönderilen data :$data");
    if(customer.isNotEmpty){
      await UserVM.postReferral(context, data).then((value) => {
        debugPrint("veriler :$value"),
        if(value=="OKEY"){
          customer.clear(),
        }
      });
    }else{
      snackBarDesign(context, StringUtil.warning, "youMustSelectContact".tr());
    }
    notifyListeners();
  }

}