import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/User.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/function/providerFunc/BottomNavProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/OLD/editProfile.dart';
import 'package:wizzsales/widgets/Extension.dart';

import 'Constant.dart';

Widget socialMediaAccount(BuildContext context, String name,
    TextEditingController controller, String photo) {
  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(name.tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
      ),
      const SizedBox(
        height: 4,
      ),
      TextField(
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        controller: controller,
        decoration: socialMediaTextDesign(context,photo,name),
        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
      ),
    ],
  );
}
Widget accountNumber(BuildContext context, String text, TextEditingController controller) {

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text.tr(),style: CustomTextStyle().semiBold12(
              ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
        ),
      ),
      const SizedBox(height: 4,),
      TextField(
        maxLines: null,
        controller: controller,
        keyboardType: TextInputType.number,
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        decoration: textFieldTextDesign(context,text),
        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
      ),
    ],
  );
}
Widget readOnlyText(BuildContext context, String text, TextEditingController controller) {

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text.tr(),style: CustomTextStyle().semiBold12(
              ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
        ),
      ),
      const SizedBox(height: 4,),
      TextField(
        maxLines: null,
        controller: controller,
        keyboardType: TextInputType.number,
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        decoration: textFieldTextDesign(context,text),
        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
        readOnly: true,
      ),
    ],
  );
}
Widget mailCreate(BuildContext context, String text, TextEditingController controller) {

  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(text.tr(),style: CustomTextStyle().semiBold12(ColorUtil()
              .getColor(context, ColorEnums.textTitleLight),),)
      ),
      const SizedBox(height: 4,),
      TextField(
        maxLines: null,
        controller: controller,
        keyboardType: TextInputType.multiline,
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        decoration: textFieldTextDesign(context,text),
        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
      ),
    ],
  );
}
Widget accountCreate(BuildContext context, String text, TextEditingController controller) {
  String capitalize(String s) {
    if (s.isNotEmpty) {
      return s[0].toUpperCase() + s.substring(1);
    } else {
      return "";
    }
  }

    void handleTextChange(String newText) {
      String capitalizedText = capitalize(newText);
      if (newText != capitalizedText) {
        controller.value = TextEditingValue(
          text: capitalizedText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: capitalizedText.length),
          ),
        );
      }
    }
    // Text alanında değişiklik dinleyicisi
    controller.addListener(() {
      String text = controller.text;
      String capitalizedText = capitalize(text);
      if (text != capitalizedText) {
        controller.value = TextEditingValue(
          text: capitalizedText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: capitalizedText.length),
          ),
        );
      }
    });
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(text.tr(),style: CustomTextStyle().semiBold12(ColorUtil()
                .getColor(context, ColorEnums.textTitleLight),),)
        ),
        const SizedBox(height: 4,),
        TextField(
          maxLines: null,
          controller: controller,
          keyboardType: TextInputType.multiline,
          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
          decoration: textFieldTextDesign(context,text),
          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
          onChanged: handleTextChange, // Metin değişikliklerini dinleyen işlev
          onTap: () {
            controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
          },
        ),
      ],
    );
  }

Widget serialNumber(BuildContext context, String text, TextEditingController controller) {
  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(text.tr(),style: CustomTextStyle().semiBold12(ColorUtil()
              .getColor(context, ColorEnums.textTitleLight),),)
      ),
      const SizedBox(height: 4,),
      TextField(
        maxLength: 8,
        controller: controller,
        keyboardType: TextInputType.phone,
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        decoration: textFieldTextDesign(context,text),
        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
      ),
    ],
  );
}

