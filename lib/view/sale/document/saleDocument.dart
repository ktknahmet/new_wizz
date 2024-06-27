import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/saleDocument/getSaleDocument.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/DefaultAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/view/sale/document/addDocument.dart';
import 'package:wizzsales/viewModel/SaleDocumentVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';

class SaleDocument extends StatefulWidget {
  final int saleId;
  const SaleDocument(this.saleId,{super.key});

  @override
  State<SaleDocument> createState() => _SaleDocumentState();
}

class _SaleDocumentState extends State<SaleDocument> {
  SaleDocumentVm viewModel = SaleDocumentVm();
  ScrollController controller = ScrollController();
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
      appBar: DefaultAppBar(name: "saleDocuments".tr(),),
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChangeNotifierProvider.value(
                  value: viewModel,
                  child: Consumer<SaleDocumentVm>(
                    builder: (context,value,_){
                      if(viewModel.allSaleDocument == null){
                        return spinKit(context);
                      }else{
                        return
                            SizedBox(
                              height: justList(context,sizeWidth(context).height),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: RawScrollbar(
                                      thumbColor:ColorUtil().getColor(context, ColorEnums.wizzColor) ,
                                      thumbVisibility: true,
                                      thickness: 1,
                                      trackVisibility: true,
                                      controller: controller,
                                      child: ListView.builder(
                                        controller: controller,
                                              itemCount: viewModel.allSaleDocument!.length,
                                              itemBuilder: (context,index){
                                                GetSaleDocument doc = viewModel.allSaleDocument![index];
                                                return Card(
                                                  shape: cardShape(context),
                                                  color: ColorUtil().getColor(context, ColorEnums.background),
                                                  elevation: 2 ,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap:(){
                                                           showPhoto(context, doc.documentPath!);
                                                           },
                                                          child: ClipOval(
                                                            child: SizedBox.fromSize(
                                                                size: const Size.fromRadius(16),
                                                                // Image radius
                                                                child: FadeInImage.assetNetwork(
                                                                  placeholder: 'assets/loading.gif',
                                                                  image: doc.documentPath!,
                                                                  fit: BoxFit.cover,
                                                                )
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(doc.typeName ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                                Text(doc.note ?? "",style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
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
                        );

                      }
                    },
                  ),
                ),

              SizedBox(
                width: sizeWidth(context).width*0.80,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>  AddDocument(widget.saleId)));

                  },
                  style: elevatedButtonStyle(context),
                  child: Text("addDocument".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  getList()async{
    await viewModel.allSaleDoc(context,widget.saleId);
  }
}
