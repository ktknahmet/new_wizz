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
            if(viewModel.dataDetails == null){
              return spinKit(context);
            }else{
              return SingleChildScrollView(
                  child:  Column(
                    children: [
                      const SizedBox(height: 8,),
                      Container(
                        decoration: containerDecoration(context),
                        width: sizeWidth(context).width,
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
                                child: Text(key,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              );
                            }).toList(),
                          ),
                        ),
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
                            itemCount: viewModel.selectedDistributor == "all".tr()
                                ? viewModel.groupedDetails.values.expand((x) => x.keys).toSet().length
                                : viewModel.groupedDetails[viewModel.selectedDistributor]?.keys.length ?? 0,
                            itemBuilder: (context, index) {
                              List<String> warehouseNames;
                              if (viewModel.selectedDistributor == "all".tr()) {
                                warehouseNames = viewModel.groupedDetails.values.expand((x) => x.keys).toSet().toList();
                              } else {
                                warehouseNames = viewModel.groupedDetails[viewModel.selectedDistributor]?.keys.toList() ?? [];
                              }
                              var warehouseName = warehouseNames[index];

                              List warehouseDetails;
                              if (viewModel.selectedDistributor == "all".tr()) {
                                warehouseDetails = viewModel.groupedDetails.values.expand((x) => x[warehouseName] ?? []).toList();
                              } else {
                                warehouseDetails = viewModel.groupedDetails[viewModel.selectedDistributor]?[warehouseName] ?? [];
                              }

                              return Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            warehouseName,
                                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                          ),
                                          Text(
                                            warehouseDetails.length.toString(),
                                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                          ),
                                        ],
                                      ),
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
              );
            }

        },
      ),
    );
  }

  Future<void> getList()async{
    await showProgress(context, true);
    await viewModel.stockReportAllData(context, null,null,null,StringUtil.export);
    await showProgress(context, false);

    if (viewModel.dataDetails != null) {
      viewModel.groupedDetails = await groupByDistributorAndWarehouse(viewModel.dataDetails!);
      await calculateValue();
    }
    }
  calculateValue() async {

    // "All" seçildiğinde tüm depolar ve ürün sayıları gösterilecektir
    displayedData = viewModel.selectedDistributor == "all".tr()
        ? viewModel.groupedDetails.values.expand((x) => x.values.expand((y) => y)).toList()
        : viewModel.groupedDetails[viewModel.selectedDistributor]?.values.expand((x) => x).toList() ?? [];

  }
  }

