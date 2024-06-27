import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/adminPage/adminModel/contractModel/AdminSignature.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ContractVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously
class AdminPaperWork extends BaseStatefulPage {
  const AdminPaperWork(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _AdminPaperWorkState();
}

class _AdminPaperWorkState extends BaseStatefulPageState<AdminPaperWork> {
  GlobalKey<SfSignaturePadState> key = GlobalKey();
  ScrollController controller = ScrollController();
  ContractVm viewModel = ContractVm();
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ContractVm>(
        builder: (context,value,_){
          if(viewModel.getAdminSignature ==null){
            return spinKit(context);
          }else{
            return  SingleChildScrollView(
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onChanged: (value){
                            viewModel.setQuery(value);
              
                            viewModel.searchAdminSignature(viewModel.getAdminSignature!,viewModel.query);
                          },
                          decoration: searchTextDesign(context, "search"),
                          cursorColor:ColorUtil().getColor(context, ColorEnums.wizzColor),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                      ),
                    ),
                    RawScrollbar(
                      thumbColor: ColorUtil().getColor(
                          context, ColorEnums.wizzColor),
                      thumbVisibility: true,
                      thickness: 1,
                      trackVisibility: true,
                      controller: controller,
                      child: SizedBox(
                        height: justList(context, sizeWidth(context).height),
                        child: ListView.builder(
                          itemCount:viewModel.searchAdminSignature(viewModel.getAdminSignature!,viewModel.query).length,
                          controller: controller,
                          itemBuilder: (context, index) {
                            AdminSignature model = viewModel.searchAdminSignature(viewModel.getAdminSignature!,viewModel.query)[index];
                            return Card(
                              shape: cardShape(context),
                              color: ColorUtil().getColor(
                                  context, ColorEnums.background),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: ()  {
                                          launchUrl(Uri.parse(model.documentPath!));
              
                                        },
                                        child: Icon(Icons.picture_as_pdf_outlined, color: ColorUtil().getColor(context, ColorEnums.wizzColor))
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(model.distributorName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
              
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
                    SizedBox(
                      width: sizeWidth(context).width * 0.80,
                      child: ElevatedButton(
                        onPressed: () {
                          uploadContract(context, viewModel);
                        },
                        style: elevatedButtonStyle(context),
                        child: Text("updateDocument".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(
                            context, ColorEnums.textTitleLight)),),

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 8),
                      child: SizedBox(
                        width: sizeWidth(context).width * 0.80,
                        child: ElevatedButton(
                          onPressed: () async {
                            viewModel.signatureFile = await uploadSignature(context);
                            if(viewModel.signatureFile !=null){
                              await postSignature();
                            }
                          },
                          style: elevatedButtonStyle(context),
                          child: Text("uploadSignature".tr(),
                            style: CustomTextStyle().semiBold12(ColorUtil()
                                .getColor(context, ColorEnums.textTitleLight)),),

                        ),
                      ),
                    ),
                  ],
              
              ),
            );
          }
        },
      ),
    );
  }
  Future<void>getList()async{
    await viewModel.getDistContractType(context);
    await viewModel.getAdminSignatureList(context);
  }
  postSignature() async{
    await viewModel.postDistSignature(context, viewModel.signatureFile!);
  }
}
