import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/dealerOverride/dealerOverrideGridData.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import "package:syncfusion_flutter_core/theme.dart" show SfDataGridTheme, SfDataGridThemeData;
import '../../constants/colorsUtil.dart';

class DealerOverrideWinner extends StatefulWidget {
  const DealerOverrideWinner({super.key});

  @override
  State<DealerOverrideWinner> createState() => _DealerOverrideWinnerState();
}

class _DealerOverrideWinnerState extends State<DealerOverrideWinner> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late DealerOverrideGridData gridSource;
  DataGridController dataGridController = DataGridController();
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
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: ReportAppBar(
        name: "overrideReport".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminOverrideVm>(
            builder: (context,value,_){
              if(viewModel.dealerOverrideWinner == null){
                return spinKit(context);
              }else if(viewModel.dealerOverrideWinner!.isEmpty){
                return emptyView(context, "youDoNotHaveAnyWinnerYet");
              }else{
                return Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: containerDecoration(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("total".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                const SizedBox(height: 4,),
                                Text("\$${totalDealerOverrideAmount(viewModel.dealerOverrideWinner!)}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      RefreshIndicator(
                        onRefresh:getList,
                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        child: SizedBox(
                          height: reportsHeight(context,sizeWidth(context).height),
                          child: SfDataGridTheme(
                            data: SfDataGridThemeData(
                              sortIconColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                              gridLineStrokeWidth:0.2,
                              gridLineColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                              selectionColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              filterIconColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),),
                            child: SfDataGrid(
                              controller: dataGridController,
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility: GridLinesVisibility.both,
                              source: gridSource,
                              key: key,
                              columnWidthMode: ColumnWidthMode.auto,
                              allowFiltering: true,
                              allowEditing: true,
                              editingGestureType: EditingGestureType.tap,
                              navigationMode: GridNavigationMode.cell,
                              selectionMode: SelectionMode.single,
                              onCellTap: (DataGridCellTapDetails details) async{

                              },

                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'overrideAmount'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'overrideAmount'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),

                                GridColumn(
                                    columnName: 'puchases'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'puchases'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    columnName: 'overrideType'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'overrideType'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(

                                    columnName: 'overrideReceiveBy'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'overrideReceiveBy'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                        ))),
                                GridColumn(
                                    columnName: 'product'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'product'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                        ))),

                                GridColumn(
                                    columnName: 'enterSerialNumber'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'enterSerialNumber'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),

                                GridColumn(
                                    columnName: 'overrideCalDate'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'overrideCalDate'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),



                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.getOverrideWinnerDealer(context);
    gridSource = DealerOverrideGridData(data: viewModel.dealerOverrideWinner!,context: context);
  }
}