Widget navigationBar(){

  return ChangeNotifierProvider(
    create: (context) => BottomNavProvider(),
    child: Consumer<BottomNavProvider>(
      builder: (context,value,_){

        return BottomNavigationBar(
          backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
          elevation: 0,
          selectedLabelStyle: CustomTextStyle().regular10(ColorUtil().getColor(context,ColorEnums.textTitleLight)),
          currentIndex: value.currentIndex,
          onTap: (index){
            value.setIndex(context, index);
          },
          unselectedFontSize: 8,
          selectedFontSize: 8,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:ColorUtil().getColor(context,ColorEnums.textTitleLight),
          unselectedItemColor:ColorUtil().getColor(context,ColorEnums.textTitleLight),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: sizeWidth(context).width*0.06,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),), label: "home".tr()),
            BottomNavigationBarItem(icon: Image.asset("assets/bottomDemo.png",height: sizeWidth(context).width*0.06,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),), label:"startDemo".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.check,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),), label:"compDemo".tr()),
            BottomNavigationBarItem(icon: Image.asset("assets/appointment.png",height: sizeWidth(context).width*0.06, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),), label: "board".tr()),
            BottomNavigationBarItem(icon: Image.asset("assets/sale.png",height: sizeWidth(context).width*0.06,color: ColorUtil().getColor(context,ColorEnums.textDefaultLight),), label:"plusSale".tr()),

          ],

        );
      },
    ),

  );
}
Widget createDrawer(BuildContext context,LoginUser loginUser,int index,User user) {

  return Drawer(
    child: Container(
        color: ColorUtil().getColor(context, ColorEnums.background),
        child:   Stack(
          children: [
            Image.asset("assets/drawerPhoto.png",
              height: sizeWidth(context).height,
              width: sizeWidth(context).width,
              fit: BoxFit.fill,),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    child: user.image != null
                        ? ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(32),
                          // Image radius
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.gif',
                            image: user.image!,
                            fit: BoxFit.cover,
                          )),
                    )
                        : Image.asset(
                      "assets/uploadPhoto.webp",
                      fit: BoxFit.contain,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  loginUser.name!,
                  style: CustomTextStyle().bold20(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loginUser.profiles![index].salesrolename!.toUpperCase(),
                        style: CustomTextStyle().bold12(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                      ),

                      VerticalDivider(
                        color: ColorUtil().getColor(context, ColorEnums.whitePureLight),
                        thickness: 1,
                      ),

                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: loginUser.profiles![index].ranking == null ? 0.0 :  loginUser.profiles![index].ranking!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        unratedColor: ColorUtil().getColor(context, ColorEnums.whitePureLight),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.manage_accounts_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "myAccount".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const EditProfile()));
                          //Navigator.pushNamed(context, '/${PageName.myAccount}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.manage_accounts_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "social".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.updateSocial}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "profile".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.profile}');
                          //Navigator.pushNamed(context, '/${PageName.myAccount}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.folder_copy_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "resources".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.resources}');
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.manage_accounts_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "manageGoals".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.adminManageGoals}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "logout".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () async {
                          await deleteToken(context);
                        },
                      ),
                      sizeWidth(context).height<800 ? const SizedBox(height: 1,):
                      const SizedBox(height: 48,),
                      Divider(thickness: 1,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                      user.distributor == null ? Container() : Padding(
                        padding: const EdgeInsets.only(left: 20,right: 12),
                        child: Column(
                          children: [
                            Text("hylaDistributor".tr(), style: CustomTextStyle().bold14(ColorUtil().getColor(context,ColorEnums.whitePureLight)),),
                            Text(user.distributor!.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                            SizedBox(
                                width: sizeWidth(context).width,
                                child: Divider(thickness: 1,color:ColorUtil().getColor(context,ColorEnums.whitePureLight))),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: ColorUtil().getColor(context,ColorEnums.whitePureLight),),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.distributor!.phone ?? "", style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(Icons.local_post_office_outlined, size: 16, color: ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.distributor!.email ?? "",style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: ColorUtil().getColor(context,ColorEnums.whitePureLight),
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${user.distributor!.address ?? ""},${user.distributor!.city ?? ""},"
                                          "${user.distributor!.county ?? ""},"
                                          "${user.distributor!.state ?? ""}", style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 16),
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "salesApp".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "wizzCustomerApp".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "allRightReserved".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ],
        )
    ),
  );
}

