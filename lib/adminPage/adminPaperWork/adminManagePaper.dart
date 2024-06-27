import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminContractList.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ContractVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class AdminManagePaper extends BaseStatefulPage {
  const AdminManagePaper(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminManagePaperState();
}

class _AdminManagePaperState extends BaseStatefulPageState<AdminManagePaper> {
  ScrollController controller = ScrollController();
  ContractVm viewModel = ContractVm();
  List<String> distName=[];
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ContractVm>(
        builder: (context,value,_){
          if(viewModel.getAdminContract==null){
            return spinKit(context);
          }else{
            return  Column(
                children: [
                  Container(
                    decoration: containerDecoration(context),
                    width: sizeWidth(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                        hint: Text("all".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                        underline: const SizedBox(),
                        value: viewModel.selectedDist,
                        onChanged: (newValue) async{
                          viewModel.setDist(newValue!);
                        },
                        items: distName.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(value,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  RawScrollbar(
                    thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    thumbVisibility: true,
                    thickness: 1,
                    trackVisibility: true,
                    controller: controller,
                    child: SizedBox(
                      height: justList(context, sizeWidth(context).height),
                      child: ListView.builder(
                        itemCount:viewModel.expenseDetails(viewModel.getAdminContract!,viewModel.selectedDist).length,
                        controller: controller,
                        itemBuilder: (context, index) {
                          AdminContractList model = viewModel.expenseDetails(viewModel.getAdminContract!,viewModel.selectedDist)[index];
                          return Card(
                            shape: cardShape(context),
                            elevation: 2,
                            color: ColorUtil().getColor(
                                context, ColorEnums.background),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: ()  {
                                        Navigator.pushNamed(context, '/${PageName.pdfPage}',
                                          arguments: {'title': model.contractName!, 'url': model.contractPath!},);

                                      },
                                      child: Icon(Icons.picture_as_pdf_outlined, color: ColorUtil().getColor(context, ColorEnums.wizzColor))
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(model.contractName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                          const SizedBox(height: 2,),
                                          Divider(
                                            color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                          ),
                                          const SizedBox(height: 2,),
                                          Text(model.distributorName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),


                                        ],
                                      ),
                                    ),
                                  ),
                                ],

                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  SizedBox(
                    width: sizeWidth(context).width * 0.80,
                    child: ElevatedButton(
                      onPressed: () async{
                        await getOrganisation();

                      },
                      style: elevatedButtonStyle(context),
                      child: Text("updateDocument".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(
                          context, ColorEnums.textTitleLight)),),

                    ),
                  ),
                ],

            );
          }
        },
      ),
    );
  }
  Future<void> getList()async{
    await viewModel.getAdminContractList(context);
    if(viewModel.getAdminContract !=null){
      for(int i=0;i<viewModel.getAdminContract!.length;i++){
        if(distName.contains(viewModel.getAdminContract![i].distributorName) == false) {
          distName.add(viewModel.getAdminContract![i].distributorName!);
        }
      }
    }
  }
  Future<void> getOrganisation()async{
    if(viewModel.organisations ==null || viewModel.organisations!.isEmpty){
      await viewModel.getOrganisations(context);
      if(viewModel.organisations!.isNotEmpty){
        showContractPostFile(context,viewModel);
      }
    }else{
      showContractPostFile(context,viewModel);
    }

  }
}
