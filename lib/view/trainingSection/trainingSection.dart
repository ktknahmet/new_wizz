// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/contactReferral/getReferral.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/function/providerFunc/ContactProvider.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class TrainingSection extends BaseStatefulPage {
  const TrainingSection(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _TrainingSectionState();
}

class _TrainingSectionState extends BaseStatefulPageState<TrainingSection> {
  ContactProvider viewModel = ContactProvider();
  ScrollController controller = ScrollController();
  ScrollController listController = ScrollController();
 @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ContactProvider>(
        builder: (context,value,_){
          if(viewModel.isChecked == null){
            return spinKit(context);
          }else{
            return Column(
              children: [
                ElevatedButton(
                  onPressed: ()async{

                    if(viewModel.contactModel.isNotEmpty){
                      showContactList(context,viewModel);
                    }else{
                      await viewModel.getContact(context);

                    }

                  },
                  style: elevatedButtonStyle(context),
                  child: Text("addContactFromList".tr(),style: CustomTextStyle().semiBold10(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                ),
                  if(viewModel.referral.isNotEmpty)
                  SizedBox(
                    height: sizeWidth(context).height*0.70,
                    child: RawScrollbar(
                      thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: listController,
                      child: RefreshIndicator(
                        onRefresh: getList,
                        color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                        child: ListView.builder(
                          controller: listController,
                          itemCount:  viewModel.referral.length,
                          itemBuilder: (context,index){
                            GetReferral model =viewModel.referral[index];
                            return Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                           Icon(Icons.person_2_outlined,color: ColorUtil().getColor(context, ColorEnums.textTitleLight),),

                                          Expanded(
                                            child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${model.referralFirstName} ${model.referralLastName ?? ""}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                                  const SizedBox(height: 8,),
                                                  Text(model.referralPhone ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                ],
                                              ),
                                            ),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: ()async{
                                                },
                                                child:  Text("sendSms".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: elevatedButtonStyle(context),
                              onPressed: () {
                                Navigator.pop(context);

                              },
                              child:  Text("cancel".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                            ElevatedButton(
                              style: elevatedButtonStyle(context),
                              onPressed: () {
                                Navigator.pushNamed(context, '/${PageName.addContact}');
                              },
                              child:  Text("addContact".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],

            );
          }
        },
      ),
    );
  }


  Future<void> getList() async{
    await viewModel.getReferralList(context);
    await viewModel.checkContactPermission(context);

  }
}
