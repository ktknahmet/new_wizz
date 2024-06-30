// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/poolHistory.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/pool/stockPool.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class StockPage extends BaseStatefulPage {
  const StockPage(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _StockPageState();
}

class _StockPageState extends BaseStatefulPageState<StockPage> {
  ScrollController controller = ScrollController();
  StockVm viewModel = StockVm();
  TextEditingController startDate=TextEditingController();
  TextEditingController startSerial=TextEditingController();
  TextEditingController endSerial=TextEditingController();
  TextEditingController piece = TextEditingController();

  @override
  void initState() {
    getHistory();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<StockVm>(
        builder: (context,value,_){
          if(viewModel.getPoolHistory == null ) {
            return spinKit(context);
          } else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("stockDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            const SizedBox(height: 4,),
                            TextField(
                              style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                              cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              decoration: dateInputDecoration(context,"stockDate"),
                              controller: startDate,
                              readOnly: true,
                              onTap: () async{
                                startDate.text = await DatePickerHelper.getDatePicker(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            accountNumber(context, "hylaQuantity", piece),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            accountNumber(context, "beginSerial", startSerial)
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            accountNumber(context, "endSerial", endSerial),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.40,
                        child: ElevatedButton(
                          onPressed: () async{
                            if(piece.text.isNotEmpty){
                              await post();
                            }else{
                              snackBarDesign(context, StringUtil.warning, "emptyPiece".tr());
                            }
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("newStock".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                      if (viewModel.getPoolHistory!.isNotEmpty)
                        SizedBox(
                          width: sizeWidth(context).width*0.40,
                          child: ElevatedButton(
                            onPressed: () async{
                              Navigator.pushNamed(context, '/${PageName.assignGlobalStock}');

                            },
                            style: elevatedButtonStyle(context),
                            child: Text("assignStock".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Divider(
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                  ),
                  const SizedBox(height: 4,),

                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("history".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        GestureDetector(
                          onTap: ()async{
                            showProgress(context, true);
                            await getHistory();
                            showProgress(context, false);
                          },
                          child: Icon(Icons.refresh_outlined,color: ColorUtil().getColor(context, ColorEnums.wizzColor),),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4,),

                  if (viewModel.getPoolHistory!.isEmpty) emptyView(context, "emptyStockHistory") else RefreshIndicator(
                    onRefresh: getHistory,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: sizeWidth(context).height*0.52,
                      child: RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.getPoolHistory!.length,
                          itemBuilder: (context,index){
                            GetPoolHistory model = viewModel.getPoolHistory![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:Text("releaseDate".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                          const SizedBox(width: 8), // Araya bir boşluk ekleyebilirsiniz
                                          Text(mmDDYDate(model.stockDate!.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:Text("assignedStocks".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                          const SizedBox(width: 8), // Araya bir boşluk ekleyebilirsiniz
                                          Text("${model.assignedProductQuantity!.toString()}/${viewModel.getPoolHistory![index].totalQuantity!.toString()}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:Text("savedStock".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                          const SizedBox(width: 8), // Araya bir boşluk ekleyebilirsiniz
                                          Text("${model.totalSavedStockOfPool!.toString()}/${viewModel.getPoolHistory![index].totalQuantity!.toString()}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:Text("status".tr(),style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                          const SizedBox(width: 8), // Araya bir boşluk ekleyebilirsiniz
                                          Text(model.poolStatus!.toUpperCase(),style:viewModel.getPoolHistory![index].poolStatus!.toUpperCase() =="PROCESSING"
                                              ? CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.error))
                                              :CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.wizzColor),))
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: (){

                                              Navigator.pushNamed(context, '/${PageName.adminStockDetails}',arguments: {'id':viewModel.getPoolHistory![index].stockPoolId!,'assign':viewModel.getPoolHistory![index].assignedProductQuantity!, 'total':viewModel.getPoolHistory![index].totalSavedStockOfPool!});

                                            },
                                            style: elevatedButtonStyle(context),
                                            child:Text("assignedStocks".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: (){
                                              if(model.poolStatus!.toUpperCase() !="COMPLETED"){
                                                Navigator.pushNamed(context, '/${PageName.adminScanProduct}',  arguments: {'id':viewModel.getPoolHistory![index].stockPoolId!,'assign':viewModel.getPoolHistory![index].totalSavedStockOfPool!, 'total':viewModel.getPoolHistory![index].totalQuantity!});
                                              }else{
                                                snackBarDesign(context, StringUtil.warning, "alreadyCompleted".tr());
                                              }
                                            },
                                            style: elevatedButtonStyle(context),
                                            child:Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      if((model.totalSavedStockOfPool ?? 0) < (model.totalQuantity ?? 0))
                                        SizedBox(
                                          width:sizeWidth(context).width*0.8,
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pushNamed(context, '/${PageName.adminScanProduct}',
                                                  arguments: {
                                                    'id':model.stockPoolId!,
                                                    'assign':model.totalSavedStockOfPool!,
                                                    'total':model.totalQuantity!,
                                                    'beginSerial':model.beginSerial,
                                                    'endSerial':model.endSerial});

                                            },
                                            style: elevatedButtonStyle(context),
                                            child:Text("scanProduct".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          ),
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
                  )
                ],
              ),
            );
          }

        },
      ),
    );
  }
  Future<void>getHistory() async{
   startDate.text = mmDDYDate(DateTime.now().toString());
   await viewModel.poolHistory(context);
  }
  post() async{
    int begin=0;
    int end=0;
    if(startSerial.text.isNotEmpty){
      if(startSerial.text.length !=8){
        snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
            return;
      }else{
        begin = int.parse(startSerial.text);
      }
    }
    if(endSerial.text.isNotEmpty){
      if(endSerial.text.length !=8){
        snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
        return;
      }else{
        end = int.parse(endSerial.text);
      }
    }
    if(startSerial.text.isNotEmpty && endSerial.text.isEmpty){
      snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
      return;
    }
    if(endSerial.text.isNotEmpty && startSerial.text.isEmpty){
      snackBarDesign(context, StringUtil.error, "serialIdMust8".tr());
      return;
    }

    dynamic value;
    if(startSerial.text.length == 8 && endSerial.text.length == 8){
      if (begin >=end) {
        snackBarDesign(context, StringUtil.error, "serialIdCannotLessBeginSerial".tr());
        return;
      } else {
        value = int.parse(endSerial.text) - int.parse(startSerial.text) +1;
      }
    }else{
      value = int.parse(piece.text);
    }
   if(startDate.text.isNotEmpty && piece.text.isNotEmpty){
     StockPool post = StockPool(
         stockDate: formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd"),
         totalQuantity: value,
         beginSerial: startSerial.text,
         endSerial: endSerial.text
     );
     await viewModel.postStockPool(context, post);

    if(viewModel.response !=null){
      Navigator.pushNamed(context, '/${PageName.adminScanProduct}',
          arguments: {
            'id': viewModel.response!,
            'assign':0,
            'total':value,
            'beginSerial':startSerial.text,
            'endSerial':endSerial.text}
      );

    }
   }else{
     snackBarDesign(context, StringUtil.warning, "required".tr());
   }
  }
}
