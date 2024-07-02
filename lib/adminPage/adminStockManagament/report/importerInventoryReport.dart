import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminVm/warehouseVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import "package:syncfusion_flutter_core/theme.dart" show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../utils/function/helper/DatepickerHelper.dart';
import '../../../utils/res/StringUtils.dart';
import '../../../utils/style/CustomTextStyle.dart';
import '../../../utils/style/ReportAppBar.dart';
import '../../../utils/style/WidgetStyle.dart';
import '../../../widgets/Extension.dart';
import 'ImporterInventoryReportGrid.dart';
// ignore_for_file: use_build_context_synchronously

class ImporterInventoryReport extends StatefulWidget {
  const ImporterInventoryReport({super.key});

  @override
  State<ImporterInventoryReport> createState() => _ImporterInventoryReportState();
}

class _ImporterInventoryReportState extends State<ImporterInventoryReport> {

  WarehouseVm viewModel = WarehouseVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  ImporterInventoryReportGrid? gridSource;
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
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<WarehouseVm>(
            builder: (context,value,_){
              if(viewModel.organisations == null){
                return spinKit(context);
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
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
                                      await allList(context);
                                    }
                                  }else{
                                    snackBarDesign(context, StringUtil.error, "requiredReportDate".tr());
                                  }
                    
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("showReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child: TextField(
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                decoration: dateInputDecoration(context,"selectDist"),
                                controller: viewModel.distInfo,
                                readOnly: true,
                                onTap: () async{
                    
                                  if(viewModel.organisations!.isNotEmpty){
                                   viewModel.distId = await showOrgInventoryDist(context,viewModel);
                                   if(startDate.text.isNotEmpty && endDate.text.isNotEmpty){
                                     dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                     dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                     DateTime selectedStartDate = DateTime.parse(x);
                                     DateTime selectedEndDate = DateTime.parse(y);
                    
                                     if(selectedEndDate.isBefore(selectedStartDate)){
                                       snackBarDesign(context, StringUtil.error, "cannotGreaterEndDate".tr());
                                     }else{
                                       await allList(context);
                                     }
                                   }else{
                                     snackBarDesign(context, StringUtil.error, "requiredReportDate".tr());
                                   }
                                  }else{
                                    snackBarDesign(context, StringUtil.warning, "userListEmpty".tr());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8,),
                      if(viewModel.dataDetails !=null)
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child: Column(
                                        children: [
                                          Text("assigned".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                          Text("${viewModel.totalAssign}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child: Column(
                                        children: [
                                          Text("notAssigned".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                          Text("${viewModel.totalNotAssign}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizeWidth(context).width*0.30,
                                      child: Column(
                                        children: [
                                          Text("total".tr(),style: CustomTextStyle().regular18(ColorUtil().getColor(context, ColorEnums.whitePureLight)),),
                                          Text("${viewModel.totalNotAssign+viewModel.totalAssign}",style: CustomTextStyle().black14(ColorUtil().getColor(context, ColorEnums.whitePureLight)))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        if(gridSource !=null)
                        SizedBox(
                          height: justList(context, sizeWidth(context).height),
                          child: RefreshIndicator(
                            onRefresh:()=>allList(context),
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
                                  source: gridSource!,
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
                                        //visible:  getStatusVisibility("stockDate".tr(), viewModel.gridMap),
                                        columnName: 'stockDate'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'stockDate'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        //visible:  getStatusVisibility("enterSerialNumber".tr(), viewModel.gridMap),
                                        columnName: 'enterSerialNumber'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'enterSerialNumber'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        //visible:  getStatusVisibility("assigned".tr(), viewModel.gridMap),
                                        columnName: 'assigned'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'assigned'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                    
                                            ))),
                                    GridColumn(
                                        //visible:  getStatusVisibility("product".tr(), viewModel.gridMap),
                                        columnName: 'product'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'product'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                    
                                            ))),
                                    GridColumn(
                                       // visible:  getStatusVisibility("distributor".tr(), viewModel.gridMap),
                                        columnName: 'distributor'.tr(),
                                        label: Container(
                    
                                            alignment: Alignment.center,
                                            child: Text(
                                              'distributor'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                    
                                            ))),
                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  getList()async{
    await viewModel.getOrganisations(context);
  }
  Future<void> allList(BuildContext context) async{
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    await viewModel.stockReportAllData(context, x,y,viewModel.distId,StringUtil.export);
    gridSource = ImporterInventoryReportGrid(data: viewModel.dataDetails!,context: context);

    // paid edilmiş ve edilmemiş olanlarda gelecek pending payment assign edilmiş fakat paid edilmiş cancel payment
    // warehouse adı da gelecek
    if(viewModel.dataDetails !=null){
      viewModel.totalAssign =0;
      viewModel.totalNotAssign =0;
      for(int i=0;i<viewModel.dataDetails!.length;i++){
        if(viewModel.dataDetails![i].assignedToDistributor==true){
          viewModel.totalAssign++;
        }else{
          viewModel.totalNotAssign +=1;
        }

      }
    }

  }
}
