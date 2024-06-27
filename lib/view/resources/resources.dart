import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/resources/resourceTabBar.dart';
import 'package:wizzsales/viewModel/ResourceVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';


class Resources extends BaseStatefulPage {

     const Resources(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _ResourcesState();
}

class _ResourcesState extends BaseStatefulPageState<Resources> {
  ResourceVm viewModel = ResourceVm();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design(){
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ResourceVm>(
        builder: (context,value,_){
          if(viewModel.resource == null){
            return spinKit(context);
          }else if(viewModel.allResourcesLists.isEmpty){
            return Container();
          }else{
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onChanged: (value){
                            viewModel.setQuery(value);
              
                            viewModel.searchResources(viewModel.allResourceFile,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizeWidth(context).height*0.80,
                      child: RawScrollbar(
                        thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                        thumbVisibility: true,
                        thickness: 1,
                        trackVisibility: true,
                        controller: controller,
                        child:viewModel.query.isEmpty ? RefreshIndicator(
                          onRefresh: getList,
                          color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                          child: ListView.builder(
                            controller: controller,
                            itemCount: viewModel.names.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ResourceTabBar(viewModel.names[index], viewModel.allResourcesLists[viewModel.names[index]])));
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: Card(
                                        shape: cardShape(context),
                                        color: ColorUtil().getColor(context, ColorEnums.background),
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Text(viewModel.names[index], style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                              Icon(Icons.arrow_forward_outlined, color: ColorUtil().getColor(context, ColorEnums.textDefaultLight),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                  ],
                                ),
                              );
                            },
                          ),
                        ) : ListView.builder(
                          itemCount: viewModel.searchResources(viewModel.allResourceFile,viewModel.query).length,
                          itemBuilder: (context,index){
                            Resource resource = viewModel.searchResources(viewModel.allResourceFile,viewModel.query)[index];
                            return GestureDetector(
                              onTap: (){
                                clickResource(context,resource);
                              },
                              child: Card(
                                shape: cardShape(context),
                                color: ColorUtil().getColor(context, ColorEnums.background),
                                elevation: 2 ,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      getResourceWidget(context,resource),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( resource.title!,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
  Future<void>getList()async{
   await viewModel.getAllResource(context);
  }

}