Widget createAdminDrawer(BuildContext context,LoginUser loginUser,int index,User user) {

  return Drawer(
    child: Container(
        color: ColorUtil().getColor(context, ColorEnums.background),
        child:   Stack(
          children: [
            Image.asset("assets/drawerPhoto.png",
              height: sizeWidth(context).height,
              width: sizeWidth(context).width,
              fit: BoxFit.fill,),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    child: user.image != null
                        ? ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(32),
                          // Image radius
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.gif',
                            image: user.image!,
                            fit: BoxFit.cover,
                          )),
                    )
                        : Image.asset(
                      "assets/uploadPhoto.webp",
                      fit: BoxFit.contain,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  loginUser.name!,
                  style: CustomTextStyle().bold20(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loginUser.profiles![index].salesrolename!.toUpperCase(),
                        style: CustomTextStyle().bold12(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                      ),

                      VerticalDivider(
                        color: ColorUtil().getColor(context, ColorEnums.whitePureLight),
                        thickness: 1,
                      ),

                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: loginUser.profiles![index].ranking == null ? 0.0 :  loginUser.profiles![index].ranking!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        unratedColor: ColorUtil().getColor(context, ColorEnums.whitePureLight),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_border_outlined,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.manage_accounts_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "settings".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.adminSetting}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.manage_accounts_outlined,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "social".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/${PageName.updateSocial}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                        title: Text(
                          "logout".tr(),
                          style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                        ),
                        onTap: () async {
                          await deleteToken(context);
                        },
                      ),
                      sizeWidth(context).height<800 ? const SizedBox(height: 1,):
                      const SizedBox(height: 48,),
                      Divider(thickness: 1,color: ColorUtil().getColor(context, ColorEnums.whitePureLight),),
                      user.distributor == null ? Container() : Padding(
                        padding: const EdgeInsets.only(left: 20,right: 12),
                        child: Column(
                          children: [
                            Text("hylaDistributor".tr(), style: CustomTextStyle().bold14(ColorUtil().getColor(context,ColorEnums.whitePureLight)),),
                            Text(user.distributor!.name ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                            SizedBox(
                                width: sizeWidth(context).width,
                                child: Divider(thickness: 1,color:ColorUtil().getColor(context,ColorEnums.whitePureLight))),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: ColorUtil().getColor(context,ColorEnums.whitePureLight),),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.distributor!.phone ?? "", style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(Icons.local_post_office_outlined, size: 16, color: ColorUtil().getColor(context,ColorEnums.whitePureLight)),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.distributor!.email ?? "",style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: ColorUtil().getColor(context,ColorEnums.whitePureLight),
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${user.distributor!.address ?? ""},${user.distributor!.city ?? ""},"
                                          "${user.distributor!.county ?? ""},"
                                          "${user.distributor!.state ?? ""}", style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.whitePureLight))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 16),
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "salesApp".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "wizzCustomerApp".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "allRightReserved".tr(),
                              style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.whitePureLight)),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ],
        )
    ),
  );
}

Widget emptyView(BuildContext context,String value) {
  return Container(
    width: sizeWidth(context).width*0.80,
    color: ColorUtil().getColor(context, ColorEnums.background),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* Image.asset(
          "assets/empty.png",height: 100,)*/
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Text(value.tr(), style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
          ),
        ),
      ],
    ),
  );
}
Widget spinKit(BuildContext context) {
  return  Center(
    child: SpinKitRing(
      lineWidth: 3.0,
      color:ColorUtil().getColor(context, ColorEnums.wizzColor),
      size: sizeWidth(context).width*0.08,

    ),
  );
}
Future<void> showProgress(BuildContext context, bool isLoading) async {
  if(isLoading){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitWaveSpinner(
                  waveColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                  trackColor: ColorUtil().getColor(context, ColorEnums.background),
                  color:ColorUtil().getColor(context, ColorEnums.wizzColor),
                  size: sizeWidth(context).width*0.15,
                )
              ],
            ),

          );
        }
    );
  }else{
    Navigator.pop(context);
  }
}
ThemeData getTheme(BuildContext context,bool isLightMode) {

  if (isLightMode) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
          primary:AppColors.wizzColor,
          onPrimary: ColorUtil().getColor(context, ColorEnums.textDefaultLight),
          onSurface: AppColors.white,//ay ve tarihler
          onPrimaryContainer: ColorUtil().getColor(context, ColorEnums.textDefaultLight)
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:AppColors.wizzColor, // button text color
        ),
      ),
    );
  } else {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: ColorUtil().getColor(context, ColorEnums.wizzColor),
        onPrimary: AppColors.white,
        onSurface: AppColors.black,
        onPrimaryContainer: ColorUtil().getColor(context, ColorEnums.textDefaultLight),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
        ),
      ),
    );
  }
}

