// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/constants/AppColors.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';

import '../utils/function/providerFunc/AppStateNotifier.dart';

class ColorUtil {
  Color getColor(BuildContext context, ColorEnums colorEnums) {
    AppStateNotifier themeProvider = Provider.of<AppStateNotifier>(
        context, listen: false);
    themeProvider.setTheme(context);
    if (themeProvider.darkMode) {
      return _getColorDarkTheme(colorEnums);
    } else {
      return _getColorLightTheme(colorEnums);
    }
    }

  Color _getColorLightTheme(ColorEnums colorEnums) {
    switch (colorEnums) {
      case ColorEnums.primary:
        return HexColor.fromHex("#07A883");
      case ColorEnums.primaryDark:
        return HexColor.fromHex("#138067");
      case ColorEnums.wizzColor:
        return const Color.fromRGBO(99, 179, 195, 1.0);
      case ColorEnums.primaryDarkDark:
        return HexColor.fromHex("#3FC0A3");
      case ColorEnums.primaryLight:
        return HexColor.fromHex("#40B298");
      case ColorEnums.warning:
        return HexColor.fromHex("#DBB700");
      case ColorEnums.warningDark:
        return HexColor.fromHex("#C4A400");
      case ColorEnums.warningLight:
        return HexColor.fromHex("#C4A400");
      case ColorEnums.error:
        return HexColor.fromHex("#D95757");
      case ColorEnums.errorDark:
        return HexColor.fromHex("#B24848");
      case ColorEnums.errorLight:
        return HexColor.fromHex("#F27979");
      case ColorEnums.success:
        return HexColor.fromHex("#51A310");
      case ColorEnums.successDark:
        return HexColor.fromHex("#41800F");
      case ColorEnums.successLight:
        return HexColor.fromHex("#88CC52");
      case ColorEnums.whitePureLight:
        return HexColor.fromHex("#FFFFFF");
      case ColorEnums.bgCardLight:
        return HexColor.fromHex("#FCFFFE");
      case ColorEnums.shadowDefaultLight:
        return HexColor.fromHex("#47665F33");
      case ColorEnums.backgroundDefaultLight:
        return HexColor.fromHex("#F5FAF9");
      case ColorEnums.backgroundBg2Light:
        return HexColor.fromHex("#EDF5F3");
      case ColorEnums.backgroundBg3Light:
        return HexColor.fromHex("#E4EBE9");
      case ColorEnums.textTitleLight:
        return HexColor.fromHex("#364D47");
      case ColorEnums.textDefaultLight:
        return HexColor.fromHex("#47665F");
      case ColorEnums.textSubtextLight:
        return HexColor.fromHex("#6B807B");
      case ColorEnums.textText50Light:
        return HexColor.fromHex("#47665F").withOpacity(0.5);
      case ColorEnums.textText40Light:
        return HexColor.fromHex("#47665F").withOpacity(0.4);
      case ColorEnums.textText30Light:
        return HexColor.fromHex("#47665F").withOpacity(0.3);
      case ColorEnums.borderDefaultLight:
        return HexColor.fromHex("#47665F").withOpacity(0.2);
      case ColorEnums.borderLight:
        return HexColor.fromHex("#47665F").withOpacity(0.1);
      case ColorEnums.borderDefaultUltaLight:
        return HexColor.fromHex("#406C80").withOpacity(0.05);
      case ColorEnums.transparant:
        return const Color(0x00000000);
      case ColorEnums.background:
        return HexColor.fromHex("#FFFFFF");
      case ColorEnums.appColor:
        return HexColor.fromHex("#000000");
      case ColorEnums.mainCard:
        return HexColor.fromHex("#FFFFFF");
      case ColorEnums.graphColor:
        return HexColor.fromHex("#F2F2F2");
      default:
        return const Color(0xffFFB56B);
    }
  }

  Color _getColorDarkTheme(ColorEnums colorEnums) {
    switch (colorEnums) {
      case ColorEnums.primary:
        return HexColor.fromHex("#11A885");
      case ColorEnums.primaryDark:
        return HexColor.fromHex("#29CCA6");
      case ColorEnums.wizzColor:
        return const Color.fromRGBO(99, 162, 178, 1.0);
      case ColorEnums.primaryDarkDark:
        return HexColor.fromHex("#3FC0A3");
      case ColorEnums.primaryLight:
        return HexColor.fromHex("#0D8065");
      case ColorEnums.warning:
        return HexColor.fromHex("#D9B341");
      case ColorEnums.warningDark:
        return HexColor.fromHex("#FFD659");
      case ColorEnums.warningLight:
        return HexColor.fromHex("#A68932");
      case ColorEnums.error:
        return HexColor.fromHex("#D96C6C");
      case ColorEnums.errorDark:
        return HexColor.fromHex("#E68A8A");
      case ColorEnums.errorLight:
        return HexColor.fromHex("#BF4C4C");
      case ColorEnums.success:
        return HexColor.fromHex("#73A321");
      case ColorEnums.successDark:
        return HexColor.fromHex("#94CC33");
      case ColorEnums.successLight:
        return HexColor.fromHex("#588014");
      case ColorEnums.whitePureLight:
        return HexColor.fromHex("#FFFFFF");
      case ColorEnums.bgCardLight:
        return HexColor.fromHex("#23332F");
      case ColorEnums.shadowDefaultLight:
        return HexColor.fromHex("#000000").withOpacity(0.2);
      case ColorEnums.backgroundDefaultLight:
        return HexColor.fromHex("#1C2926");
      case ColorEnums.backgroundBg2Light:
        return HexColor.fromHex("#151F1D");
      case ColorEnums.backgroundBg3Light:
        return HexColor.fromHex("#111A18");
      case ColorEnums.textTitleLight:
        return HexColor.fromHex("#CAE5DF");
      case ColorEnums.textDefaultLight:
        return HexColor.fromHex("#CAE5DF");
      case ColorEnums.textSubtextLight:
        return HexColor.fromHex("#9DB2AE");
      case ColorEnums.textText50Light:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.5);
      case ColorEnums.textText40Light:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.4);
      case ColorEnums.textText30Light:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.3);
      case ColorEnums.borderDefaultLight:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.2);
      case ColorEnums.borderLight:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.1);
      case ColorEnums.borderDefaultUltaLight:
        return HexColor.fromHex("#CAE5DF").withOpacity(0.05);
      case ColorEnums.transparant:
        return const Color(0x00000000);
      case ColorEnums.background:
        return HexColor.fromHex("#000000");
      case ColorEnums.appColor:
        return HexColor.fromHex("#FFFFFF");
      case ColorEnums.mainCard:
        return HexColor.fromHex("#3F3F3F");
      case ColorEnums.graphColor:
        return HexColor.fromHex("#3F3F3F");
      default:
        return const Color(0xffFFB56B);
    }
  }

}









extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}