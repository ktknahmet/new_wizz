import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/ColorsUtil.dart';
import '../../utils/style/ColorEnums.dart';
import '../../utils/style/CustomTextStyle.dart';
import '../../utils/style/DefaultAppBar.dart';
import '../../utils/style/WidgetStyle.dart';
import '../../widgets/Constant.dart';
import '../../widgets/Extension.dart';
import '../../widgets/WidgetExtension.dart';
import '../adminModel/commissionModel/commissionWinner.dart';
import '../adminModel/commissionModel/payPost.dart';
import '../adminVm/commissionVm.dart';

class ComWinDetails extends StatefulWidget {
  final int? id;
  const ComWinDetails(this.id,{super.key});

  @override
  State<ComWinDetails> createState() => _ComWinDetailsState();
}

class _ComWinDetailsState extends State<ComWinDetails> {
  CommissionVm viewModel = CommissionVm();
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
    return Scaffold(
      appBar: DefaultAppBar(name: "comDetails".tr(),),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: ChangeNotifierProvider.value(
      value:viewModel,
     child: Consumer<CommissionVm>(
    builder: (context,value,_){
      if(viewModel.commissionWinner == null){
        return spinKit(context);
      }else{
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.5,
                        height: 50,
                        child: TextField(
                          onChanged: (value){
                            viewModel.setQuery(value);
                            viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),
                      Container(
                        width: sizeWidth(context).width*0.27,
                        decoration: containerDecoration(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              Text(viewModel.searchComWinner(viewModel.commissionWinner!, viewModel.query).length.toString(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh:getList,
                    color:ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: RawScrollbar(
                      thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: controller,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length,
                          itemBuilder: (context,index){
                            int startIndex = (viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length == 1) ? 1 : viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query).length;
                            List<int> indices = List.generate(viewModel.commissionWinner!.length, (index) => startIndex - index);
                            CommissionWinner model = viewModel.searchComWinner(viewModel.commissionWinner!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(indices[index].toString(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("commCalcDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(mmDDYDateTime(model.commCalculatedAt),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("repName".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.userName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("role".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.eligibleRoleName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("salesPrice".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text("\$${model.salePrice ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                      ],
                                    ),


                                    const SizedBox(height: 4,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text(model.comType ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        model.comType =="AMOUNT" ?

                                        Text("\$${model.commAdjustAmount ?? model.commAmount}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                                            :
                                        Text("${model.comPercentage}%  (\$${model.commAdjustAmount ?? model.commAmount})",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizeWidth(context).width*0.3,
                                          child: Text("isPaid?".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                        ),
                                        Text(model.isCommPaid == true ? "Paid" :"UnPaid",style: CustomTextStyle().black16(ColorUtil().getColor(context, ColorEnums.wizzColor)),),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    if(model.isCommPaid ==true)
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.3,
                                                child: Text("payDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(mmDDYDate(model.payAt ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),

                                          SizedBox(
                                            width:sizeWidth(context).width*0.80,
                                            child: ElevatedButton(
                                                onPressed: ()async{
                                                  bool check = await returnPaidQuestion(context);
                                                  if(check){
                                                    await returnPost(model.comSaleId!);
                                                  }
                                                },
                                                style: elevatedButtonStyle(context),
                                                child: Text("returnPay".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                            ),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 4),
                                    const Divider(
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(height: 4,),
                                    if(model.isCommPaid !=true)
                                      SizedBox(
                                        width:sizeWidth(context).width*0.80,
                                        child: ElevatedButton(
                                            onPressed: (){

                                              showAdjust(context,viewModel,model.comSaleId!);
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("adjust".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                        ),
                                      ),
                                    if(model.isCommPaid ==false)
                                      SizedBox(
                                        width:sizeWidth(context).width*0.80,
                                        child: ElevatedButton(
                                            onPressed: ()async{
                                              bool check = await paidQuestion(context);
                                              if(check){
                                                await post(model.comSaleId!);
                                              }
                                            },
                                            style: elevatedButtonStyle(context),
                                            child: Text("approve".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
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
                ]
            ),
          ),
        );
      }
    },
    ),
      )
    );
  }

  Future<void>getList()async{

    await viewModel.getComWinner(context,widget.id,null,null);

  }
  post(int id) async{
    //eğer adjust edilen varsa adjust olacak yoksa com amount pay edilecek
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
  returnPost(int id) async{
    PayPost post = PayPost(calcPoolSaleId: id);
    await viewModel.postComPay(context,post,getList);

  }
}
