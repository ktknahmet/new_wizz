
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/reports/appointmentReport/appointmentGrid.dart';
import 'package:wizzsales/viewModel/MyAppointmentVm.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class AppointmentReport extends StatefulWidget {
  const AppointmentReport({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentReportState();
}

class _AppointmentReportState extends State<AppointmentReport> {
  LoginUser? loginUser;
  MyAppointmentVm viewModel = MyAppointmentVm();
  late AppointmentGrid gridSource;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    allAppointment(viewModel.currentPage);
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
      backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
      appBar: ReportAppBar(
        name: "appointmentReport".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<MyAppointmentVm>(
          builder: (context,value,_){
            if(viewModel.allAppointment == null){
              return spinKit(context);
            }else if(viewModel.allAppointment!.isEmpty){
              return emptyView(context, "notYetAppointment");
            }else{
              return  Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child:  SizedBox(
                        width: sizeWidth(context).width*0.4,
                        child:  ElevatedButton(
                          onPressed: (){
                            selectAreaApptReport(context,viewModel);
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh:()=>allAppointment(viewModel.currentPage),
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
                                  visible:  getStatusVisibility("time".tr(), viewModel.gridMap),
                                  columnName: 'time'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'time'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),
                              GridColumn(
                                  visible:  getStatusVisibility("cName".tr(), viewModel.gridMap),
                                  columnName: 'cName'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'cName'.tr(),
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
                                  visible:  getStatusVisibility("cPhone".tr(), viewModel.gridMap),
                                  columnName: 'cPhone'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'cPhone'.tr(),
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
                                  visible:  getStatusVisibility("referredBy".tr(), viewModel.gridMap),
                                  columnName: 'referredBy'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'referredBy'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                      ))),
                              GridColumn(
                                  visible:  getStatusVisibility("distributor".tr(), viewModel.gridMap),
                                  columnName: 'distributor'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'distributor'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                      ))),
                              GridColumn(
                                  visible:  getStatusVisibility("dealerRunBy".tr(), viewModel.gridMap),
                                  columnName: 'dealerRunBy'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'dealerRunBy'.tr(),
                                        style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                      ))),
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
                                  visible:  getStatusVisibility("status".tr(), viewModel.gridMap),
                                  columnName: 'status'.tr(),
                                  label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'status'.tr(),
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
    );
  }


  Future<void> allAppointment(int page)async{
    await viewModel.getAllAppointment(context);
    gridSource = AppointmentGrid(data: viewModel.allAppointment!,context: context);
    List<Map<String, bool>> gridMap = [
      {"date".tr(): true},
      {"time".tr(): true},
      {"cName".tr(): true},
      {"address".tr(): true},
      {"cPhone".tr(): true},
      {"email".tr(): true},
      {"referredBy".tr(): true},
      {"distributor".tr(): true},
      {"dealerRunBy".tr(): true},
      {"leadType".tr(): true},
      {"status".tr(): true},

    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
