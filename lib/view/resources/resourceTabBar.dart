import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/view/resources/tabBarDetails/imageResource.dart';
import 'package:wizzsales/view/resources/tabBarDetails/pdfResource.dart';
import 'package:wizzsales/view/resources/tabBarDetails/videoResource.dart';
import 'package:wizzsales/view/resources/tabBarDetails/wordResource.dart';
import 'package:wizzsales/widgets/Constant.dart';

class ResourceTabBar extends StatefulWidget {
  final String appBarName;
  final List<Resource>? list;
    const ResourceTabBar(this.appBarName,this.list,{super.key});

  @override
  State<ResourceTabBar> createState() => _ResourceTabBarState();
}

class _ResourceTabBarState extends State<ResourceTabBar> {
  List<Resource> imageList=[];
  List<Resource> videLink=[];
  List<Resource> pdfLink=[];
  List<Resource> wordLink=[];
  int length=0;
  @override
  void initState() {
    //pdf listesi tek ise otomatik sayfa açılacak
    getList(widget.list!);
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: DefaultTabController(
        initialIndex: 0,
        length: length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizeWidth(context).height*0.12),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
              leading: BackButton(
                  color: ColorUtil().getColor(context, ColorEnums.textTitleLight)
              ),
              title: Text(widget.appBarName,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              bottom: TabBar(
                dividerColor: AppColors.transparant,
                labelStyle: CustomTextStyle().semiBold12(AppColors.wizzColor),
                unselectedLabelStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                indicatorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                labelColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                unselectedLabelColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                tabs:  [
                  if(imageList.isNotEmpty)
                    Tab(child: Text("image".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  if(videLink.isNotEmpty)
                    Tab(child: Text("video".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  if(pdfLink.isNotEmpty)
                    Tab(child: Text("pdf".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),
                  if(wordLink.isNotEmpty)
                    Tab(child: Text("docx".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),),

                ],
              ),
            ),
          ),
          body: Container(
            color: ColorUtil().getColor(context, ColorEnums.background),
            child:  TabBarView(
              children: [
                if(imageList.isNotEmpty)
                  ImageResource(imageList),
                 if(videLink.isNotEmpty)
                   VideoResource(videLink),
                if (pdfLink.isNotEmpty)
                  PdfResource(pdfLink),
                if(wordLink.isNotEmpty)
                   WordResource(wordLink)

              ],
            ),
          ),

        ),
      ),
    );
  }
  getList(List<Resource> list) async{
    for(int i=0;i<list.length;i++){
      if(list[i].mimeType!.contains("application/pdf")){
        pdfLink.add(list[i]);
      }else if(list[i].mimeType!.contains("video/mp4") || list[i].mimeType!.contains("link")){
        videLink.add(list[i]);
      }else if(list[i].mimeType!.contains("application/vnd.openxmlformats-officedocument.wordprocessingml.document")){
        wordLink.add(list[i]);
      }else{
        imageList.add(list[i]);
      }
    }
    if(imageList.isNotEmpty){
      length++;
    }
    if(videLink.isNotEmpty){
      length++;
    }
    if(pdfLink.isNotEmpty){
      length++;
    }
    if(wordLink.isNotEmpty){
      length++;
    }
  }


}
