import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/model/loginModel/Login.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/basePage/BaseStateful.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/viewModel/LoginViewModel.dart';
import 'package:wizzsales/utils/res/PageName.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import 'package:wizzsales/widgets/WizzTextField.dart';
import 'reset_view.dart';
// ignore_for_file: use_build_context_synchronously
class LoginView extends BaseStatefulPage {
  const LoginView(super.appBarName, {super.key});

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends BaseStatefulPageState<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginViewModel viewModel = LoginViewModel();
  SharedPref pref = SharedPref();
  Login login = Login();
  String? selectedLanguage;

  @override
  void initState() {
    getInfo();
    super.initState();
  }
  @override
  Widget design() {
    return ChangeNotifierProvider<LoginViewModel>.value(
      value: viewModel,
      child: Consumer<LoginViewModel>(
        builder: (context,view,_){

          return Column(
            children: [
              const SizedBox(height: 40,),
              SizedBox(
                height: sizeWidth(context).height * 0.12,
                width: sizeWidth(context).width * 0.40,
                child: Image.asset('assets/app.png', color: ColorUtil().getColor(context, ColorEnums.appColor)),
              ),
              Text(
                "appName".tr(),
                style: CustomTextStyle().semiBold20(
                    ColorUtil().getColor(context, ColorEnums.appColor)),
              ),
              /*DropdownButton<String>(
                dropdownColor: ColorUtil().getColor(context, ColorEnums.background),
                underline: const SizedBox(),
                hint: Row(

                  children: [
                    Text("language".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                    const SizedBox(width: 8,),
                    Image.asset("assets/flag/${context.tr("photoPath")}",height: 24,)
                  ],
                ),
                value: selectedLanguage,
                onChanged: (newValue) async{

                  setState(() {
                    selectedLanguage = newValue!;
                    List<String> codes= selectedLanguage!.split("-");
                    EasyLocalization.of(context)?.setLocale(Locale(codes[0], codes[1]));
                  });
                },
                items: modelList.map((model) {
                  return DropdownMenuItem<String>(
                    value: model.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.key,style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight))),
                        const SizedBox(width: 8,),
                        Image.asset("assets/flag/${model.imagePath}",height: 24,)
                      ],
                    ),
                  );
                }).toList(),
              ),*/
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: sizeWidth(context).width * 0.74,
                child: Column(
                  children: [
                    SizedBox(
                        width: sizeWidth(context).width * 0.74,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mailCreate(context,"email",emailController),

                          ],
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: sizeWidth(context).width * 0.74,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "password".tr(),
                        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                          width: sizeWidth(context).width * 0.74,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WizzTextField(
                                  hint: "password",
                                  textEditingController: passwordController,
                                  hintTextColor: ColorEnums.textDefaultLight,
                                  hintTextSize: 14,
                                  borderColor: ColorEnums.textDefaultLight,
                                  borderWidth: 1.0,
                                  textColor: ColorEnums.textDefaultLight,
                                  isObsecure: viewModel.passObsecure,
                                  isObsecureClicked:(){
                                    bool value = !viewModel.passObsecure;
                                    viewModel.setPassObsecure(value);
                                  }
                              ),
                              const SizedBox(height: 4,),

                            ],
                          )
                      ),
                    ],
                  )
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: sizeWidth(context).width * 0.74,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "rememberMe".tr(),
                          style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/${PageName.resetView}');
                          },
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "forgotPassword".tr(),
                                style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),
                              )),
                        ),
                      ],
                    ),
                    Switch(
                      value: viewModel.isSwitched,
                      onChanged: (value) {
                        viewModel.setSwitch(value);
                      },
                      activeTrackColor: ColorUtil().getColor(context, ColorEnums.wizzColor),
                      activeColor: ColorUtil().getColor(context, ColorEnums.background),
                    ),

                  ],
                ),
              ),

              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child:  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child:Center(
                                child: SizedBox(
                                  width: sizeWidth(context).width*0.74,
                                  child: ElevatedButton(
                                    onPressed: ()async{
                                      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                                        bool mail = isEmail(emailController.text);
                                        if(mail){
                                          login = Login(email: emailController.text.toLowerCase(),password: passwordController.text);
                                          await viewModel.getLogin(context, login);
                                          if(viewModel.loginUser !=null){
                                            await pref.setString(SharedUtils.userToken, viewModel.loginUser!.token!);
                                            if(viewModel.isSwitched){
                                              await pref.setString(SharedUtils.email, emailController.text);
                                              await pref.setString(SharedUtils.password, passwordController.text);
                                              await pref.setBool(SharedUtils.remember, true);
                                            }else{
                                              await pref.deletePref(context, SharedUtils.email);
                                              await pref.deletePref(context, SharedUtils.password);
                                              await pref.deletePref(context, SharedUtils.remember);
                                            }
                                            await UserVM.getUserDetail(context);

                                          }
                                        }else{
                                          snackBarDesign(context, StringUtil.error, "emailTypeWrong".tr());
                                        }
                                      }else{
                                        snackBarDesign(context, StringUtil.error, "writeEmailPassword".tr());
                                      }
                                    },
                                    style: elevatedButtonStyle(context),
                                    child: Text("signIn".tr(), style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  ),
                                )
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/${PageName.registerPage}');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("dontHaveAccount".tr(),style: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                  const SizedBox(width: 8,),
                                  Text("createAccount".tr(),style: CustomTextStyle().bold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
  getInfo() async{
    await viewModel.getInformation(context);

    if(viewModel.remember ==null){
      return spinKit(context);
    }else{
      if(viewModel.remember!){
        viewModel.isSwitched = viewModel.remember!;
        emailController.text = viewModel.email!.toString().toLowerCase();
        passwordController.text = viewModel.password!.toString();

      }
    }
  }


  Widget forgetBtn() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ResetView(null)));
        },
        child: SizedBox(
            width: sizeWidth(context).width * 0.74,
            child: Text("forgotPassword".tr(),style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textDefaultLight)),)

        )
    );
  }

}