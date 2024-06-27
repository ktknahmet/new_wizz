import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/contestModel/Active.dart';
import 'package:wizzsales/model/OLD/contestReportModel/CompetitionsReports.dart';
import 'package:wizzsales/utils/OLD/LocalStorageApp.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class AllContestsReport extends StatefulWidget {
  final String? appBarName;
  final Active? detailActive;
  final List<CompetitionsReports?>? qualifiedAssocList;
  const AllContestsReport(this.appBarName,this.detailActive,this.qualifiedAssocList,{super.key});

  @override
  State<AllContestsReport> createState() => _AllContestsReportState();
}

class _AllContestsReportState extends State<AllContestsReport> {
  List<Widget> myTitles = [];
  List<Widget> myPersons = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: DefaultAppBar(name:"${widget.appBarName!} ${context.tr("report")}",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  GestureDetector(
                    onTap: (){
                      showPhoto(context, widget.detailActive!.image!);
                    },
                    child: SizedBox(
                      width: sizeWidth(context).width*0.35,
                      height: sizeWidth(context).height*0.16,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.gif',
                        image: widget.detailActive!.image!,
                        fit: BoxFit.contain,
                      )

                    ),
                  ),
                 Expanded(
                   child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                       Text("'Qualification Period'",style: CustomTextStyle().bold16(ColorUtil().getColor(context,ColorEnums.textTitleLight)),),
                       Text("${widget.detailActive!.startTime!}-${widget.detailActive!.endTime!}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context,ColorEnums.textTitleLight)),),
                       const SizedBox(height: 8,),
                       Text('Report Date : ${DateFormat.yMMMMd().format(DateTime.now())}',style: CustomTextStyle().bold14(ColorUtil().getColor(context,ColorEnums.textTitleLight)),)
                       ],
                     ),
                 ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
             ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.qualifiedAssocList!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      CompetitionsReports assoc = widget.qualifiedAssocList![index]!;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                                    child: Text(assoc.title ?? "",style: CustomTextStyle().semiBold12(AppColors.white)),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(height: 8,),
                                  Container(
                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                    child: Row(
                                        children: [
                                          for(int i=0;i<assoc.subtitle!.length;i++)
                                          Expanded(child: Text(assoc.subtitle![i],style: CustomTextStyle().semiBold12(AppColors.white))),
                                        ]
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          assoc.winners!.isEmpty
                              ? const SizedBox(
                            height: 40,
                          )
                              : const SizedBox(
                            height: 5,
                          ),
                          getListView(assoc.winners)
                        ],
                      );
                    }
                ),

          ],
        ),
      )
    );
  }
  List<Widget> getTitles(titles) {
    myTitles.clear();
    for (int i = 0; i < titles.length; i++) {
      myTitles.add(
          Expanded(
            child: Text(titles[i],style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))

          ));
    }
    return myTitles;
  }
  Widget getListView(winners) {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: winners.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {

          //winners 4'ten büyük olursa hata veriyor
          getDatas(winners,winners[index]);
          return Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: myPersons,
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 1,
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ));
        });
  }

  List<Widget> getDatas(data,winner) {
    myPersons.clear();
    var person = winner.toJson();
    for (int i = 0; i < 4; i++) {
      myPersons.add(
          Expanded(
              child:Text(person[LocalStorageApp.reportsvals[i]].toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)))
          ));

    }
    return myPersons;
  }

}
