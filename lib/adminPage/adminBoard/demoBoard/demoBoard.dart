import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminBoard/demoBoard/demoBoardGridData.dart';
import 'package:wizzsales/adminPage/adminVm/adminBoardVm.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class DemoBoard extends StatefulWidget {
  const DemoBoard({super.key});

  @override
  State<DemoBoard> createState() => _DemoBoardState();
}

class _DemoBoardState extends State<DemoBoard> {
  AdminBoardVm viewModel = AdminBoardVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late DemoBoardGridData gridSource;
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
        name: "liveDemoReport".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AdminBoardVm>(
            builder: (context,value,_){
              if(viewModel.boardList == null){
                return spinKit(context);
              }else if(viewModel.boardList!.boardDemo!.isEmpty){
                return emptyView(context, "youDoNotHaveAnyLiveDemo");
              }else{
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child:  SizedBox(
                          width: sizeWidth(context).width*0.4,
                          child:  ElevatedButton(
                            onPressed: (){
                              selectAreaDemoBoard(context,viewModel);
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
                          height: reportsHeight(context,sizeWidth(context).height),
                          child: SfDataGridTheme(

                            data: SfDataGridThemeData(
                              sortIconColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                              gridLineStrokeWidth:0.2,
                              gridLineColor:ColorUtil().getColor(context, ColorEnums.textTitleLight),
                              selectionColor: ColorUtil().getColor(context, ColorEnums.transparant),
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
                                    visible:  getStatusVisibility("status".tr(), viewModel.gridMap),
                                    columnName: 'status'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'status'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        )),
                                ),

                                GridColumn(
                                    visible:  getStatusVisibility("name".tr(), viewModel.gridMap),
                                    columnName: 'name'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'name'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("email".tr(), viewModel.gridMap),
                                    columnName: 'email'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'email'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("phone".tr(), viewModel.gridMap),
                                    columnName: 'phone'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'phone'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("demoStartDate".tr(), viewModel.gridMap),
                                    columnName: 'demoStartDate'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'demoStartDate'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("demoEndTime".tr(), viewModel.gridMap),
                                    columnName: 'demoEndTime'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'demoEndTime'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("city".tr(), viewModel.gridMap),
                                    columnName: 'city'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'city'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                                GridColumn(
                                    visible:  getStatusVisibility("address".tr(), viewModel.gridMap),
                                    columnName: 'address'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'address'.tr(),
                                          style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                        ))),
                               GridColumn(
                                   visible:  getStatusVisibility("zipCode".tr(), viewModel.gridMap),
                                     columnName: 'zipCode'.tr(),
                                     label: Container(
                                         alignment: Alignment.center,
                                         child: Text(
                                           'zipCode'.tr(),
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

  Future<void> getList()async{
    await viewModel.getBoard(context);
    gridSource = DemoBoardGridData(data: viewModel.boardList!.boardDemo!,context: context);

    List<Map<String, bool>> gridMap = [
      {"status".tr(): true},
      {"name".tr(): true},
      {"email".tr(): false},
      {"phone".tr(): false},
      {"demoStartDate".tr(): true},
      {"demoEndTime".tr(): true},
      {"city".tr(): false},
      {"address".tr(): false},
      {"zipCode".tr(): false}
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }

  }

}
