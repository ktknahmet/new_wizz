import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/view/contests/allContest/allContest.dart';
import 'package:wizzsales/view/contests/myContest/myContest.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

import '../../utils/style/CustomTextStyle.dart';

class Contests extends StatefulWidget {
  const Contests( {super.key});

  @override
  State<StatefulWidget> createState() => _ContestsState();
}
class _ContestsState extends State<Contests>{
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
              leading: BackButton(
                  color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
              ),
              title: Text("contests".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              bottom: TabBar(
                dividerColor: AppColors.transparant,
                labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                tabs:  [
                  Tab(child: Text("myContests".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  Tab(child: Text("allContest".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                ],
              ),
            ),
          ),
          body: Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child:  const TabBarView(
              children: [
                MyContests(),
                AllContest(),
              ],
            ),
          ),

        ),
      ),
    );
  }


}


