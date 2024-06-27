import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminReport/pages/referralList/referralGridSource.dart';
import 'package:wizzsales/adminPage/adminVm/adminVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../../constants/colorsUtil.dart';

class ReferralList extends StatefulWidget {
  const ReferralList({super.key});

  @override
  State<ReferralList> createState() => _ReferralListState();
}

class _ReferralListState extends State<ReferralList> {
  AdminVm viewModel = AdminVm();
  late ReferralGridSource gridSource;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  DataGridController dataGridController = DataGridController();
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    allList(context,viewModel.referralNumber,viewModel.rewardSize);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: ReportAppBar(
        name: "referralList".tr(),
        func: () async {
          await downloadExcel(context, _key);
        },
      ),
      body:SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  ChangeNotifierProvider.value(
                  value: viewModel,
                  child: Consumer<AdminVm>(
                    builder: (context,view,_){
                      if(viewModel.referralModel == null){
                        return spinKit(context);
                      }else{
                        return Column(
                          children: [
                             Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${context.tr("total")} : ${viewModel.referralModel!.totalRecords!}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                  DropdownButton<int>(
                                    dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                                    underline: const SizedBox(),
                                    value: viewModel.referralSize,
                                    onChanged: (int? newValue) {
                                      viewModel.setReferralSize(newValue!);
                                      allList(context,viewModel.referralNumber,viewModel.referralSize);
                                    },
                                    items: <int>[5, 10, 20, 30, 50, 100,viewModel.referralModel!.totalRecords!].map<DropdownMenuItem<int>>((int value) {
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
                              onRefresh:()=>allList(context,viewModel.referralNumber,viewModel.referralSize),
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
                                    key: _key,
                                    allowEditing: true,
                                    editingGestureType: EditingGestureType.tap,
                                    navigationMode: GridNavigationMode.cell,
                                    selectionMode: SelectionMode.single,
                                    columnWidthMode: ColumnWidthMode.auto,
                                    allowFiltering: true,
                                    onCellTap: (DataGridCellTapDetails details) {

                                      var columnName = details.column.columnName;
                                        if(columnName=="details".tr()){
                                          var rowData = details.rowColumnIndex.rowIndex -1;

                                          print("veriler :${viewModel.referralModel!.data![rowData].id}  -- ${viewModel.referralModel!.data![rowData].firstName}");
                                          referralDetails(context,viewModel.referralModel!.data![rowData].customer!,viewModel.referralModel!.data![rowData].smsLogs!);
                                        }
                                      print("tıklanılan veri :$columnName");
            
                                    },
                                    columns: <GridColumn>[
            
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
                                          visible:  getStatusVisibility("createdDate".tr(), viewModel.gridMap),
                                          columnName: 'createdDate'.tr(),
                                          label: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'createdDate'.tr(),
                                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
            
                                              ))),
                                      GridColumn(
                                          visible:  getStatusVisibility("referralCode".tr(), viewModel.gridMap),
                                          columnName: 'referralCode'.tr(),
                                          label: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'referralCode'.tr(),
                                                style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
            
                                              ))),
                                      GridColumn(
                                          visible:  getStatusVisibility("details".tr(), viewModel.gridMap),
                                          columnName: 'details'.tr(),
                                          label: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'details'.tr(),
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
                                            if(viewModel.referralNumber >1){
                                              viewModel.referralNumber--;
                                              await allList(context,viewModel.referralNumber,viewModel.referralSize);
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
                                            itemCount: viewModel.referralModel!.totalPages!,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  viewModel.setReferralNumber(index+1);
                                                  print("number :${viewModel.referralNumber}");
                                                  await allList(context,viewModel.referralNumber,viewModel.referralSize);
                                                },
                                                child: Row(
                                                  children: [
                                                    viewModel.referralNumber == index + 1
                                                        ? Container(
                                                      height: sizeWidth(context).height * 0.048,
                                                      width: sizeWidth(context).width * 0.088,
                                                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(viewModel.referralNumber.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
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
                                            if(viewModel.referralNumber <=viewModel.referralModel!.totalPages!){
                                              viewModel.referralNumber++;
                                              await allList(context,viewModel.referralNumber,viewModel.referralSize);
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
    await viewModel.getListReferral(context, number, size);
    gridSource = ReferralGridSource(data: viewModel.referralModel!.data!,context: context);
    List<Map<String, bool>> gridMap = [
      {"firstName".tr(): true},
      {"lastName".tr(): false},
      {"email".tr(): false},
      {"phone".tr(): true},
      {"createdDate".tr(): true},
      {"referralCode".tr(): false},
      {"details".tr(): false}
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }
}
