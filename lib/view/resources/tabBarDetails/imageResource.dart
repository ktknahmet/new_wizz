import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/utils/function/providerFunc/ResourceProv.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';

class ImageResource extends StatefulWidget {
  final List<Resource>? list;
  const ImageResource(this.list,{super.key});

  @override
  State<ImageResource> createState() => _ImageResourceState();
}

class _ImageResourceState extends State<ImageResource> {
  ResourceProvider viewModel = ResourceProvider();
  ScrollController controller = ScrollController();
  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child:
     ChangeNotifierProvider.value(
       value: viewModel,
       child: Consumer<ResourceProvider>(
         builder: (context,value,_){
           return SingleChildScrollView(
             child: Column(
               children: [
                 if(widget.list!.isNotEmpty)
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SizedBox(
                       height: 40,
                       child: TextField(
                         onChanged: (value){
                           viewModel.setQuery(value);

                           viewModel.searchResources(widget.list!,viewModel.query);
                         },
                         decoration: searchTextDesign(context, "search"),
                         cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                         style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                       ),
                     ),
                   ),
                 SizedBox(
                   height: sizeWidth(context).height*0.60,
                   child: RawScrollbar(
                     thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                     thumbVisibility: true,
                     thickness: 1,
                     trackVisibility: true,
                     controller: controller,
                     child:ListView.builder(
                       controller: controller,
                       itemCount: viewModel.searchResources(widget.list!,viewModel.query).length,
                       itemBuilder: (context,index){
                         Resource resource = viewModel.searchResources(widget.list!,viewModel.query)[index];
                         return GestureDetector(
                             onTap: (){
                               showPhoto(context, resource.file!);
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
                                     ClipOval(
                                       child: SizedBox.fromSize(
                                           size: const Size.fromRadius(16),
                                           // Image radius
                                           child: FadeInImage.assetNetwork(
                                             placeholder: 'assets/loading.gif',
                                             image: resource.file!,
                                             fit: BoxFit.cover,
                                           )
                                       ),
                                     ),
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
                             )
                         );
                       },
                     ),
                   ),
             
                 ),
               ],
             ),
           );
         },
       ),
     )
      

    );
  }

}
