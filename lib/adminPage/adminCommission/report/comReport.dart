import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminCommission/report/comReportGridData.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import '../../../constants/colorsUtil.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
class CommissionReport extends StatefulWidget {
  const CommissionReport({super.key});

  @override
  State<CommissionReport> createState() => _CommissionReportState();
}

class _CommissionReportState extends State<CommissionReport> {
  CommissionVm viewModel = CommissionVm();
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  ComReportGridData? gridSource;
  DataGridController dataGridController = DataGridController();
  @override
  void initState() {

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
    name: "comReport".tr(),
    func: () async {
    await downloadExcel(context, key);
    },),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<CommissionVm>(
            builder: (context,value,_){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            decoration: dateInputDecoration(context,"beginDate"),
                            controller: startDate,
                            readOnly: true,
                            onTap: () async{
                              startDate.text = await DatePickerHelper.getDatePicker(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                decoration: dateInputDecoration(context,"endDate"),
                                controller: endDate,
                                readOnly: true,
                                onTap: () async{
                                  endDate.text = await DatePickerHelper.getDatePicker(context);
                                },
                              ),
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
                              width: sizeWidth(context).width*0.4,
                              child: ElevatedButton(
                                onPressed: ()async{
                                  if(startDate.text.isNotEmpty && endDate.text.isNotEmpty){
                                    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                    dynamic y =  formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");

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
                                child: Text("showReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                              ),
                            ),
                            if(gridSource !=null)
                            SizedBox(
                              width: sizeWidth(context).width*0.4,
                              child:  ElevatedButton(
                                onPressed: (){
                                  selectAreaCommission(context,viewModel);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                            ),
                          ],
                        ),
                    const SizedBox(height: 8,),
                    if(gridSource !=null)
                      SizedBox(
                        height: expenseReportHeight(context, sizeWidth(context).height),
                        child: RefreshIndicator(
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
                                source: gridSource!,
                                key: key,
                                columnWidthMode: ColumnWidthMode.auto,
                                allowFiltering: true,
                                allowEditing: true,
                                editingGestureType: EditingGestureType.tap,
                                navigationMode: GridNavigationMode.cell,
                                selectionMode: SelectionMode.single,

                                columns: <GridColumn>[

                                  GridColumn(
                                      visible:  getStatusVisibility("commissionType".tr(), viewModel.gridMap),
                                      columnName: 'commissionType'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'commissionType'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("poolStatus".tr(), viewModel.gridMap),
                                      columnName: 'poolStatus'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'poolStatus'.tr(),
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
                                      visible:  getStatusVisibility("role".tr(), viewModel.gridMap),
                                      columnName: 'role'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'role'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("salesRole".tr(), viewModel.gridMap),
                                      columnName: 'salesRole'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'salesRole'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("salePrice".tr(), viewModel.gridMap),
                                      columnName: 'salePrice'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'salePrice'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("organisation".tr(), viewModel.gridMap),
                                      columnName: 'organisation'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'organisation'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("minAmount".tr(), viewModel.gridMap),
                                      columnName: 'minAmount'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'minAmount'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("maxAmount".tr(), viewModel.gridMap),
                                      columnName: 'maxAmount'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'maxAmount'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("comAmount".tr(), viewModel.gridMap),
                                      columnName: 'comAmount'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'comAmount'.tr(),
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
                                      visible:  getStatusVisibility("beginDate".tr(), viewModel.gridMap),
                                      columnName: 'beginDate'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'beginDate'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("expireDate".tr(), viewModel.gridMap),
                                      columnName: 'expireDate'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'expireDate'.tr(),
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
                      )

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void>getList()async{
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y =  formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    await viewModel.getCommissionReport(context,x,y);
    gridSource = ComReportGridData(data: viewModel.commissionReport!,context: context);
    List<Map<String, bool>> gridMap = [

      {"commissionType".tr(): true},
      {"poolStatus".tr(): true},
      {"user".tr(): true},
      {"role".tr(): true},
      {"salesRole".tr(): true},
      {"salePrice".tr(): true},
      {"organisation".tr(): true},
      {"minAmount".tr(): true},
      {"maxAmount".tr(): true},
      {"comAmount".tr(): true},
      {"isPaid?".tr(): true},
      {"beginDate".tr(): true},
      {"expireDate".tr(): true},
      {"payDate".tr(): true},
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
