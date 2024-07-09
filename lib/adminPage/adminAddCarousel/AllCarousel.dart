import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/adminPage/adminModel/carousel/SliderPayload.dart';
import 'package:wizzsales/adminPage/adminVm/adminCarouselVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AllCarousel extends BaseStatefulPage {
  const AllCarousel(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AllCarouselState();
}

class _AllCarouselState extends BaseStatefulPageState<AllCarousel> {
  AdminCarouselVm viewModel = AdminCarouselVm();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminCarouselVm>(
        builder: (context,value,_){
          if (viewModel.getSlider == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       SizedBox(
                          width: sizeWidth(context).width*0.7,
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchSlider(viewModel.getSlider!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      IconButton(
                        onPressed: ()async{
                          showProgress(context, true);
                          await getList();
                          showProgress(context, false);
                        },
                        icon: Icon(Icons.refresh,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                      )
                    ],
                  ),


                  const SizedBox(height: 8,),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchSlider(viewModel.getSlider!,viewModel.query).length,
                          itemBuilder: (context,index){
                            SliderPayload item = viewModel.searchSlider(viewModel.getSlider!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              elevation:2,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        showPhoto(context, item.filePath!);
                                      },
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                            size: const Size.fromRadius(16),
                                            // Image radius
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/loading.gif',
                                              image: item.filePath!,
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width:sizeWidth(context).width*0.40,
                                                    child: Text("carouselOrder".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),

                                                Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(item.sliderOrder!.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                      ],
                                                    )
                                                ),

                                              ],
                                            ),
                                            const SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width:sizeWidth(context).width*0.40,
                                                    child: Text("carouselName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),

                                                Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(item.sliderViewName!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                      ],
                                                    )
                                                ),

                                              ],
                                            ),
                                            const SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width:sizeWidth(context).width*0.40,
                                                    child: Text("carouselType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)),

                                                Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        item.sliderType == "link" ?
                                                        Text("webPage".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                            :
                                                        Text(upperFirstLetter(item.sliderType!),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8,),
                                            if(item.onClick !=null)
                                              GestureDetector(
                                                  onTap:(){
                                                    if(item.sliderType !=null && item.onClick !=null){
                                                      if(item.sliderType =="link"){
                                                        launchUrl(Uri.parse(item.onClick!));
                                                      }else{
                                                        showCarouselDetails(context,item.onClick!,item.sliderType!);
                                                      }
                                                    }
                                                  },
                                                  child: Text("preview".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor)),)),
                                            const SizedBox(height: 4,),
                                           /* if(item.onClick !=null)
                                              GestureDetector(
                                                  onTap: (){
                                                    if(item.sliderType !=null && item.onClick !=null){
                                                      if(item.sliderType =="link"){
                                                        launchUrl(Uri.parse(item.onClick!));
                                                      }else{
                                                        showCarouselDetails(context,item.onClick!,item.sliderType!);
                                                      }
                                                    }
                                                  },
                                                  child: item.sliderType =="video" ?
                                                  Icon(Icons.slow_motion_video_outlined,color:ColorUtil().getColor(context, ColorEnums.wizzColor),size: 32,)
                                                      :item.sliderType =="pdf" ?
                                                  Icon(Icons.picture_as_pdf_outlined,color:ColorUtil().getColor(context, ColorEnums.wizzColor),size: 32,)
                                                      :item.sliderType=="link" ?
                                                  Icon(Icons.link,color:ColorUtil().getColor(context, ColorEnums.wizzColor),size: 32,)
                                                      :Icon(Icons.image,color:ColorUtil().getColor(context, ColorEnums.wizzColor),size: 32,)

                                              ),*/
                                            Divider(
                                              thickness: 2,
                                              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                            ),
                                            const SizedBox(height: 4,),
                                            GestureDetector(
                                              onTap: ()async{
                                                bool check = await areYouSure(context);
                                                if(check){
                                                  await deleteSlider(context,item.id!);
                                                }
                                              },
                                              child: Text("delete".tr(),style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.wizzColor)),),

                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                        padding: const EdgeInsets.only(bottom: 8,top: 8),
                        child: SizedBox(
                          width: sizeWidth(context).width*0.80,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/${PageName.adminAddCarousel}');
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("addCarousel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                        ),
                      ),

                ],
              ),
            );
          }


        },
      ),
    );
  }
  Future<void>getList() async{
    await viewModel.allSlider(context);
  }
  deleteSlider(BuildContext context, int id) async{
    await viewModel.deleteSlider(context, id);
    if(viewModel.deleteResponse==true){
      await getList();
    }

  }
}
