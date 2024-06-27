 import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/register/DistributorSubType.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Extension.dart';

showCustomDialog(BuildContext context, Widget bodyWidget) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      builder: (mainContext) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            padding: MediaQuery.of(mainContext).viewInsets,
            decoration: containerDecoration(context),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 8,),
                  Center(
                    child: Container(
                      width: 64,
                      height: 4,
                      decoration:containerDecoration(context),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    child: bodyWidget,
                  )
                ],
              ),
            ),
          )
      ));
}
 showPickerDialog(BuildContext context,List<DistributorSubType> list, String type,Widget bodyWidget) {
   showModalBottomSheet(
       isScrollControlled: true,
       context: context,
       useRootNavigator: true,
       backgroundColor: Colors.transparent,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(32.0),
       ),
       builder: (mainContext) => BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
           child: Container(
             padding: MediaQuery.of(mainContext).viewInsets,
             decoration: BoxDecoration(
               color: ColorUtil().getColor(context, ColorEnums.whitePureLight),
               borderRadius: const BorderRadius.only(
                   topLeft: Radius.circular(32),
                   topRight: Radius.circular(32)),
             ),
             child: SingleChildScrollView(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                   const SizedBox(height: 8,),
                   Center(
                     child: Container(
                       width: 64,
                       height: 4,
                       decoration: BoxDecoration(
                         color: ColorUtil().getColor(context, ColorEnums.borderDefaultLight),
                         borderRadius: BorderRadius.circular(2.0),
                       ),
                     ),
                   ),
                   const SizedBox(height: 40,),
                   Container(
                     margin: const EdgeInsets.only(bottom: 35),
                     child: bodyWidget,
                   )
                 ],
               ),
             ),
           )
       ));
 }


