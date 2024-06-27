import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/function/providerFunc/AppStateNotifier.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class AdminSettings extends BaseStatefulPage {
  const AdminSettings(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends BaseStatefulPageState<AdminSettings> {
  String? selectedLanguage;
  AppStateNotifier view = AppStateNotifier();
  @override
  void initState() {
    view.getModel(context);
    view.setTheme(context);
    super.initState();
  }
  @override
  Widget design() {

    return ChangeNotifierProvider.value(
      value: view,
      child: Consumer<AppStateNotifier>(
        builder: (context,value,_){
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Card(
                  color: ColorUtil().getColor(context, ColorEnums.background),
                  shape: cardShape(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("changeLanguage".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButton<String>(
                              dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                              underline: const SizedBox(),
                              hint: Row(

                                children: [
                                  Text("language".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  const SizedBox(width: 8,),
                                  Image.asset("assets/flag/${context.tr("photoPath")}",height: 24,)
                                ],
                              ),
                              value: selectedLanguage,
                              onChanged: (newView) async{
                                view.setLanguage(context, newView!);
                              },
                              items: modelList.map((model) {
                                return DropdownMenuItem<String>(
                                  value: model.value,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(model.key,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                                      const SizedBox(width: 8,),
                                      Image.asset("assets/flag/${model.imagePath}",height: 24,)
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: 50,
                child:  Card(
                  elevation: 2,
                  color: ColorUtil().getColor(context, ColorEnums.background),
                    shape: cardShape(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("darkTheme".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                          Switch(
                            activeTrackColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                            activeColor: AppColors.white,
                            value: view.darkMode,
                            onChanged: (newView) async{
                              view.updateTheme(newView);
                              Phoenix.rebirth(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            ],
          );
        },
      ),
    );
  }
}
