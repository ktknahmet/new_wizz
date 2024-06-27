import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wizzsales/adminPage/adminContests/adminContestGrid.dart';
import 'package:wizzsales/adminPage/adminVm/adminContestVm.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import 'package:syncfusion_flutter_core/theme.dart' show SfDataGridTheme, SfDataGridThemeData;
class AdminContest extends BaseStatefulPage {
  const AdminContest(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminContestState();
}

class _AdminContestState extends BaseStatefulPageState<AdminContest> {
  AdminContestVm viewModel = AdminContestVm();

  late AdminContestGrid gridSource;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  DataGridController dataGridController = DataGridController();
  @override
  void initState() {
    getList(viewModel.currentPage);
    super.initState();
  }
  @override
  Widget design() {
    return SingleChildScrollView(
      child: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<AdminContestVm>(
          builder: (context,value,_){
            if(viewModel.adminContestModel ==null){
              return spinKit(context);
            }else if(viewModel.adminContestModel!.data!.isEmpty){
              return emptyView(context, "ahmet");
            }else{
              return Column(
                children: [
                  RefreshIndicator(
                    onRefresh:()=>getList(viewModel.currentPage),
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: SizedBox(
                      height: sizeWidth(context).height*0.75,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
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
                          onCellTap: (DataGridCellTapDetails details) {
                            var columnName = details.column.columnName;
                            var rowData = details.rowColumnIndex.rowIndex -1;
                            var tiklanilanVeri = gridSource
                                .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                                .getCells()[details.rowColumnIndex.columnIndex]
                                .value
                                .toString();
                            print("tıklanılan veri :$tiklanilanVeri");

                            print("column name :$columnName");
                            if(columnName=="profile".tr()){
                              if(viewModel.adminContestModel!.data![rowData].image !=null){
                                showPhoto(context, viewModel.adminContestModel!.data![rowData].image!);
                              }
                            }
                            if(columnName=="status".tr()){
                              if(viewModel.adminContestModel!.data![rowData].qualifications!.isNotEmpty){
                                contestsQualifications(context,viewModel.adminContestModel!.data![rowData].qualifications);
                              }
                            }
                            if(columnName=="edit".tr()){
                              //contest güncelleme kısmı
                            }
                          },
                          columns: <GridColumn>[
                            GridColumn(
                                columnWidthMode: ColumnWidthMode.fitByColumnName,
                                columnName: 'profile'.tr(),
                                label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'profile'.tr(),
                                      style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                    ))),
                            GridColumn(
                                columnName: 'contestName'.tr(),
                                label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'contestName'.tr(),
                                      style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),
                                    ))),
                            GridColumn(
                                columnName: 'startDate'.tr(),
                                label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'startDate'.tr(),
                                      style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                    ))),
                            GridColumn(
                                columnName: 'endDate'.tr(),
                                label: Container(

                                    alignment: Alignment.center,
                                    child: Text(
                                      'endDate'.tr(),
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
                                columnName: 'status'.tr(),
                                label: Container(

                                    alignment: Alignment.center,
                                    child: Text(
                                      'status'.tr(),
                                      style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                    ))),
                            GridColumn(
                                columnName: 'edit'.tr(),
                                label: Container(

                                    alignment: Alignment.center,
                                    child: Text(
                                      'edit'.tr(),
                                      style: CustomTextStyle().black12(ColorUtil().getColor(context, ColorEnums.wizzColor)),

                                    ))),


                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async{
                              if(viewModel.currentPage >1){
                                viewModel.currentPage--;
                                await getList(viewModel.currentPage);
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
                              itemCount: (viewModel.adminContestModel!.total! / viewModel.adminContestModel!.perPage!).ceil(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    viewModel.setCurrentPage(index+1);
                                    await getList(viewModel.currentPage);
                                  },
                                  child: Row(
                                    children: [
                                      viewModel.currentPage == index + 1
                                          ? Container(
                                        height: sizeWidth(context).height * 0.048,
                                        width: sizeWidth(context).width * 0.088,
                                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(viewModel.currentPage.toString(), style: CustomTextStyle().semiBold12(AppColors.white)),
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
                              if(viewModel.currentPage <=viewModel.adminContestModel!.total!){
                                viewModel.currentPage++;
                                await getList(viewModel.currentPage);
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
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
  Future<void> getList(int page) async{
    await viewModel.allContestList(context,page);
    gridSource = AdminContestGrid(data: viewModel.adminContestModel!.data!,context: context);
  }
}
