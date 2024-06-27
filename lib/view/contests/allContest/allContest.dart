import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/contestModel/Active.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/contests/allContest/allContestDetails.dart';
import 'package:wizzsales/view/contests/allContest/allContestsReport.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AllContest extends StatefulWidget {
  const AllContest({super.key});
  @override
  State<StatefulWidget> createState() => _AllContestState();
}

class _AllContestState extends State<AllContest> {
  SaleOfficeMobx mobx = SaleOfficeMobx();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Observer(
            builder: (_){
              if(mobx.allContest ==null){
                return spinKit(context);
              }else if(mobx.allContest!.isEmpty){
                return emptyView(context, "noAllContests");
              }else{
                return  Column(
                  children: [
                    Text("${mobx.allContest!.length}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                    RefreshIndicator(
                      onRefresh:getList,
                      color:ColorUtil().getColor(context, ColorEnums.wizzColor),
                      child: SizedBox(
                        width:sizeWidth(context).width,
                        height:sizeWidth(context).height*0.70,
                        child: RawScrollbar(
                          controller: controller,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: mobx.allContest!.length,
                            itemBuilder: (context,index){
                              Active active = mobx.allContest![index]!;
                              String days = calculateDayDifference(active.startdate!, active.enddate!).toString();
                              return Card(
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                shape: cardShape(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  SizedBox(
                                    width: sizeWidth(context).width,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                if(days =="0"){
                                                  showPhoto(context, active.image!.toString());

                                                }else{
                                                  showContestPhoto(context, active.image!.toString());
                                                }
                                              },
                                              child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(32),
                                                  // Image radius
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/loading.gif',
                                                    image: active.image!.toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            SizedBox(
                                              width: sizeWidth(context).width*0.45,
                                              child:  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(active.name!,style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text("${context.tr("promotedBy")} ${active.promoter}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                  Text("${active.startTime.toString()} - ${active.endTime.toString()}",style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                  const SizedBox(height: 4,),
                                                ],
                                              ),
                                            ),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  days=="0" ?
                                                  Text("completed".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),)
                                                      :
                                                  Text("$days ${context.tr("daysLeft")}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                                  const SizedBox(height: 8,),
                                                  GestureDetector(
                                                      onTap:(){
                                                        if(active.leaderBoard!.isNotEmpty){
                                                          Navigator.push(context, MaterialPageRoute(builder: (_) => AllContestDetails(active.name, active.leaderBoard)));
                                                        }else{
                                                          snackBarDesign(context, StringUtil.error, "noLeaderBoard".tr());
                                                        }
                                                      },
                                                      child: Text("seeDetails".tr(),style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                  ),
                                                  const SizedBox(height: 8,),
                                                  GestureDetector(
                                                    onTap: () async{
                                                      await mobx.getAllContestReport(context,active.id!);
                                                      if(mobx.allContestReport!.isNotEmpty){
                                                        Navigator.push(context,MaterialPageRoute(builder: (_) => AllContestsReport(active.name,active,mobx.allContestReport!)));
                                                      }else{
                                                        snackBarDesign(context, StringUtil.error, "noReport".tr());
                                                      }

                                                    },
                                                    child:Text("seeReport".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

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
                              );
                            },
                          ),
                        ),
                      ),
                    ),


                  ],

                );
              }
            },
          ),
        ],
      ),
    );
  }
  Future<void>getList() async{
    await mobx.getAllContest(context);
  }

}
