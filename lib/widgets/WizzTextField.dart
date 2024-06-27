
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomTextStyle.dart';


class WizzTextField extends StatelessWidget {
  final String hint;
  String? hintFontFamily;
  String? textFontFamily;
  int maxLines = 1;
  int? maxLength;
  double height = 44;
  String? leadingIcon;
  ColorEnums? leadingIconColor;
  String? trailingIcon;
  ColorEnums? trailingIconColor;
  String? errorText;
  ColorEnums? textColor = ColorEnums.textDefaultLight;
  ColorEnums? hintTextColor = ColorEnums.textDefaultLight;
  ColorEnums? borderColor = ColorEnums.textDefaultLight;
  ColorEnums? enabledBorderColor = ColorEnums.shadowDefaultLight;
  ColorEnums? focusedBorderColor = ColorEnums.primary;
  double borderWidth = 1.0;
  double enableBorderWidth = 1.0;
  double borderRadius = 6.0;
  double focusedBorderWidth = 2.0;
  double hintTextSize = 14;
  double lineHeight = 1;
  TextEditingController? textEditingController = TextEditingController();
  bool? isObsecure;
  VoidCallback? isObsecureClicked;
  ValueChanged<String>? onChanged;
  VoidCallback? onTapped;
  bool isEnabled = true;
  TextAlign textAlign = TextAlign.left;
  List<TextInputFormatter>? inputFormatter;
  TextInputType? keyboardType;


  WizzTextField({super.key,
    required this.hint,
    this.textEditingController,
    this.hintFontFamily,
    this.textFontFamily,
    this.maxLines = 1,
    this.maxLength,
    this.height = 44,
    this.leadingIcon,
    this.leadingIconColor,
    this.trailingIcon,
    this.trailingIconColor,
    this.errorText="",
    this.textColor,
    this.hintTextColor,
    this.borderColor = ColorEnums.shadowDefaultLight,
    this.borderWidth = 1.0,
    this.enableBorderWidth = 1.5,
    this.enabledBorderColor = ColorEnums.shadowDefaultLight,
    this.focusedBorderWidth = 2.0,
    this.focusedBorderColor = ColorEnums.wizzColor,
    this.borderRadius = 6.0,
    this.hintTextSize = 14,
    this.lineHeight = 1,
    this.isObsecure,
    this.isObsecureClicked,
    this.onChanged,
    this.isEnabled = true,
    this.onTapped,
    this.textAlign = TextAlign.left,
    this.inputFormatter,
    this.keyboardType,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        enabled: isEnabled,
        maxLines: maxLines,
        maxLength: maxLength ?? TextField.noMaxLength,
        onTap: onTapped,
        cursorColor: onTapped != null ? ColorUtil().getColor(context, ColorEnums.background) : ColorUtil().getColor(context, ColorEnums.primary),
        cursorWidth: onTapped != null ? 0 : 2,
        controller: textEditingController,
        inputFormatters: inputFormatter,
        keyboardType: keyboardType,
        style: CustomTextStyle().semiBold12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
        textAlign: textAlign,
        decoration: InputDecoration(

          counterText: "",
          prefixIcon: leadingIcon != null ? SizedBox(
            width: 18,
            height: 22,
            child: SvgPicture.asset(
              leadingIcon!,
              color: ColorUtil().getColor(context, leadingIconColor!),
              fit: BoxFit.scaleDown,
            ),
          ) : null,
          suffixIcon: isObsecure != null
              ?
          IconButton(
            icon: Icon(
              isObsecure != null && isObsecure! ? Icons.visibility : Icons.visibility_off,
              color:ColorUtil().getColor(context, ColorEnums.wizzColor),
            ), onPressed: isObsecureClicked != null ? isObsecureClicked! : () {  },
          ) : trailingIcon != null ? SizedBox(
            width: 18,
            height: 22,
            child: SvgPicture.asset(
              trailingIcon!,
              color: ColorUtil().getColor(context, trailingIconColor!),
              fit: BoxFit.scaleDown,
            ),
          ) : null,
          hintText: hint.tr(),
          hintStyle: CustomTextStyle().regular12(ColorUtil().getColor(context, ColorEnums.textTitleLight)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: ColorUtil().getColor(context, ColorEnums.wizzColor))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: ColorUtil().getColor(context, focusedBorderColor!), width: focusedBorderWidth),
              borderRadius: BorderRadius.circular(borderRadius)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorUtil().getColor(context, borderColor!), width: borderWidth),
              borderRadius: BorderRadius.circular(borderRadius)),
          contentPadding: const EdgeInsets.fromLTRB(15,8,8,8),  // Added this
        ),
        obscureText: isObsecure != null ? isObsecure! : false,
        onChanged: onChanged,
      ),
    );
  }
}