import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminReport/pages/rewardOrders/RewardOrderGridSource.dart';
import 'package:wizzsales/adminPage/adminVm/adminVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import '../../../../constants/colorsUtil.dart';
import '../../../../widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class RewardOrders extends StatefulWidget {
  const RewardOrders({super.key});

  @override
  State<RewardOrders> createState() => _RewardOrdersState();
}

class _RewardOrdersState extends State<RewardOrders> {
  AdminVm viewModel = AdminVm();
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  late RewardOrderGridSource gridSource;
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    allList(context,viewModel.rewardNumber,viewModel.rewardSize);
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
        name: "rewardOrders".tr(),
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
                    if(viewModel.rewardOrderModel == null){
                      return spinKit(context);
                    }else{
                      return Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${context.tr("total")} : ${viewModel.rewardOrderModel!.totalRecords!}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                DropdownButton<int>(
                                  dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                  underline: const SizedBox(),
                                  value: viewModel.rewardSize, // Varsayılan olarak seçilen değer
                                  onChanged: (int? newValue) {
                                    viewModel.setRewardSize(newValue!);
                                    allList(context,viewModel.rewardNumber,viewModel.rewardSize);
                                  },
                                  items: <int>[5, 10, 20, 30, 50, 100,viewModel.rewardOrderModel!.totalRecords!].map<DropdownMenuItem<int>>((int value) {
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
                            onRefresh:()=>allList(context,viewModel.rewardNumber,viewModel.rewardSize),
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

                                    var tiklanilanVeri = gridSource
                                        .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                                        .getCells()[details.rowColumnIndex.columnIndex]
                                        .value
                                        .toString();


                                    if(columnName=="profile".tr()){
                                      if(viewModel.rewardOrderModel!.data![rowData]!.customer!.avatar !=null){
                                        showPhoto(context, viewModel.rewardOrderModel!.data![rowData]!.customer!.avatar!);
                                      }
                                    }else if(columnName=="details".tr()){
                                      rewardOrderLines(context,viewModel.rewardOrderModel!.data![rowData]!.rewardOrderLines!);


                                    }else if(tiklanilanVeri !="canceled".tr()){
                                      if(viewModel.rewardOrderModel!.data![rowData]!.isUsedCodeByCustomer ==false){
                                        bool check = await approvedReward(context);
                                        if(check){
                                          await viewModel.usedOrderReward(context,viewModel.rewardOrderModel!.data![rowData]!.transactionCode!);
                                          if(viewModel.response!.isSuccess == true){
                                            allList(context,viewModel.rewardNumber,viewModel.rewardSize);
                                            snackBarDesign(context, StringUtil.success, viewModel.response!.message);
                                          }else{
                                            snackBarDesign(context, StringUtil.error, viewModel.response!.message);
                                          }
                                        }

                                      }else{
                                        bool check = await approvedReward(context);
                                        if(check){
                                          await viewModel.updateRewardApprove(context,viewModel.rewardOrderModel!.data![rowData]!.transactionCode!);
                                          if(viewModel.response!.isSuccess == true){
                                            allList(context,viewModel.rewardNumber,viewModel.rewardSize);
                                            snackBarDesign(context, StringUtil.success, viewModel.response!.message);
                                          }else{
                                            snackBarDesign(context, StringUtil.error, viewModel.response!.message);
                                          }
                                        }
                                      }
                                    }else {
                                      //canceled ise buraya bakar
                                      bool check = await cancelReward(context);
                                      if(check){
                                        await viewModel.cancelRewardApprove(context,viewModel.rewardOrderModel!.data![rowData]!.transactionCode!);
                                        if(viewModel.response!.isSuccess == true){
                                          allList(context,viewModel.rewardNumber,viewModel.rewardSize);
                                          snackBarDesign(context, StringUtil.success, viewModel.response!.message);
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
                                        visible:  getStatusVisibility("usedDate".tr(), viewModel.gridMap),
                                        columnName: 'usedDate'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'usedDate'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                            ))),

                                    GridColumn(
                                        visible:  getStatusVisibility("transactionCode".tr(), viewModel.gridMap),
                                        columnName: 'transactionCode'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'transactionCode'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("customerRewardOrderCode".tr(), viewModel.gridMap),
                                        columnName: 'customerRewardOrderCode'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'customerRewardOrderCode'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("orderDate".tr(), viewModel.gridMap),
                                        columnName: 'orderDate'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'orderDate'.tr(),
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
                                        visible:  getStatusVisibility("status".tr(), viewModel.gridMap),
                                        columnName: 'status'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'status'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                            ))),
                                    GridColumn(
                                        visible:  getStatusVisibility("statusDate".tr(), viewModel.gridMap),
                                        columnName: 'statusDate'.tr(),
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'statusDate'.tr(),
                                              style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                            ))),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
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
                                          if(viewModel.rewardNumber >1){
                                            viewModel.rewardNumber--;
                                            await allList(context,viewModel.rewardNumber,viewModel.rewardSize);
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
                                          itemCount: viewModel.rewardOrderModel!.totalPages!,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                viewModel.setRewardNumber(index+1);
                                                await allList(context,viewModel.rewardNumber,viewModel.rewardSize);
                                              },
                                              child: Row(
                                                children: [
                                                  viewModel.rewardNumber == index + 1
                                                      ? Container(
                                                    height: sizeWidth(context).height * 0.048,
                                                    width: sizeWidth(context).width * 0.088,
                                                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(viewModel.rewardNumber.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
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
                                          if(viewModel.rewardNumber <=viewModel.rewardOrderModel!.totalPages!){
                                            viewModel.rewardNumber++;

                                            await allList(context,viewModel.rewardNumber,viewModel.rewardSize);
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
                          )
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
    await viewModel.getListReward(context, number, size);
    gridSource = RewardOrderGridSource(data: viewModel.rewardOrderModel!.data!,context: context);
    List<Map<String, bool>> gridMap = [
      {"details".tr(): true},
      {"usedDate".tr(): true},
      {"transactionCode".tr(): false},
      {"customerRewardOrderCode".tr(): false},
      {"orderDate".tr(): true},
      {"firstName".tr(): false},
      {"lastName".tr(): false},
      {"email".tr(): false},
      {"phone".tr(): false},
      {"status".tr(): false},
      {"statusDate".tr(): false},
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
