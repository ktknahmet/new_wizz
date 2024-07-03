import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';

import '../../../constants/ColorsUtil.dart';
import '../../../utils/function/SharedPref.dart';
import '../../../utils/function/helper/DatepickerHelper.dart';
import '../../../utils/res/SharedUtils.dart';
import '../../../utils/res/StringUtils.dart';
import '../../../utils/style/ColorEnums.dart';
import '../../../widgets/WidgetExtension.dart';
import '../../adminVm/adminOverrideVm.dart';

class OverrideReportDist extends BaseStatefulPage {
  const OverrideReportDist(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _OverrideReportDistState();
}

class _OverrideReportDistState extends BaseStatefulPageState<OverrideReportDist> {
  AdminOverrideVm viewModel = AdminOverrideVm();
  ScrollController controller = ScrollController();
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  dynamic total=0.0;
  LoginUser? loginUser;

  @override
  void initState() {
    getInfo();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AdminOverrideVm>(
        builder: (context,value,_){
            if(viewModel.overrideUserList ==null){
              return spinKit(context);
            }else{
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: sizeWidth(context).width*0.4,
                          child: TextField(
                            style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                            cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            decoration: dateInputDecoration(context,"startDate"),
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
                            decoration: dateInputDecoration(context,"endDate"),
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
                          width: sizeWidth(context).width*0.3,
                          height: 50,
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
                        if(viewModel.overrideWinner !=null)
                              Container(
                                  decoration: containerDecoration(context),
                                  width: sizeWidth(context).width*0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("totalAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                                            ),
                                            Text("\$${moneyFormat(total)}",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                          ],
                                        ),
                                        const SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("total".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                            Text("${viewModel.overrideWinner!.length}",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                              ),

                      ],
                    ),
                    if(viewModel.overrideWinner !=null)
                      Column(
                        children: [
                          RawScrollbar(
                            controller: controller,
                            thumbVisibility: true,
                            thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            thickness: 1,
                            child: SizedBox(
                              width: sizeWidth(context).width,
                              height: justList(context, sizeWidth(context).height),
                              child: ListView.builder(
                                controller: controller,
                                itemCount: viewModel.overrideWinner!.length,
                                itemBuilder: (context,index){
                                  AdminOverrideWinner model = viewModel.overrideWinner![index];
                                  return Card(
                                    shape: cardShape(context),
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("overrideCalDate".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(mmDDYDate(model.calculatedDate),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("overrideAmount".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text("\$${model.overrideAmount ?? "0.00"}",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("puchases".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.organisationName ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("overrideType".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.overrideType ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("overrideReceiveBy".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.userName ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("product".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.productName ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                          const SizedBox(height: 4,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: sizeWidth(context).width*0.4,
                                                child:Text("enterSerialNumber".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                              ),
                                              Text(model.serialNumber ?? "",style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              );
            }

        },
      ),
    );
  }
  getInfo()async{
    loginUser ??= await getUser(context);
    await viewModel.getOverrideUser(context);
    List<int> loginId =[];
    for(int i=0;i<loginUser!.profiles!.length;i++){
      loginId.add(loginUser!.profiles![i].userId!);

    }
     await viewModel.checkOverrideUser(context,loginId);
  }
  getList()async{
    await showProgress(context, true);
    dynamic x = formatDateString(startDate.text,"MM-dd-yyyy","yyyy-MM-dd");
    dynamic y = formatDateString(endDate.text,"MM-dd-yyyy","yyyy-MM-dd");


    await viewModel.getOverrideWinner(context,x,y,viewModel.overrideUserId);

    await showProgress(context, false);
    total =0;
    for(int i=0;i<viewModel.overrideWinner!.length;i++){
      total +=double.parse(viewModel.overrideWinner![i].overrideAmount ?? "0.0");
    }
  }
}
