
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/SalelistMobx.dart';
import 'package:wizzsales/viewModel/OfficeSaleVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../../model/OLD/Sale.dart';
import '../../../view/sale/document/saleDocument.dart';

class AdminApproved extends StatefulWidget {
  final String? type;
  const AdminApproved(this.type,{super.key});

  @override
  State<AdminApproved> createState() => _AdminApprovedState();
}

class _AdminApprovedState extends State<AdminApproved> {
  OfficeSaleVm viewModel = OfficeSaleVm();
  ScrollController controller = ScrollController();

  //status 1
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
              if(viewModel.approvedSale == null){
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

                              viewModel.searchSale(viewModel.approvedSale!.data!,viewModel.query);
                            },
                            decoration: searchTextDesign(context, "search"),
                            cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
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
                              itemCount:  viewModel.searchSale(viewModel.approvedSale!.data!,viewModel.query).length,
                              itemBuilder: (context,index){
                                Sale item =  viewModel.searchSale(viewModel.approvedSale!.data!,viewModel.query)[index];
                                int startIndex = (viewModel.approvedSale!.total! == 1) ? viewModel.approvedSale!.total! : viewModel.approvedSale!.total! - ((viewModel.page - 1) * 15);
                                List<int> indices = List.generate(15, (index) => startIndex - index);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: cardShape(context),
                                        color: ColorUtil().getColor(context, ColorEnums.background),
                                        elevation:2,
                                        child: Padding(
                                            padding: const EdgeInsets.all(4),
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
                                                const SizedBox(height: 4,),
                                                Row(
                                                  children: [
                                                    Icon(Icons.phone,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                                                    const SizedBox(width: 4,),
                                                    Text(item.cphone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

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
                  
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){
                                                          if(widget.type=="Sale"){
                                                            Navigator.pushNamed(context, '/${PageName.adminSaleDetails}',arguments: {"sale":item});
                  
                                                          }else{
                                                            Navigator.pushNamed(context, '/${PageName.adminCustomerSaleDetails}',arguments: {"sale":item});
                  
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(widget.type=="Sale" ? "saleInfo".tr() : "customerInfo".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
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
                                                            Text("customerDocument".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                            Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, '/${PageName.saleComDetails}',arguments: {"sale":item});
                  
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text("comDetails".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                                        Icon(Icons.arrow_right,color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
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
                                    print("sayfa ${viewModel.page}");
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
                                      onTap: () async {
                                        viewModel.setPage(index + 1);
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
    await viewModel.getApprovedSale(context, viewModel.page);

    viewModel.pageCount.clear();
    if(viewModel.approvedSale !=null){
      for(int i=0;i<viewModel.approvedSale!.last_page!;i++){
        viewModel.pageCount.add(i);
      }
    }
  }


}
