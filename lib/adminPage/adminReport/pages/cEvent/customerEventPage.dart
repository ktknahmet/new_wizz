// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminModel/customerListModel/postCList.dart';
import 'package:wizzsales/adminPage/adminReport/pages/cEvent/cEventDataGrid.dart';
import 'package:wizzsales/adminPage/adminVm/adminVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/widgets/WidgetExtension.dart';

class CustomerEventPage extends StatefulWidget {
  const CustomerEventPage({super.key});

  @override
  State<CustomerEventPage> createState() => _CustomerEventPageState();
}

class _CustomerEventPageState extends State<CustomerEventPage> {
  AdminVm viewModel = AdminVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late CEventDataGrid gridSource;
  DataGridController dataGridController = DataGridController();
  @override
  void initState() {
    allList(context,viewModel.eventNumber,viewModel.eventSize);
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
        name: "customerEvent".tr(),
        func: () async {
          await downloadExcel(context, key);
        },
      ),
      body:SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
                value: viewModel,
                child: Consumer<AdminVm>(
                  builder: (context,view,_){
                    if(viewModel.customerEventModel == null){
                      return spinKit(context);
                    }else{
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${context.tr("total")} : ${viewModel.customerEventModel!.totalRecords!}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              DropdownButton<int>(
                                dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                underline: const SizedBox(),
                                value: viewModel.eventSize, // Varsayılan olarak seçilen değer
                                onChanged: (int? newValue) {
                                  viewModel.setEventSize(newValue!);
                                  allList(context,viewModel.eventNumber,viewModel.eventSize);
                                },
                                items: <int>[5, 10, 20, 30, 50, 100,viewModel.customerEventModel!.totalRecords!].map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text('Page Size: $value',style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  );
                                }).toList(),
                              ),

                            ],
                          ),
                          const SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:  SizedBox(
                              height: 40,
                              width: sizeWidth(context).width*0.4,
                              child:  ElevatedButton(
                                onPressed: (){
                                  selectAreaReports(context,viewModel);
                                },
                                style: elevatedButtonStyle(context),
                                child: Text("selectArea".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          RefreshIndicator(
                            onRefresh:()=>allList(context,viewModel.eventNumber,viewModel.eventSize),
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

                                    var tiklanilanVeri = gridSource
                                        .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                                        .getCells()[details.rowColumnIndex.columnIndex].value.toString();

                                    print("tıklanılan veri :$tiklanilanVeri");
                                    var columnName = details.column.columnName;
                                    var rowData = details.rowColumnIndex.rowIndex -1;

                                    print("column name :$columnName");
                                    if(columnName=="profile".tr()){
                                      if(viewModel.customerEventModel!.data![rowData].customer!.avatar !=null){
                                        showPhoto(context, viewModel.customerEventModel!.data![rowData].customer!.avatar!);
                                      }
                                    }else if(columnName=="details".tr()){
                                      customerEventDetails(context,viewModel.customerEventModel!.data![rowData].rewardEvent!,viewModel.customerEventModel!.data![rowData].rewardEventActivityDetailDocuments);
                                    }else if(columnName=="eventState".tr()){

                                        bool check = await updateCustomerEvent(context,viewModel.customerEventModel!.data![rowData].eventState!);
                                       if(check){
                                         PostCList post = PostCList(eventName:viewModel.customerEventModel!.data![rowData].rewardEvent!.eventName,
                                             eventAction: viewModel.customerEventModel!.data![rowData].rewardEvent!.eventAction,
                                             rewardEventActivityDetailId: viewModel.customerEventModel!.data![rowData].id!,
                                             participantId: viewModel.customerEventModel!.data![rowData].customer!.id!);
                                         await viewModel.postCustomerEvent(context, post);
                                         if(viewModel.response!.isSuccess == true){
                                           snackBarDesign(context, StringUtil.success, viewModel.response!.message);
                                           allList(context,viewModel.eventNumber,viewModel.eventSize);
                                         }else{
                                           snackBarDesign(context, StringUtil.error, viewModel.response!.message);
                                         }
                                       }
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
                                        visible:  getStatusVisibility("eventAction".tr(), viewModel.gridMap),
                                        columnName: 'eventAction'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'eventAction'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("video".tr(), viewModel.gridMap),
                                        columnName: 'video'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'video'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("profile".tr(), viewModel.gridMap),
                                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                                        columnName: 'profile'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'profile'.tr(),
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

                                    GridColumn(
                                        visible:  getStatusVisibility("eventPoint".tr(), viewModel.gridMap),
                                        columnName: 'eventPoint'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'eventPoint'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("firstName".tr(), viewModel.gridMap),
                                        columnName: 'firstName'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'firstName'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("lastName".tr(), viewModel.gridMap),
                                        columnName: 'lastName'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'lastName'.tr(),
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
                                        visible:  getStatusVisibility("birthDay".tr(), viewModel.gridMap),
                                        columnName: 'birthDay'.tr(),
                                        label: Container(

                                            alignment: Alignment.center,
                                            child: Text(
                                              'birthDay'.tr(),
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
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child:Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async{
                                          if(viewModel.eventNumber >1){
                                            viewModel.eventNumber--;
                                            await allList(context,viewModel.eventNumber,viewModel.eventSize);
                                          }
                                        },
                                        style:elevatedButtonStyle(context),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back,color: ColorUtil().getColor(context, ColorEnums.wizzColor),), // Replace 'your_icon' with the desired icon

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8,),
                                  Expanded(
                                    child: SizedBox(
                                        width: sizeWidth(context).width*0.70,
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: viewModel.customerEventModel!.totalPages!,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                viewModel.setEventNumber(index+1);
                                                await allList(context,viewModel.eventNumber,viewModel.eventSize);
                                              },
                                              child: Row(
                                                children: [
                                                  viewModel.eventNumber == index + 1
                                                      ? Container(
                                                    height: sizeWidth(context).height * 0.048,
                                                    width: sizeWidth(context).width * 0.088,
                                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(viewModel.eventNumber.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
                                                    ),
                                                  )
                                                      : SizedBox(
                                                    height: sizeWidth(context).height * 0.048,
                                                    width: sizeWidth(context).width * 0.088,

                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text("${index + 1}", style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async{
                                          if(viewModel.eventNumber <=viewModel.rewardOrderModel!.totalPages!){
                                            viewModel.eventNumber++;

                                            await allList(context,viewModel.eventNumber,viewModel.eventSize);
                                          }
                                        },
                                        style:elevatedButtonStyle(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.arrow_forward,color: ColorUtil().getColor(context, ColorEnums.wizzColor),), // Replace 'your_icon' with the desired icon

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
      ) ,
    );
  }
  Future<void> allList(BuildContext context,int number,int size) async{
    await viewModel.getEventList(context, number, size);
    gridSource = CEventDataGrid(data: viewModel.customerEventModel!.data!,context: context);
    List<Map<String, bool>> gridMap = [
      {"details".tr(): true},
      {"eventAction".tr(): true},
      {"video".tr(): false},
      {"profile".tr(): false},
      {"status".tr(): true},
      {"eventPoint".tr(): false},
      {"firstName".tr(): false},
      {"lastName".tr(): false},
      {"email".tr(): false},
      {"phone".tr(): false},
      {"birthDay".tr(): false},
      {"date".tr(): false},
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
