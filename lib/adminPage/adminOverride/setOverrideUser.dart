import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserDelete.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideUserList.dart';
import 'package:wizzsales/adminPage/adminVm/adminOverrideVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class SetOverrideUser extends BaseStatefulPage {
  const SetOverrideUser(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _SetOverrideUserState();
}

class _SetOverrideUserState extends BaseStatefulPageState<SetOverrideUser> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminOverrideVm>(
        builder: (context,value,_){
          if(viewModel.allUsers == null || viewModel.overrideUserList == null){
            return spinKit(context);
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: sizeWidth(context).width,
                    height: 40,
                    child: TextField(
                      onChanged: (value){
                        viewModel.setQuery(value);
                        viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query);
                      },
                      decoration: searchTextDesign(context, "search"),
                      cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                      style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: getList,
                    color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                    child: RawScrollbar(
                      controller: controller,
                      thumbVisibility: true,
                      thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      thickness: 1,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          controller: controller,
                          itemCount: viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query).length,
                          itemBuilder: (context,index){
                            OverrideUserList model = viewModel.searchUserList(viewModel.overrideUserList!,viewModel.query)[index];
                            return  Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(context, ColorEnums.background),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                                        const SizedBox(width: 8,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(model.name ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              const SizedBox(height: 4,),
                                              Text(model.menuroles ?? "",style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: ()async{
                                            bool check = await areYouSure(context);
                                            if(check){
                                              await deleteUser(model.id!);
                                            }
                                          },
                                          style: elevatedButtonStyle(context),
                                          child:Text("delete".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,top: 8),
                    child: SizedBox(
                      width: sizeWidth(context).width*0.8,
                      child: ElevatedButton(
                        onPressed: ()async{
                          if(viewModel.allUsers!.isNotEmpty){

                            selectUserList(context,viewModel);
                          }else{
                            snackBarDesign(context, StringUtil.warning, "userListEmpty".tr());
                          }
                        },
                        style: elevatedButtonStyle(context),
                        child:Text("add".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
  Future<void> getList()async{
    await viewModel.getAllUser(context);
    await viewModel.getOverrideUser(context);
  }
  Future<void> deleteUser(int id)async{
    OverrideUserDelete overrideUserDelete = OverrideUserDelete(userId:id);

    await viewModel.deleteOverrideUser(context,overrideUserDelete);
  }
}
