import 'package:flutter/material.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';


 class BaseStatefulPage extends StatefulWidget{
  final String? appBarName;
  const BaseStatefulPage(this.appBarName,{super.key});

  @override
  State<StatefulWidget> createState() => BaseStatefulPageState<BaseStatefulPage>();


}
class BaseStatefulPageState <T extends StatefulWidget> extends State<BaseStatefulPage> {


  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: widget.appBarName !=null ? DefaultAppBar(name: widget.appBarName!) : null,
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: design(),
        ),
      ),

    );
  }
  Widget design(){
    return const Column(
      children: [
        Text("ahmet",style: TextStyle(color: Colors.yellow),)
      ],
    );
  }
}
