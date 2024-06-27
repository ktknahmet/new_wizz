import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminVm/stockVm.dart';
import 'package:wizzsales/adminPage/inventory/report/inventoryGridData.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import "package:syncfusion_flutter_core/theme.dart" show SfDataGridTheme, SfDataGridThemeData;
import '../../../constants/colorsUtil.dart';

class InventoryReport extends StatefulWidget {
  const InventoryReport({super.key});

  @override
  State<InventoryReport> createState() => _InventoryReportState();
}

class _InventoryReportState extends State<InventoryReport> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  StockVm viewModel = StockVm();
  late InventoryGridData gridSource;
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
      name: "inventoryReport".tr(),
      func: () async {
           await downloadExcel(context, key);
       },
    ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<StockVm>(
              builder: (context,view,_){
                if(viewModel.distStockList == null){
                  return spinKit(context);
                }else{
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${context.tr("total")} : ${viewModel.distStockList!.length}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                           SizedBox(
                              width: sizeWidth(context).width*0.4,
                              height: 30,
                              child:  ElevatedButton(
                                onPressed: (){
                                  selectAreaInventory(context,viewModel);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                            ),


                        ],
                      ),

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


                                  var columnName = details.column.columnName;
                                  var rowData = details.rowColumnIndex.rowIndex -1;
                                  if(columnName=="details".tr()){
                                    Navigator.pushNamed(context, '/${PageName.stockHistory}',arguments: {"poolId":viewModel.distStockList![rowData].poolDetailId});
                                 }
                               },
                              columns: <GridColumn>[
                                GridColumn(
                                    visible:  getStatusVisibility("details".tr(), viewModel.gridMap),
                                    columnName: 'details'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'details'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),

                                GridColumn(
                                    visible:  getStatusVisibility("enterSerialNumber".tr(), viewModel.gridMap),
                                    columnName: 'enterSerialNumber'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'enterSerialNumber'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("quantity".tr(), viewModel.gridMap),
                                    columnName: 'quantity'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'quantity'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("date".tr(), viewModel.gridMap),
                                    columnName: 'date'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'date'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("isPaid?".tr(), viewModel.gridMap),
                                    columnName: 'isPaid?'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'isPaid?'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                        ))),

                                GridColumn(
                                    visible:  getStatusVisibility("payDate".tr(), viewModel.gridMap),
                                    columnName: 'payDate'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'payDate'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                }
              },
            ),
          ),




        ),

      ),
    );
  }
  Future<void>getList()async{
    await viewModel.getStock(context);
    gridSource = InventoryGridData(data: viewModel.distStockList!,context: context);
    List<Map<String, bool>> gridMap = [
      {"details".tr(): true},
      {"enterSerialNumber".tr(): true},
      {"quantity".tr(): false},
      {"date".tr(): false},
      {"isPaid?".tr(): true},
      {"payDate".tr(): true},
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
