import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ProfileVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import 'package:wizzsales/widgets/WidgetExtension.dart';

class Profile extends BaseStatefulPage {
  const Profile(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends BaseStatefulPageState<Profile> {
  ProfileVm viewModel = ProfileVm();
  SharedPref pref = SharedPref();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    getInfo();
    theme();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ProfileVm>(
        builder: (context,value,_){
          return viewModel.loginUser == null || viewModel.careerSales ==null || viewModel.user == null ? spinKit(context) :
          Column(
              children: [


             /*    const SizedBox(height: 8,),
          GestureDetector(
            onTap: (){

              Navigator.pushNamed(context, '/${PageName.trainingSection}');
            },
            child: Card(
              shape: cardShape(context),
              color: ColorUtil().getColor(context, ColorEnums.background),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("trainingSection".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                  ],
                ),
              ),
            ),
          ),*/
                const SizedBox(height: 8,),
                SizedBox(
                    height: 50,
                    child: Card(
                      shape: cardShape(context),
                      color: ColorUtil().getColor(context, ColorEnums.background),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("darkTheme".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            Switch(
                              activeTrackColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              activeColor: AppColors.white,
                              value: viewModel.darkMode,
                              onChanged: (newValue){
                                viewModel.updateTheme(newValue);
                                Phoenix.rebirth(context);

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16,),
                Column(
                  children: [
                    Visibility(
                      visible: viewModel.loginUser!.profiles![viewModel.index].salesrolename =="sales-manager" || viewModel.loginUser!.profiles![viewModel.index].salesrolename=="distributor" ? true : false ,
                      child: SizedBox(
                        height: 50,
                        child:  Card(
                          color: ColorUtil().getColor(context, ColorEnums.background),
                          shape: cardShape(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("adminMode".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                Switch(
                                  activeTrackColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                  activeColor: AppColors.white,
                                  value: false,
                                  onChanged: (newView) async{
                                    if(newView ==true){
                                      await pref.setString(SharedUtils.admin, "admin");
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/${PageName.adminHome}',
                                            (Route<dynamic> route) => false,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    RefreshIndicator(
                      onRefresh: getInfo,
                      color: ColorUtil().getColor(
                          context, ColorEnums.wizzColor),
                      child: SizedBox(
                        width: sizeWidth(context).width,
                        height: sizeWidth(context).height * 0.60,
                        child: RawScrollbar(
                          controller: controller,
                          thumbColor: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.loginUser!.profiles!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(
                                    context, ColorEnums.background),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(viewModel.loginUser!.profiles![index].salesrolename!.toUpperCase(), style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight),)),
                                              const SizedBox(height: 2,),
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(viewModel.loginUser!.profiles![index].orgname!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                    VerticalDivider(
                                                      color: ColorUtil().getColor(context, ColorEnums.wizzColor), thickness: 2,),
                                                    RatingBar.builder(
                                                      initialRating: viewModel.loginUser!.profiles![index].ranking == null ? 0.0 :
                                                      viewModel.loginUser!.profiles![index].ranking!.toDouble(),
                                                      minRating: 1,
                                                      ignoreGestures: true,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 16,
                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                      unratedColor: AppColors.beige,
                                                      itemBuilder: (context, _) =>
                                                          Icon(Icons.star_border_outlined, color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 2,),
                                              Text("${context.tr("careerSales")} : ${viewModel.careerSales!.approvedsalessofar}",
                                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                              ),

                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Checkbox(
                                                  checkColor: AppColors.white,
                                                  activeColor: ColorUtil().getColor(context,
                                                      ColorEnums.wizzColor),
                                                  value: index == viewModel.chooseUser
                                                      ? true
                                                      : false,
                                                  onChanged: (value) async {
                                                    if(viewModel.loginUser!.profiles!.length>1){
                                                      bool check = await areYouSure(context);
                                                      if(check){
                                                        await updateRole(index);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                  ],
                                ),

                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );

        },
      ),
    );

  }

  Future<void>getInfo() async{
    await viewModel.getUserInfo(context);

    viewModel.chooseUser = await pref.getInt(context, SharedUtils.profileIndex);
  }
  theme() async{
    await viewModel.setTheme(context);
  }
  updateRole(int index)async{
    await viewModel.updateRole(context, index);
  }

}
