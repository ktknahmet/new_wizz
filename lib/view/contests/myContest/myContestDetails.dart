import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/contestModel/LeaderBoard.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class MyContestDetails extends StatefulWidget {
  final String? appBarName;
  final List<LeaderBoard>? leaderBoard;
  const MyContestDetails(this.appBarName,this.leaderBoard,{super.key});

  @override
  State<MyContestDetails> createState() => _MyContestDetailsState();
}

class _MyContestDetailsState extends State<MyContestDetails> {
  ScrollController controller = ScrollController();
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name: widget.appBarName!,),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Column(
          children: [
            Text("${context.tr("totalLeadBoard")} : ${widget.leaderBoard!.length}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
            SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height*0.80,
              child: RawScrollbar(
                controller: controller,
                thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                thumbVisibility: true,
                thickness: 1,
                child: ListView.builder(
                  controller: controller,
                  itemCount: widget.leaderBoard!.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Card(
                          shape: cardShape(context),
                          color: ColorUtil().getColor(context, ColorEnums.background),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    showPhoto(context, widget.leaderBoard![index].image!);
                                  },
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(16),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/loading.gif',
                                        image: widget.leaderBoard![index].image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:sizeWidth(context).width*0.60,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.leaderBoard![index].name!,
                                              style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                            ),
                                            const SizedBox(height: 4,),
                                            Text(
                                              "${context.tr("salesRole")}: ${widget.leaderBoard![index].salesrole!.toUpperCase()}",
                                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ),
                                          ],
                                        )
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width:50,
                                        height:20,
                                        decoration: containerDecoration(context),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.leaderBoard![index].limit!.toString(),
                                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
