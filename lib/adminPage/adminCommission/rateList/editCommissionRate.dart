import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/commissionList.dart';
import 'package:wizzsales/adminPage/adminModel/commissionModel/updateComRate.dart';
import 'package:wizzsales/adminPage/adminVm/commissionVm.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class EditCommissionRate extends StatefulWidget {
  final Detail detail;
  const EditCommissionRate(this.detail,{super.key});

  @override
  State<EditCommissionRate> createState() => _EditCommissionRateState();
}

class _EditCommissionRateState extends State<EditCommissionRate> {
  CommissionVm viewModel = CommissionVm();
  TextEditingController startAmount = TextEditingController();
  TextEditingController endAmount = TextEditingController();
  TextEditingController commission = TextEditingController();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
      appBar: DefaultAppBar(name: "editCommissionRate".tr(),),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<CommissionVm>(
          builder: (context,value,_){
            return SizedBox(
              width: sizeWidth(context).width,
              height: sizeWidth(context).height,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    accountNumber(context, "minAmount", startAmount),
                    const SizedBox(height: 8,),
                    accountNumber(context, "maxAmount", endAmount),
                    const SizedBox(height: 8,),
                    viewModel.comtype==0 ?
                    accountNumber(context, "comAmount", commission)
                        :accountNumber(context, "percentageNetSale", commission),
                    const SizedBox(height: 8,),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:SizedBox(
                          width: sizeWidth(context).width*0.80,
                          child: ElevatedButton(
                            onPressed: ()async{
                              await post();
                            },
                            style: elevatedButtonStyle(context),
                            child: Text("update".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ) ,
            );
          },
        ),
      )
    );
  }
  getList(){
    startAmount.text = widget.detail.amountLevel1 ?? "0";
    endAmount.text = widget.detail.amountLevel2 ?? "0";
    if(widget.detail.commAmount !=null){
      viewModel.setComType(0);
      commission.text = widget.detail.commAmount!;
    }else{
      viewModel.setComType(1);
      commission.text = widget.detail.comPercentage ?? "";
    }
  }
  post()async{
    double startNumber = double.parse(startAmount.text);
    double endNumber = double.parse(endAmount.text);
    double comNumber = double.parse(commission.text);

    int parsedStart = startNumber.toInt();
    int parsedEnd = endNumber.toInt();
    int parsedCom = comNumber.toInt();

    UpdateComRate postModel = UpdateComRate(
      calcPoolDetId: widget.detail.calcPoolDetId,
      amountLevel1: parsedStart,
      amountLevel2: parsedEnd,
      commType: widget.detail.comType,
      commAmount: viewModel.comtype==0 ? parsedCom : null,
      commPercentage: viewModel.comtype==1 ? parsedCom : null
    );
    await viewModel.updateCom(context, postModel);
  }
}
