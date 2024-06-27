import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/CareerSales.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import '../model/OLD/User.dart';
// ignore_for_file: use_build_context_synchronously
class ProfileVm extends ChangeNotifier{
  SharedPref pref = SharedPref();
  String userType="";
  CareerSales? careerSales;
  LoginUser? loginUser;
  int index=0;
  User? user;
  int chooseUser=0;
  bool darkMode = false;




  getUserInfo(BuildContext context) async{
    SharedPref pref = SharedPref();
    loginUser = await getUser(context);
    user = await getUserUser(context);
    index = await pref.getInt(context, SharedUtils.profileIndex);
    int id = await pref.getInt(context, SharedUtils.profileId);

    print("seçilen user/role :${loginUser!.profiles![index].salesroleid.toString()} -- ${loginUser!.profiles![index].id.toString()} --${user!.roleType}");

    careerSales  = await UserVM.getCareerSales(context, id);
    notifyListeners();
  }
  updateRole(BuildContext context,int index) async{

    await pref.setString(SharedUtils.salesRoleId, loginUser!.profiles![index].salesroleid.toString());
    await pref.setString(SharedUtils.activeProfile, loginUser!.profiles![index].id.toString());
    await pref.setInt(SharedUtils.profileIndex, index);
    await pref.setInt(SharedUtils.orgId, loginUser!.profiles![index].organisation_id!);
    await pref.setInt(SharedUtils.profileId, loginUser!.profiles![index].id!);
    print("seçilen user/role :${loginUser!.profiles![index].salesroleid.toString()} -- ${loginUser!.profiles![index].id.toString()} --${loginUser!.userId!}");

    await getUserInfo(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/${PageName.mainHome}',
          (Route<dynamic> route) => false,
    );
    notifyListeners();
  }
  updateTheme(bool isDarkModeOn) async {
    await pref.setBool(SharedUtils.theme, isDarkModeOn);
    darkMode = isDarkModeOn;
    print("tema123 :$darkMode");

    notifyListeners();
  }

  setTheme(BuildContext context) async {
    darkMode = await pref.getBool(context, SharedUtils.theme);
    print("tema :$darkMode");
    notifyListeners();
  }
}