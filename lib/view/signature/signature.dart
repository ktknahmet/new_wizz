import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/contractModel/distributorContract.dart';
import 'package:wizzsales/utils/style/AddAppBar.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/ContractVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class Signature extends StatefulWidget {
  const Signature({super.key});

  @override
  State<StatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  GlobalKey<SfSignaturePadState> key = GlobalKey();
  ScrollController controller = ScrollController();
  ContractVm viewModel = ContractVm();

  @override
  void initState() {
    getList();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil().getColor(context,ColorEnums.background),
      appBar: AddAppBar(
        name: "paperWork".tr(),
        func: () {
          uploadContract(context, viewModel);
        },
      ),
      body: SizedBox(
        width: sizeWidth(context).width,
        height: sizeWidth(context).height,
        child: ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<ContractVm>(
            builder: (context, value, _) {
              if (viewModel.getContract == null || viewModel.contractType == null || viewModel.getAdminSignature == null) {
                return spinKit(context);
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: (value){
                                viewModel.setQuery(value);

                                viewModel.searchContract(viewModel.getContract!,viewModel.query);
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
                              itemCount: viewModel.searchContract(viewModel.getContract!,viewModel.query).length,
                              controller: controller,
                              itemBuilder: (context, index) {
                                DistributorContract model = viewModel.searchContract(viewModel.getContract!,viewModel.query)[index];
                                return Card(
                                  shape: cardShape(context),
                                  color: ColorUtil().getColor(
                                      context, ColorEnums.background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: ()  {
                                              launchUrl(Uri.parse(model.contractPath!));
                                              //Navigator.pushNamed(context, '/${PageName.pdfPage}', arguments: {'title': model.contractName!, 'url': model.contractPath!},);

                                            },
                                            child: Icon(Icons.picture_as_pdf_outlined, color: ColorUtil().getColor(context, ColorEnums.wizzColor))
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(model.contractName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 2,),
                                                Divider(
                                                  thickness: 0.3,
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                const SizedBox(height: 2,),
                                                Text(model.distributorName!, style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),),
                                                const SizedBox(height: 2,),
                                                Divider(
                                                  thickness: 0.3,
                                                  color: ColorUtil().getColor(context, ColorEnums.wizzColor),
                                                ),
                                                const SizedBox(height: 2,),
                                                Visibility(
                                                  visible: viewModel.getAdminSignature!.isNotEmpty ? true : false,
                                                  child: SizedBox(
                                                    height: 30,
                                                    width:sizeWidth(context).width*0.80,
                                                    child: ElevatedButton(
                                                        onPressed: (){
                                                          showPhoto(context, viewModel.getAdminSignature![0].documentPath!);

                                                        },
                                                        style: elevatedButtonStyle(context),
                                                        child: Text("seeSignature".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

                                                    ),
                                                  ),
                                                ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 16,bottom: 16),
                          child: Column(
                            children: [
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
                              SizedBox(
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
                            ],
                          ),
                        )


                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  getList() async {
    await viewModel.getDistContractType(context);
    await viewModel.getDistContract(context);
    await viewModel.getAdminSignatureList(context);
  }

  bool checkSignature() {
    bool check = false;
    for (int i = 0; i < viewModel.getContract!.length; i++) {
      if (viewModel.getContract![i].contractId !=
          viewModel.contractType![i].contractId) {
        check = true;
      }
    }
    return check;
  }
  postSignature() async{
    await viewModel.postDistSignature(context, viewModel.signatureFile!);

  }
}
