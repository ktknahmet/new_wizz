import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/reports/leadReport/leadExcelReport/myLeadGrid.dart';
import 'package:wizzsales/viewModel/MyLeadVm.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

import '../../../../constants/colorsUtil.dart';
// ignore_for_file: use_build_context_synchronously
class TotalLeadsReport extends StatefulWidget {
  const TotalLeadsReport({super.key});

  @override
  State<StatefulWidget> createState() => _TotalLeadsReportState();
}

class _TotalLeadsReportState extends State<TotalLeadsReport> {
  MyLeadVm viewModel = MyLeadVm();
  late MyLeadGrid gridSource;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  DataGridController dataGridController = DataGridController();
  @override
  void initState() {
    getList();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: ReportAppBar(
        name: "leadsReport".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<MyLeadVm>(
          builder: (context,value,_){
            if(viewModel.leadReports == null){
              return spinKit(context);
            }else if(viewModel.leadReports!.isEmpty){
              return emptyView(context, "notYetLead");
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child:  SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child:  ElevatedButton(
                          onPressed: (){
                            selectAreaLeadReport(context,viewModel);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh:getList,
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      child: SizedBox(
                        height: reportsHeightWithoutPage(context,sizeWidth(context).height),
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

                            onCellTap: (DataGridCellTapDetails details) {
                              var tiklanilanVeri = gridSource
                                  .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                                  .getCells()[details.rowColumnIndex.columnIndex]
                                  .value
                                  .toString();
                              print("tıklanılan veri :$tiklanilanVeri");
                            },
                            columns: <GridColumn>[
                              GridColumn(
                                  visible:  getStatusVisibility("leadType".tr(), viewModel.gridMap),
                                  columnName: 'leadType'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'leadType'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),
                              GridColumn(
                                  visible:  getStatusVisibility("total".tr(), viewModel.gridMap),
                                  columnName: 'total'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'total'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),
                              GridColumn(
                                  visible:  getStatusVisibility("appointmentSet".tr(), viewModel.gridMap),
                                  columnName: 'appointmentSet'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'appointmentSet'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),

                              GridColumn(
                                  visible:  getStatusVisibility("notContacted".tr(), viewModel.gridMap),
                                  columnName: 'notContacted'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'notContacted'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),

                              GridColumn(
                                  visible:  getStatusVisibility("sold".tr(), viewModel.gridMap),
                                  columnName: 'sold'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'sold'.tr(),
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
    );
  }
  Future<void>getList() async{
    await viewModel.allLeadReport(context);
    gridSource = MyLeadGrid(data: viewModel.leadReports!,context: context);

    List<Map<String, bool>> gridMap = [
      {"leadType".tr(): true},
      {"total".tr(): true},
      {"appointmentSet".tr(): true},
      {"notContacted".tr(): true},
      {"sold".tr(): true},

    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }

  }
}
