import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Sale.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OfficeSaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../document/saleDocument.dart';

class OfficePending extends StatefulWidget {

  const OfficePending({super.key});

  @override
  State<OfficePending> createState() => _OfficePendingState();
}

class _OfficePendingState extends State<OfficePending> {
  OfficeSaleVm viewModel = OfficeSaleVm();
  ScrollController controller = ScrollController();

  //status 0
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    getList();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<OfficeSaleVm>(
            builder: (context,value,_){
              if(viewModel.pendingSale == null){
                return spinKit(context);
              }else{
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            onChanged: (value){
                              viewModel.setQuery(value);

                              viewModel.searchSale(viewModel.pendingSale!.data!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: getList,
                        color: ColorUtil().getColor(context,ColorEnums.wizzColor),
                        child: RawScrollbar(
                          controller: controller,
                          thumbVisibility: true,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thickness: 1,
                          child: SizedBox(
                            height: justList(context, sizeWidth(context).height)-100,
                            child: ListView.builder(
                              controller: controller,
                              itemCount:  viewModel.searchSale(viewModel.pendingSale!.data!,viewModel.query).length,
                              itemBuilder: (context,index){
                                Sale item =  viewModel.searchSale(viewModel.pendingSale!.data!,viewModel.query)[index];
                                int startIndex = (viewModel.pendingSale!.total! == 1) ? viewModel.pendingSale!.total! : viewModel.pendingSale!.total! - ((viewModel.page - 1) * 15);
                                List<int> indices = List.generate(15, (index) => startIndex - index);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: cardShape(context),
                                        color: ColorUtil().getColor(context, ColorEnums.background),
                                        elevation: 2,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("# ${item.serialid}",style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    Text(indices[index].toString(), style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                                  ],
                                                ),
                                                const SizedBox(height: 4,),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                                    const SizedBox(width: 4,),
                                                    Text(item.caddress!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    Text(item.office ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                                  ],
                                                ),
                                                const SizedBox(height: 8,),
                                                Row(
                                                  children: [
                                                    Icon(Icons.date_range,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                                    const SizedBox(width: 4,),
                                                    Text(DateFormat('yMMMd').format(DateTime.parse(item.date!)),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    Text(item.office ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    const SizedBox(width: 8,),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.person,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                                        const SizedBox(width: 4,),
                                                        Text(item.cname!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                const SizedBox(height: 8,),
                                                Wrap(
                                                    children: [
                                                      Wrap(
                                                        children: [
                                                          if(item.distributor != null && item.distributor!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("DST",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.distributor!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),

                                                          const SizedBox(width: 8,),
                                                          if(item.sm != null && item.sm!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("SM",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.sm!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),

                                                          const SizedBox(width: 8,),
                                                          if(item.dps != null && item.dps!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("DPS",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.dps!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),

                                                          const SizedBox(width: 8,),
                                                          if(item.leader != null && item.leader!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("TL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.leader!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),

                                                          const SizedBox(width: 8,),
                                                          if(item.dealer != null && item.dealer!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("DL",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.dealer!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),
                                                          const SizedBox(width: 8,),
                                                          if(item.da != null && item.da!.name !=null)
                                                            Column(
                                                              children: [
                                                                Text("DA",style: CustomTextStyle().regular8(ColorUtil().getColor(context, ColorEnums.textTitleLight),),),
                                                                const SizedBox(height: 4,),
                                                                Text(item.da!.name!,style:CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textTitleLight),),)
                                                              ],
                                                            ),

                                                        ],
                                                      ),
                                                    ]
                                                ),
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){

                                                        Navigator.pushNamed(context, '/${PageName.saleDetails}',arguments: {"sale":item});

                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text("seeDocuments".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                          Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (_) => SaleDocument(item.id!)));

                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text("addDocuments".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                          Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4,),
                                                Divider(
                                                  thickness: 0.4,
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                Align(
                                                  alignment:Alignment.center,
                                                  child: GestureDetector(
                                                      onTap: () async{
                                                        await viewModel.updateStatus(context,item.id!,item.serialid!);
                                                        await getList();
                                                      },
                                                      child: Text("updateStatus".tr(),style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 4,),
                                  ],

                                );
                              },
                            ),
                          ),
                        ),

                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () async{
                                  if(viewModel.page >1){
                                    viewModel.page = viewModel.page-1;
                                    viewModel.setPage(viewModel.page);
                                    await getList();
                                  }
                                },
                                style:elevatedButtonStyle(context),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back,color: ColorUtil().getColor(context, ColorEnums.wizzColor),), // Replace 'your_icon' with the desired icon

                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: SizedBox(
                                width: sizeWidth(context).width*0.70,
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel.pageCount.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: ()  async{
                                        viewModel.setPage(index+1);
                                        await getList();

                                      },
                                      child: Row(
                                        children: [
                                          viewModel.page == index + 1
                                              ? Container(
                                            height: sizeWidth(context).height * 0.048,
                                            width: sizeWidth(context).width * 0.088,
                                            decoration: containerPageDecoration(context),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(viewModel.page.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                            ),
                                          )
                                              : SizedBox(
                                            height: sizeWidth(context).height * 0.048,
                                            width: sizeWidth(context).width * 0.088,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("${index + 1}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async{
                                  if(viewModel.page <viewModel.pageCount.length){
                                    viewModel.page = viewModel.page+1;
                                    viewModel.setPage(viewModel.page);

                                    await getList();
                                  }
                                },
                                style:elevatedButtonStyle(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward,color: ColorUtil().getColor(context, ColorEnums.wizzColor),), // Replace 'your_icon' with the desired icon

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        )
    );
  }
  Future<void> getList()async{
    await viewModel.getPendingSale(context,viewModel.page);
    viewModel.pageCount.clear();
    if(viewModel.pendingSale !=null){
      print("boyut :${viewModel.pendingSale!.total!}");
      for(int i=0;i<viewModel.pendingSale!.last_page!;i++){
        viewModel.pageCount.add(i);
      }
    }
  }

}