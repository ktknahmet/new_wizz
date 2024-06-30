import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/expenseModel/allExpenseModel.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ExpenseVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class AllExpense extends StatefulWidget {
  const AllExpense({super.key});

  @override
  State<StatefulWidget> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  ExpenseVm viewModel = ExpenseVm();
  ScrollController controller = ScrollController();
  List<String> expenses=[];
  @override
  void initState() {
    getList();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar: AddAppBar(
        name: "expense".tr(),
        func: ()  {
          Navigator.pushNamed(context, '/${PageName.addExpense}');
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ChangeNotifierProvider.value(
                value: viewModel,
                child: Consumer<ExpenseVm>(
                  builder: (context,value,_){
                    if(viewModel.allExpense == null){
                      return spinKit(context);
                    }else if(viewModel.allExpense!.isNotEmpty){
                      return Column(
                        children: [
                          Container(
                            decoration: containerDecoration(context),
                            width: sizeWidth(context).width,
                            height:45,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                               isExpanded:true,
                                dropdownColor: ColorUtil().getColor(context, ColorEnums.background),

                                underline: const SizedBox(),
                                hint: Text("all".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                                value: viewModel.expenses,
                                onChanged: (newValue) async{

                                  viewModel.setExpenses(newValue!);
                                  viewModel.setTotal(viewModel.allExpense!,viewModel.expenses);
                                },
                                items: expenses.map((value) {
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
                          const SizedBox(height: 8,),
                          Text("${context.tr("totalCoast")} \$${moneyFormat(viewModel.total)}", style: CustomTextStyle().bold18(ColorUtil().getColor(context, ColorEnums.textTitleLight))),

                          const SizedBox(height: 8,),
                          SizedBox(
                            height: justList(context,sizeWidth(context).height)-100,
                            child: RefreshIndicator(
                              onRefresh: getList,
                              color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                              child: RawScrollbar(
                                thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                                thumbVisibility: true,
                                thickness: 1,
                                trackVisibility: true,
                                controller: controller,
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount: viewModel.expenseDetails(viewModel.allExpense!,viewModel.expenses).length,
                                  itemBuilder: (context,index){
                                    AllExpenseModel item = viewModel.expenseDetails(viewModel.allExpense!,viewModel.expenses)[index];
                                    return Card(
                                      shape: cardShape(context),
                                      color: ColorUtil().getColor(context, ColorEnums.background),
                                      elevation:2 ,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (item.documentPath !=null) GestureDetector(
                                              onTap:(){
                                                showPhoto(context, item.documentPath!);
                                              },
                                              child: ClipOval(
                                                child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(16),
                                                    // Image radius
                                                    child: FadeInImage.assetNetwork(
                                                      placeholder: 'assets/loading.gif',
                                                      image: item.documentPath!,
                                                      fit: BoxFit.cover,
                                                    )
                                                ),
                                              ),
                                            ) else ClipOval(
                                                child: Image.asset(
                                                  "assets/uploadPhoto.webp", height: 32,)
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.expenseName!,style: CustomTextStyle().bold16(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    Text(mmDDYDate(item.expenseDate!.toString()),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                    Text("Cost: \$ ${item.expenseNetPrice ?? "0"}",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),

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
                          ),
                        ],
                      );
                    }else{
                      return Container();
                    }
                  },
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
                          SizedBox(
                            width: sizeWidth(context).width*0.40,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.addExpense}');
                              },
                              style: elevatedButtonStyle(context),
                              child: Text("addExpense".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          ),
                          SizedBox(
                            width: sizeWidth(context).width*0.40,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/${PageName.expenseReport}');

                              },
                              style: elevatedButtonStyle(context),
                              child: Text("expenseReport".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void>getList() async{
    await viewModel.getExpense(context);
    if(viewModel.allExpense !=null){
      viewModel.setTotal(viewModel.allExpense!,viewModel.expenses);
      if(expenses.isEmpty){
        for(int i=0;i<viewModel.allExpense!.length;i++){
          if(expenses.contains(viewModel.allExpense![i].expenseName) == false)
            expenses.add(viewModel.allExpense![i].expenseName!);
        }
        expenses.add("All");
      }

    }
  }
}
