
// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/expenseModel/expenseTypes.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/function/helper/PhotoHelper.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ExpenseVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AddExpense extends BaseStatefulPage {
  const AddExpense(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AddExpenseState();
}

class _AddExpenseState extends BaseStatefulPageState<AddExpense> {
  ExpenseVm viewModel = ExpenseVm();
  Map<String, dynamic> photoMap = {};
  LoginUser? loginUser;
  TextEditingController totalPrice = TextEditingController();
  TextEditingController netPrice = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController startMile=TextEditingController();
  TextEditingController endMile = TextEditingController();
  @override
  void initState() {
    getTypes();
    super.initState();
  }
  @override
  Widget design(){
    return SingleChildScrollView(
      child: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<ExpenseVm>(
            builder: (context,value,_){
              if(viewModel.expenseType == null){
                return spinKit(context);
              }else{
                return
                  Column(
                    children: [
                      SizedBox(
                          width: sizeWidth(context).width * 0.25,
                          height: sizeWidth(context).height * 0.12,
                          child:viewModel.selectImage != null ?
                          ClipOval(
                              child: Image.file(
                                viewModel.selectImage!, fit: BoxFit.fill, height: 96,)
                          ) :  ClipOval(
                              child: Image.asset(
                                "assets/slip.png", height: 64,)
                          )
                      ),
                      const SizedBox(height: 8,),
                      ElevatedButton.icon(
                        style: elevatedButtonStyle(context),
                        onPressed: () async {
                          photoMap = await PhotoHelper.getPhoto(context);
                          if (photoMap["image"] != null) {
                            setState(() {
                              viewModel.selectImage = photoMap["image"];
                            });
                          }
                        },
                        icon: Icon(Icons.photo_camera, size: 24.0,
                          color: ColorUtil().getColor(
                              context, ColorEnums.wizzColor),),
                        label: Text("uploadReceipt".tr(),
                          style: CustomTextStyle().semiBold16(
                              ColorUtil().getColor(context,
                                  ColorEnums.textDefaultLight)),), // <-- Text
                      ),
                      const SizedBox(height: 16,),
                      Visibility(
                          visible: viewModel.selectImage == null ? false : true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      viewModel.deleteImage();
                                    });
                                  },
                                  style: elevatedButtonStyle(context),
                                  child: Text("delete".tr(),
                                    style: CustomTextStyle().semiBold12(
                                        ColorUtil().getColor(context,
                                            ColorEnums.textTitleLight)),)
                              ),
                            ],
                          )
                      ),
                      Container(
                        decoration: containerDecoration(context),
                        width: sizeWidth(context).width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:DropdownButton<ExpenseType>(
                            isExpanded:true,
                            dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                            underline: const SizedBox(),
                            hint: Text("selectExpenseType".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                            value: viewModel.eType != null && viewModel.expenseType!.any((type) => type.expenseTypeId! == viewModel.eType)
                                ? viewModel.expenseType!.firstWhere((element) => element.expenseTypeId == viewModel.eType)
                                : null,
                            onChanged: (ExpenseType? newValue) {
                              viewModel.setExpenseType(newValue!.expenseTypeId!);
                              viewModel.setExpenseName(newValue.expenseName!);


                            },
                            items: viewModel.expenseType!.map<DropdownMenuItem<ExpenseType>>((ExpenseType doc) {
                              return DropdownMenuItem<ExpenseType>(
                                value: doc,
                                child: Text(doc.expenseName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: viewModel.eType==4 ? true : false,
                        child: Column(
                          children: [
                            const SizedBox(height: 8,),
                            accountNumber(context, "startMileage", startMile),
                            const SizedBox(height: 8,),
                            accountNumber(context, "endMileage", endMile),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8,),
                      accountNumber(context, "totalPrice", totalPrice),
                      /*const SizedBox(height:8),
                      accountNumber(context, "netPrice", netPrice),*/
                      const SizedBox(height:8),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("salesId".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),)
                      ),
                      const SizedBox(height: 4,),
                      TextField(
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
                        cursorColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        decoration: dateInputDecoration(context,"salesId"),
                        controller: viewModel.saleId,
                        readOnly: true,
                        onTap: () async{
                          if(viewModel.expenseSale ==null){
                            await viewModel.getExpenseSale(context);
                          }

                          if(viewModel.expenseSale!.isNotEmpty){
                            showSaleList(context,viewModel);
                          }else{
                            snackBarDesign(context, StringUtil.warning, "notContactList".tr());
                          }
                        },
                      ),
                      const SizedBox(height:8),
                      accountCreate(context, "note", note),

                      const SizedBox(height: 16,),
                      SizedBox(
                        width: sizeWidth(context).width*0.80,
                        child: ElevatedButton(
                          onPressed: ()async{
                            await post();
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("save".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }


  getTypes()async{
    await viewModel.getExpenseType(context);
  }
  post()async{
    clearFocus(context);
    SharedPref pref = SharedPref();
    loginUser ??= await getUser(context);
    int index = await pref.getInt(context, SharedUtils.profileIndex);
    int userId = loginUser!.profiles![index].id!;

    if(viewModel.selectImage ==null){
      snackBarDesign(context, StringUtil.error, "youMustUploadReceipt".tr());
      return;
    }
    if(totalPrice.text.isNotEmpty  && viewModel.eType !=null){

      await viewModel.postExpense(context, viewModel.eType!, userId,viewModel.id, double.tryParse(netPrice.text.isNotEmpty  ? netPrice.text:"0")!,
          double.tryParse(totalPrice.text)!, formatDate(DateTime.now().toString()),
          viewModel.selectImage!,int.tryParse(startMile.text),int.tryParse(endMile.text)
          );
      if(viewModel.response!.response.statusCode == 200){
        snackBarDesign(context, StringUtil.success, "addedExpense".tr());
        setState(() {
          viewModel.deleteImage();
          totalPrice.clear();
          netPrice.clear();
          note.clear();
          viewModel.setExpenseType(null);
        });
      }else{
        snackBarDesign(context, StringUtil.error, viewModel.response!.response.statusMessage!);
      }
    }else{
      snackBarDesign(context, StringUtil.error, "allAreaMustRequired".tr());
    }
  }
}
