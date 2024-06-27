import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/expense/report/expenseReportGrid.dart';
import 'package:wizzsales/viewModel/ExpenseVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import '../../../constants/colorsUtil.dart';
// ignore_for_file: use_build_context_synchronously
class ExpenseReport extends BaseStatefulPage {
  const ExpenseReport(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends BaseStatefulPageState<ExpenseReport> {
  ExpenseVm viewModel = ExpenseVm();
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  ExpenseReportGrid? gridSource;
  DataGridController dataGridController = DataGridController();
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ExpenseVm>(
        builder: (context,value,_){
          return Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: sizeWidth(context).width*0.4,
                    child: TextField(
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                      cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      decoration: dateInputDecoration(context,"startExpenseDate"),
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
                      decoration: dateInputDecoration(context,"endExpenseDate"),
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
                  if(gridSource !=null)
                  SizedBox(
                    width: sizeWidth(context).width*0.4,
                    child: ElevatedButton(
                      onPressed: ()async{
                        await downloadExcel(context, key);
                      },
                      style: elevatedButtonStyle(context),
                      child: Text("exportData".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8,),
              if(gridSource !=null)
              SizedBox(
                height: expenseReportHeight(context, sizeWidth(context).height),
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

                          var tiklanilanVeri = gridSource!
                              .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                              .getCells()[details.rowColumnIndex.columnIndex].value.toString();

                          print("tıklanılan veri :$tiklanilanVeri");
                          var columnName = details.column.columnName;
                          var rowData = details.rowColumnIndex.rowIndex -1;

                          print("column name :$columnName");
                          if(columnName=="document".tr()){
                            if(viewModel.expenseReport![rowData].documentPath !=null){
                              showPhoto(context, viewModel.expenseReport![rowData].documentPath!);
                            }
                          }

                        },
                        columns: <GridColumn>[

                          GridColumn(
                              columnName: 'cName'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'cName'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                  ))),
                          GridColumn(
                              columnName: 'organisation'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'organisation'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                  ))),
                          GridColumn(
                              columnName: 'expense'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'expense'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                  ))),

                          GridColumn(
                              columnName: 'expenseDate'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'expenseDate'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                  ))),
                          GridColumn(
                              columnName: 'expenseNetPrice'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'expenseNetPrice'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                  ))),
                         /* GridColumn(
                              columnName: 'expenseTaxPrice'.tr(),
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'expenseTaxPrice'.tr(),
                                    style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                  ))),*/

                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          );
        },
      ),
    );
  }
  Future<void> allList(BuildContext context) async{
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    await viewModel.allExpenseReport(context, x,y);
    gridSource = ExpenseReportGrid(data: viewModel.expenseReport!,context: context);
  }

}