Color demoDivider(BuildContext context, String type) {
  switch (type) {
    case "Demo Completed":
      return ColorUtil().getColor(context, ColorEnums.success);

    case "DNS":
      return ColorUtil().getColor(context, ColorEnums.error);

    case "Active":
      return ColorUtil().getColor(context, ColorEnums.wizzColor);

    case "Sold":
      return ColorUtil().getColor(context, ColorEnums.wizzColor);

    default:
      return ColorUtil().getColor(context, ColorEnums.wizzColor); // Veya boş bir stil döndürün.
  }
}
TextStyle demoStatusStyle(BuildContext context, String type) {
  switch (type) {
    case "Demo Completed":
      return CustomTextStyle().bold14(
          ColorUtil().getColor(context, ColorEnums.success));

    case "DNS":
      return CustomTextStyle()
          .bold14(ColorUtil().getColor(context, ColorEnums.error));

    case "Active":
      return CustomTextStyle().bold14(
          ColorUtil().getColor(context, ColorEnums.wizzColor));

    case "Sold/Registered":
      return CustomTextStyle().bold14(
          ColorUtil().getColor(context, ColorEnums.wizzColor));

    default:
      return CustomTextStyle().bold14(
          ColorUtil().getColor(context, ColorEnums.wizzColor)); // Veya boş bir stil döndürün.
  }
}

Widget getResourceWidget(BuildContext context, Resource resource) {
  if (resource.mimeType == "application/pdf") {
    return Icon(
      Icons.picture_as_pdf_rounded,
      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
    );
  } else if (resource.mimeType == "video/mp4" ||
      resource.mimeType == "link") {
    return Icon(
      Icons.slow_motion_video_outlined,
      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
    );
  } else if (resource.mimeType ==
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
    return Icon(
      Icons.local_post_office_outlined,
      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
      size: 32,
    );
  } else {
    return ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(16),
        // Image radius
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: resource.file!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
 clickResource(BuildContext context, Resource resource) {
  if (resource.mimeType == "application/pdf") {
    Navigator.pushNamed(context, '/${PageName.pdfPage}',
      arguments: {'title': resource.title!, 'url': resource.file!},);
  } else if (resource.mimeType == "video/mp4" || resource.mimeType == "link") {
    Navigator.pushNamed(context, '/${PageName.videoPage}',
      arguments: {'title': resource.title, 'url':resource.file!},);

  } else if (resource.mimeType == "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
    launchUrl(Uri.parse(resource.file!));
  } else {
    showPhoto(context, resource.file!);
  }
}

String getReportText(int reportIndex) {
  switch(reportIndex) {
    case 0:
      return "yesterday";
    case 1:
      return "today";
    case 2:
      return "weekly";
    case 3:
      return "monthly";
    case 4:
      return "annual";
    default:
      return "";
  }
}
Widget buildCardLeads(BuildContext context, String name,String type,String title, int count) {
  return Card(
    color: ColorUtil().getColor(context, ColorEnums.background),
    shape: cardShape(context),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: sizeWidth(context).width*0.35,
                child: Text(
                  "Status",
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: sizeWidth(context).width*0.35,
                child: Text(
                  "Type",
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      type,
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: sizeWidth(context).width*0.35,
                child: Text(
                  "Date",
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: sizeWidth(context).width*0.35,
                child: Text(
                  "Total",
                  style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$count",
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ],
                ),
              ),
            ],
          ),



        ],
      ),
    ),
  );
}

Widget buildCard(BuildContext context, String name,int price,String title, int count) {
  print("title $title");
  int dashCount = title.split('-').length - 1;
  if(dashCount == 2){
    title = mmDDY(title);
  }
  return Column(
    children: [
      Text(name.tr(),style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
      Card(
        color: ColorUtil().getColor(context, ColorEnums.background),
        shape: cardShape(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(

                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$count",
                          style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2,),
              Divider(
                color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                thickness: 0.3,
              ),
              const SizedBox(height: 2,),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "totalPrice".tr(),
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$price\$",
                          style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    ],
  );
}




