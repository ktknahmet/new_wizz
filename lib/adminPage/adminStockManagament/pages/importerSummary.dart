import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/stockReportModel/stockReportData.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../constants/AppColors.dart';
import '../../../constants/ColorsUtil.dart';
import '../../../utils/function/helper/DatepickerHelper.dart';
import '../../../utils/res/StringUtils.dart';
import '../../../utils/style/ColorEnums.dart';
import '../../../utils/style/CustomTextStyle.dart';
import '../../../widgets/Constant.dart';
import '../../adminVm/warehouseVm.dart';

class ImporterSummary extends BaseStatefulPage {
  const ImporterSummary(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ImporterSummaryState();
}

class _ImporterSummaryState extends BaseStatefulPageState<ImporterSummary> {
  WarehouseVm viewModel = WarehouseVm();
  ScrollController controller = ScrollController();
  List<StockReportDataDetails> displayedData =[];
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WarehouseVm>(
        builder: (context,value,_){
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child: TextField(
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          decoration: dateInputDecoration(context,"startDate"),
                          controller: startDate,
                          readOnly: true,
                          onTap: () async{
                            startDate.text = await DatePickerHelper.getDatePicker(context);
                          },
                        ),
                      ),

                      SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child: TextField(
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                          cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          decoration: dateInputDecoration(context,"endDate"),
                          controller: endDate,
                          readOnly: true,
                          onTap: () async{
                            endDate.text = await DatePickerHelper.getDatePicker(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  SizedBox(
                    width: sizeWidth(context).width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ()async{
                        if(startDate.text.isNotEmpty && endDate.text.isNotEmpty){
                          dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                          dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                          DateTime selectedStartDate = DateTime.parse(x);
                          DateTime selectedEndDate = DateTime.parse(y);

                          if(selectedEndDate.isBefore(selectedStartDate)){
                            snackBarDesign(context, StringUtil.error, "cannotGreaterEndDate".tr());
                          }else{
                            await getList();
                          }
                        }else{
                          snackBarDesign(context, StringUtil.error, "requiredReportDate".tr());
                        }

                      },
                      style: elevatedButtonStyle(context),
                      child: Text("showSummary".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  if(viewModel.dataDetails !=null)
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              border: Border.all(color: ColorUtil().getColor(context,ColorEnums.wizzColor), width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child:Text("assigned".tr(),style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    ),
                                    Text("${viewModel.totalAssign}",style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                  ],
                                ),
                                const SizedBox(height:4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child:Text("paidAssign".tr(),style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    ),
                                    Text("${viewModel.totalPaidAssign}",style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                  ],
                                ),
                                const SizedBox(height:4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child:Text("notAssigned".tr(),style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    ),
                                    Text("${viewModel.totalNotAssign}",style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                  ],
                                ),
                                const SizedBox(height:4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child:Text("unPaidAssign".tr(),style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    ),
                                    Text("${viewModel.totalUnPaidAssign}",style: CustomTextStyle().regular16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                  ],
                                ),
                                const SizedBox(height: 4,),
                                const Divider(
                                  color: AppColors.white,

                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child:Text("total".tr(),style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                    ),
                                    Text("${viewModel.totalNotAssign+viewModel.totalAssign}",style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: containerDecoration(context),
                              width: sizeWidth(context).width*0.4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                  underline: const SizedBox(),
                                  hint: Text("all".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                                  value: viewModel.selectedDistributor,
                                  onChanged: (newValue) async{
                                    viewModel.setSelectedDist(newValue!);
                                    viewModel.setQuery("");
                                    await calculateValue();

                                  },
                                  items: viewModel.groupedDetails.keys.map((String key) {
                                    return DropdownMenuItem<String>(
                                      value: key,
                                      child: Column(
                                        children: [
                                          Text(key,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: TextField(
                                onChanged: (value){
                                  viewModel.setQuery(value);

                                  viewModel.searchInventorySummary(displayedData,viewModel.query);
                                },
                                decoration: searchTextDesign(context, "search"),
                                cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 8,),
                        RawScrollbar(
                          controller: controller,
                          thumbVisibility: true,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thickness: 1,
                          child: SizedBox(
                            width: sizeWidth(context).width,
                            height: justList(context, sizeWidth(context).height),
                            child: ListView.builder(
                              controller: controller,
                              itemCount: viewModel.searchInventorySummary(displayedData,viewModel.query).length,
                              itemBuilder: (context,index){
                                StockReportDataDetails model = viewModel.searchInventorySummary(displayedData,viewModel.query)[index];
                                return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              child: Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(model.serialNumber ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              child: Text("stockDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(mmDDYDate(model.stockDate!.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              child: Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(model.productName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        if(model.distName !=null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child: Text("distributor".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.distName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth(context).width*0.4,
                                              child: Text("isPaid?".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ),
                                            Text(model.isPaid ==true ? "Paid" :"UnPaid",style:
                                            model.isPaid == true ?
                                            CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.wizzColor)):
                                            CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.error)),),
                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        if(model.isPaid ==true)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child: Text("paidDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(mmDDYDate(model.paidAt ?? ""),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                            ],
                                          ),
                                        const SizedBox(height: 4,)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            );

        },
      ),
    );
  }

  Future<void> getList()async{
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    await showProgress(context, true);
    await viewModel.stockReportAllData(context, x,y,null,StringUtil.export);
    await showProgress(context, false);

    if(viewModel.dataDetails !=null){
      viewModel.groupedDetails = await groupByDistributor(viewModel.dataDetails!);
      await calculateValue();
    }
    }
    calculateValue()async{
      viewModel.totalAssign =0;
      viewModel.totalNotAssign =0;
      viewModel.totalPaidAssign =0;
      viewModel.totalUnPaidAssign=0;

      List<StockReportDataDetails> dataDetails;

      if (viewModel.selectedDistributor == null) {
        dataDetails = viewModel.groupedDetails.values.expand((x) => x).toList();
      } else {
        dataDetails = viewModel.groupedDetails[viewModel.selectedDistributor] ?? [];
      }

      for (var detail in dataDetails) {
        if (detail.assignedToDistributor == true) {
          viewModel.totalAssign++;
          if (detail.isPaid == true) {
            viewModel.totalPaidAssign++;
          } else {
            viewModel.totalUnPaidAssign++;
          }
        } else {
          viewModel.totalNotAssign++;
        }
      }
      displayedData = viewModel.selectedDistributor == null
          ? viewModel.dataDetails!
          : viewModel.groupedDetails[viewModel.selectedDistributor] ?? [];
}
  }

