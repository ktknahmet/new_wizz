import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminReport/pages/cList/dataGrid.dart';
import 'package:wizzsales/adminPage/adminVm/adminVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/ReportAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import '../../../../constants/AppColors.dart';
import "package:syncfusion_flutter_core/theme.dart" show SfDataGridTheme, SfDataGridThemeData;

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<StatefulWidget> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  AdminVm viewModel = AdminVm();
  late ClistGridSource gridSource;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    allList(context,viewModel.currentNumber,viewModel.currentSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: ReportAppBar(
        name: "customerList".tr(),
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
                if(viewModel.cListModel == null){
                  return spinKit(context);
                }else{
                  return Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${context.tr("totalCustomerList")} : ${viewModel.cListModel!.totalRecords!}",style: CustomTextStyle().bold14(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                            DropdownButton<int>(
                              dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                              underline: const SizedBox(),
                              value: viewModel.currentSize, // Varsayılan olarak seçilen değer
                              onChanged: (int? newValue) {
                                viewModel.setCurrentSize(newValue!);

                                allList(context,viewModel.currentNumber,viewModel.currentSize);
                              },
                              items: <int>[10, 20, 30, 50, 100,viewModel.cListModel!.totalRecords!].map<DropdownMenuItem<int>>((int value) {
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
                        onRefresh:()=>allList(context,viewModel.currentNumber,viewModel.currentSize),
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
                              //allowPullToRefresh: true,
                              allowFiltering: true,
                              allowEditing: true,
                              allowMultiColumnSorting:true,
                              editingGestureType: EditingGestureType.tap,
                              navigationMode: GridNavigationMode.cell,
                              selectionMode: SelectionMode.single,
                              onCellTap: (DataGridCellTapDetails details) {
                                var columnName = details.column.columnName;
                                var rowData = details.rowColumnIndex.rowIndex -1;

                                if(columnName=="profile".tr()){
                                  if(viewModel.cListModel!.data![rowData].avatar !=null){
                                    showPhoto(context, viewModel.cListModel!.data![rowData].avatar!);
                                  }
                                }
                              },

                              columns: <GridColumn>[
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
                                    visible:  getStatusVisibility("status".tr(), viewModel.gridMap),
                                    columnName: 'status'.tr(),
                                    label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'status'.tr(),
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
                                      if(viewModel.currentNumber >1){
                                        viewModel.currentNumber--;
                                        print("page number: $viewModel.currentNumber");
                                        await allList(context,viewModel.currentNumber,viewModel.currentSize);
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
                                      itemCount: viewModel.cListModel!.totalPages!,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            viewModel.setCurrentNumber(index+1);
                                            await allList(context,viewModel.currentNumber,viewModel.currentSize);
                                          },
                                          child: Row(
                                            children: [
                                              viewModel.currentNumber == index + 1
                                                  ? Container(
                                                height: sizeWidth(context).height * 0.048,
                                                width: sizeWidth(context).width * 0.088,
                                                color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(viewModel.currentNumber.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
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
                                      if(viewModel.currentNumber <=viewModel.cListModel!.totalPages!){
                                        viewModel.currentNumber++;
                                        print("page number: $viewModel.currentNumber");
                                        await allList(context,viewModel.currentNumber,viewModel.currentSize);
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
    await viewModel.getList(context, number, size);
    gridSource = ClistGridSource(data: viewModel.cListModel!.data!,context: context);
    List<Map<String, bool>> gridMap = [
      {"profile".tr(): true},
      {"firstName".tr(): true},
      {"lastName".tr(): false},
      {"email".tr(): false},
      {"phone".tr(): true},
      {"birthDay".tr(): true},
      {"status".tr(): false},
      {"product".tr(): false}
    ];
    for(int i=0;i<gridMap.length;i++){
      viewModel.addGridMap(gridMap[i]);
    }
  }

}
