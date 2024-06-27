import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminBonus/bonusReport/bonusReportDataGrid.dart';
import 'package:wizzsales/adminPage/adminVm/adminBonusVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
// ignore_for_file: use_build_context_synchronously

class BonusWinnerReport extends StatefulWidget {
  const BonusWinnerReport({super.key});

  @override
  State<BonusWinnerReport> createState() => _BonusWinnerReportState();
}

class _BonusWinnerReportState extends State<BonusWinnerReport> {
  AdminBonusVm viewModel = AdminBonusVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late BonusReportDataGrid gridSource;
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
      appBar: ReportAppBar(
        name: "bonusWinnerReport".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: sizeWidth(context).width,
          height: sizeWidth(context).height,
          child: ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<AdminBonusVm>(
              builder: (context,value,_){
                if(viewModel.bonusWinnerList == null){
                  return spinKit(context);
                }else if(viewModel.bonusWinnerList!.isEmpty){
                  return emptyView(context, "yoDoNotHaveBonusWinner");
                }else{
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${context.tr("total")} : ${viewModel.bonusWinnerList!.length}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          SizedBox(
                            width: sizeWidth(context).width*0.4,
                            height: 40,
                            child:  ElevatedButton(
                              onPressed: (){
                                selectAreaBonus(context,viewModel);
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

                              columns: <GridColumn>[
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
                                    visible:  getStatusVisibility("role".tr(), viewModel.gridMap),
                                    columnName: 'role'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'role'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("user".tr(), viewModel.gridMap),
                                    columnName: 'user'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'user'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),

                                GridColumn(
                                    visible:  getStatusVisibility("bonusType".tr(), viewModel.gridMap),
                                    columnName: 'bonusType'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'bonusType'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                        ))),

                                GridColumn(
                                    visible:  getStatusVisibility("totalQuantity".tr(), viewModel.gridMap),
                                    columnName: 'totalQuantity'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'totalQuantity'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("bonusAmount".tr(), viewModel.gridMap),
                                    columnName: 'bonusAmount'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'bonusAmount'.tr(),
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
  Future<void> getList()async{
    await viewModel.getBonusWinner(context);
    gridSource = BonusReportDataGrid(data: viewModel.bonusWinnerList!,context: context);
    List<Map<String, bool>> gridMap = [
      {"date".tr(): false},
      {"role".tr(): true},
      {"user".tr(): true},
      {"bonusType".tr(): false},
      {"totalQuantity".tr(): false},
      {"bonusAmount".tr(): false}
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
