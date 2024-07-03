import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminOverride/report/overrideGridData.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/utils/function/helper/DatepickerHelper.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import "package:syncfusion_flutter_core/theme.dart" show SfDataGridTheme, SfDataGridThemeData;
import '../../../constants/colorsUtil.dart';

class OverrideReport extends StatefulWidget {
  const OverrideReport({super.key});

  @override
  State<OverrideReport> createState() => _OverrideReportState();
}

class _OverrideReportState extends State<OverrideReport> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late OverrideGridData gridSource;
  DataGridController dataGridController = DataGridController();
  AdminOverrideVm viewModel = AdminOverrideVm();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  Map<String, dynamic> orgMap = {};
  double totalAmount=0;
  bool isGridMapAdded = false;
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
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:TextField(
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
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.45,
                          child: ElevatedButton(
                              onPressed: ()async{
                                if(startDate.text.isNotEmpty && endDate.text.isNotEmpty){

                                  dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                  dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");
                                  DateTime selectedStartDate = DateTime.parse(x);
                                  DateTime selectedEndDate = DateTime.parse(y);

                                  if(selectedEndDate.isBefore(selectedStartDate)){
                                    snackBarDesign(context, StringUtil.error, "cannotGreaterEndDate".tr());
                                    return;
                                  }else{
                                    await getList(x,y);
                                  }
                                }else{
                                  snackBarDesign(context, StringUtil.error, "dateRequired".tr());
                                }
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("showReport".tr(), style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)
                          ),
                        ),
                        if(viewModel.overrideWinner !=null && viewModel.overrideWinner!.isNotEmpty)
                          SizedBox(
                            height: 40,
                            width: sizeWidth(context).width*0.45,
                            child:  ElevatedButton(
                              onPressed: (){
                                selectAreaReportsOverride(context,viewModel);
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4,),
                    if(viewModel.overrideWinner !=null)
                      viewModel.overrideWinner!.isEmpty ?
                          emptyView(context, "youDoNotHaveAnyWinnerYet")
                      :  Column(
                        children: [
                          Row(
                              children:[
                                SizedBox(
                                  height: sizeWidth(context).height*0.1,
                                  child: Card(
                                      elevation: 2,
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("totalOverrideAmount".tr(),style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            Text("\$${moneyFormat(totalAmount)}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: sizeWidth(context).height*0.1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: orgMap.length,
                                      itemBuilder: (context,index){
                                        String organisationName = orgMap.keys.elementAt(index);
                                        double overrideAmount = orgMap[organisationName]!;
                                        return SizedBox(
                                          height: 30,
                                          child: Card(
                                              elevation: 2,
                                              shape: cardShape(context),
                                              color: ColorUtil().getColor(context, ColorEnums.background),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(organisationName,style: CustomTextStyle().bold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                    Text("\$${moneyFormat(overrideAmount)}",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                                  ],
                                                ),
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(height: 8,),
                          SizedBox(
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
                                      visible:  getStatusVisibility("overrideCalDate".tr(), viewModel.gridMap),
                                      columnName: 'overrideCalDate'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'overrideCalDate'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible: getStatusVisibility("overrideAmount".tr(), viewModel.gridMap),
                                      columnName: 'overrideAmount'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'overrideAmount'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),

                                  GridColumn(
                                      visible: getStatusVisibility("puchases".tr(), viewModel.gridMap),
                                      columnName: 'puchases'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'puchases'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible: getStatusVisibility("overrideType".tr(), viewModel.gridMap),
                                      columnName: 'overrideType'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'overrideType'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                          ))),
                                  GridColumn(
                                      visible: getStatusVisibility("overrideReceiveBy".tr(), viewModel.gridMap),
                                      columnName: 'overrideReceiveBy'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'overrideReceiveBy'.tr(),
                                            style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                          ))),
                                  GridColumn(
                                      visible:  getStatusVisibility("product".tr(), viewModel.gridMap),
                                      columnName: 'product'.tr(),
                                      label: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'product'.tr(),
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


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                  ],
                  ),
                ),
              );

              }

          ),
        ),
      ),
    );
  }
  Future<void> getList(String begin,String end)async{
    showProgress(context, true);
    await viewModel.getOverrideWinner(context,begin,end,null);
    showProgress(context, false);
    gridSource = OverrideGridData(data: viewModel.overrideWinner!,context: context);
    orgMap= calculateOverrideAmountsByOrg(viewModel.overrideWinner!);

    if(viewModel.overrideWinner!.isNotEmpty){
      for(int i=0;i<viewModel.overrideWinner!.length;i++){
        totalAmount +=double.parse(viewModel.overrideWinner![i].overrideAmount!);
      }
    }

    if(!isGridMapAdded){
      List<Map<String, bool>> gridMap = [
        {"overrideAmount".tr(): true},
        {"puchases".tr(): true},
        {"overrideType".tr(): true},
        {"overrideReceiveBy".tr(): true},
        {"product".tr(): true},
        {"enterSerialNumber".tr(): true},
        {"overrideCalDate".tr(): true},
      ];
      for(int i=0;i<gridMap.length;i++){

        viewModel.addGridMap(gridMap[i]);
      }
      isGridMapAdded = true;
    }
  }
}
