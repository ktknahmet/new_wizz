
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/NotifyVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class WizzNotify extends BaseStatefulPage {
  const WizzNotify(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _WizzNotifyState();
}

class _WizzNotifyState extends BaseStatefulPageState<WizzNotify> {

  ScrollController controller = ScrollController();
  NotifyVm viewModel = NotifyVm();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return Column(
      children: [
          ChangeNotifierProvider.value(
            value: viewModel,
            child: Consumer<NotifyVm>(
              builder: (context,value,_){
                if(viewModel.notify ==null){
                  return spinKit(context);
                }else if(viewModel.notify!.isEmpty){
                  return emptyView(context,"youDoNotHaveNotification");
                }else{
                  return SizedBox(
                    height: sizeWidth(context).height*0.80,
                    child:  RefreshIndicator(
                      onRefresh: getList,
                      color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      child: SizedBox(
                        height: sizeWidth(context).height*0.80,
                        child: RawScrollbar(
                          controller: controller,
                          thumbColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          thumbVisibility: true,
                          thickness: 1,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.notify!.length,
                            itemBuilder: (context,index){
                              return
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Card(
                                    color: ColorUtil().getColor(context, ColorEnums.background),
                                    shape: cardShape(context),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Row(
                                            children: [
                                              Icon(Icons.notifications_none_outlined,color:ColorUtil().getColor(context, ColorEnums.textTitleLight) ,),                                         const SizedBox(width: 4,),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        viewModel.notify![index]!.title!,
                                                        style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.appColor)),
                                                      ),
                                                      const SizedBox(height: 4,),
                                                      Text(
                                                        viewModel.notify![index]!.message!,
                                                        style: CustomTextStyle().regular14(ColorUtil().getColor(context, ColorEnums.appColor)),
                                                      ),
                                                      const SizedBox(height: 4,),
                                                      Text(
                                                        viewModel.notify![index]!.date!,
                                                        style: CustomTextStyle().regular10(ColorUtil().getColor(context, ColorEnums.appColor)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                      ],
                                    ),
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )
      ],
    );
  }

Future<void> getList() async{
  await viewModel.getNotifyList(context);
}
}
