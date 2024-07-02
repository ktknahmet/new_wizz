
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/appointmentBoard.dart';
import 'package:wizzsales/adminPage/adminModel/boardModel/saleBoard.dart';
import 'package:wizzsales/adminPage/adminModel/overrideModel/overrideWinner.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/organisations/allOrganisations.dart';
import 'package:wizzsales/adminPage/adminModel/stockModel/product/StockProduct.dart';
import 'package:wizzsales/model/OLD/register/LoginUser.dart';
import 'package:wizzsales/model/distType/Type.dart';
import 'package:wizzsales/model/languageModel/Languages.dart';
import 'package:wizzsales/model/overrideModel/dealerOverrideWinner.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
import 'package:wizzsales/widgets/Extension.dart';
import '../model/OLD/User.dart';

List<Types> roleList = [
    Types(id: 3, name: "dealer"),
    Types(id: 6, name: "da")
  ];
  List<String> roleOrder = ['da', 'dealer', 'leader', 'sales-manager', 'distributor'];

  List<Languages> modelList = [
    Languages("English(USA)", "en-US", "usa.png"),
    Languages("English(UK)", "en-GB", "english.png"),
    Languages("Deutsch", "de-DE", "deutsch.png"),
    Languages("French", "fr-FR", "french.png"),
    Languages("عربي", "ar-SA", "arabian.png"),
    Languages("Español", "es-ES", "spain.png"),
    Languages("Português", "pt-BR", "portugal.png"),
    Languages("Русский", "ru-RU", "russian.png"),
  ];
  List<String> weeks=["monday".tr(),"tuesday".tr(),"wednesday".tr(),"thursday".tr(),"friday".tr(),"saturday".tr(),"sunday".tr()];
  List<String> chooseType=["daily".tr(),"weekly".tr(),"monthly".tr()];
  List<String> overrideSummary=["monthly".tr(),"annually".tr()];
  List<String> comSummary=["daily".tr(),"payWeek".tr(),"monthly".tr(),"annually".tr()];
  List<String> progressList=["daily".tr(),"weekly".tr(),"monthly".tr(),"annually".tr()];
  List<String> reportType=["totalSale".tr(),"demos".tr(),"leads".tr()];
  List<String> appointmentDays=["yesterday".tr(),"today".tr(),"week".tr(),"month".tr(),"year".tr()];
  List<String> days=["yesterday".tr(),"daily".tr(),"weekly".tr(),"monthly".tr(),"annual".tr()];
  List<String> day=["lastMonth".tr(),"yesterday".tr(),"daily".tr(),"weekly".tr(),"monthly".tr(),"annual".tr()];
  List<String> region=["male".tr(),"female".tr()];

  Map<String, dynamic> carouselType = {
    "pdf".tr() :"pdf",
    "video".tr():"video",
    "photo".tr():"photo",
    "webPage".tr():"link"
  };
  List<String> leadDetails=["Appointment Set","Sold","Not Contacted"];

  double platformHeight(){
    double value=0;
    if(Platform.isAndroid){
      value = 35;
    }else{
      value = 60;
    }
    return value;
  }
  openDialPad(String phoneNumber) async {
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Can't open dial pad.");
  }
}

void openEmail(String email) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=Email&body=ahmet',
  );
  var url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("hata oldu");
  }
}
DateTime parseTime(String timeString, DateTime date) {
  final time = DateFormat.jm().parse(timeString);
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
  double bytesToMegabytes(int bytes) {
    return bytes / (1024 * 1024);
  }
  String dayTime(){
    String stringTime;
    DateTime time = DateTime.now().toLocal();
    String hourFormat = DateFormat('HH').format(time);

    int formatTime = int.parse(hourFormat);

    if(formatTime.clamp(5, 12)==formatTime){
      stringTime="lookingGood".tr();
    }else if(formatTime.clamp(12, 18)==formatTime){
      stringTime ="wayToGo".tr();
    }else{
      stringTime ="greatJob".tr();
    }
    return stringTime;
  }
  double autoHeight(BuildContext context, double height) {
    double autoHeight=0.0;



    if(height<700){
      autoHeight = sizeWidth(context).height+110;
    }else if(height>=700 && height<868){
      autoHeight = sizeWidth(context).height+85;
    }else if(height>868 && height<973){
      autoHeight = sizeWidth(context).height+80;

    }else if(height>973 && height<1133){
      autoHeight = sizeWidth(context).height+100;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height+100;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height+110;
    }
    return autoHeight;
  }
  double reportHeight(BuildContext context,double height){
    double autoHeight=0.0;
    if (kDebugMode) {
      print("ekran yüksekliği :$height");
    }
    if(height<700){
      autoHeight = sizeWidth(context).height*0.25;
    }else if(height>=700 && height<850){
      autoHeight = sizeWidth(context).height*0.35;
    }else if(height>850 && height<950){
      autoHeight = sizeWidth(context).height*0.38;
    }else if(height>=950 && height<1133){
      autoHeight = sizeWidth(context).height*0.39;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.40;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.44;
    }
    return autoHeight;
  }
  double homeRowHeight(BuildContext context,double height){
    double autoHeight=0.0;
    if (kDebugMode) {
      print("ekran yüksekliği :$height");
    }
    if(height<700){
      autoHeight = sizeWidth(context).height*0.30;
    }else if(height>=700 && height<850){
      autoHeight = sizeWidth(context).height*0.33;
    }else if(height>850 && height<950){
      autoHeight = sizeWidth(context).height*0.37;
    }else if(height>=950 && height<1133){
      autoHeight = sizeWidth(context).height*0.41;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.43;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.46;
    }
    return autoHeight;
  }
  double reportsHeightWithoutPage(BuildContext context,double height){
    double autoHeight=0.0;
    if (kDebugMode) {
      print("ekran yüksekliği :$height");
    }
    if(height<700){
      autoHeight = sizeWidth(context).height*0.65;
    }else if(height>=700 && height<800){
      autoHeight = sizeWidth(context).height*0.68;
    }else if(height>800 && height<930){
      autoHeight = sizeWidth(context).height*0.72;
    }else if(height>=930 && height<1133){
      autoHeight = sizeWidth(context).height*0.76;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.80;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.83;
    }
    return autoHeight;
  }
  double reportsHeight(BuildContext context,double height){
    double autoHeight=0.0;

    if(height<700){
      autoHeight = sizeWidth(context).height*0.60;
    }else if(height>=700 && height<800){
      autoHeight = sizeWidth(context).height*0.62;
    }else if(height>800 && height<930){
      autoHeight = sizeWidth(context).height*0.65;
    }else if(height>=930 && height<1133){
      autoHeight = sizeWidth(context).height*0.70;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.75;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.80;
    }
    return autoHeight;
  }
  double expenseReportHeight(BuildContext context,double height){
    double autoHeight=0.0;

    if(height<700){
      autoHeight = sizeWidth(context).height*0.58;
    }else if(height>=700 && height<800){
      autoHeight = sizeWidth(context).height*0.61;
    }else if(height>800 && height<930){
      autoHeight = sizeWidth(context).height*0.64;
    }else if(height>=930 && height<1133){
      autoHeight = sizeWidth(context).height*0.64;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.68;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.73;
    }
    return autoHeight;
  }
double photoHeight(BuildContext context,double height){
  double autoHeight=0.0;

  if(height<700){
    autoHeight = sizeWidth(context).height*0.05;
  }else if(height>=700 && height<800){
    autoHeight = sizeWidth(context).height*0.08;
  }else if(height>800 && height<930){
    autoHeight = sizeWidth(context).height*0.12;
  }else if(height>=930 && height<1133){
    autoHeight = sizeWidth(context).height*0.10;
  }
  else if(height>=1133 && height<1365){
    autoHeight = sizeWidth(context).height*0.08;
  }else if(height>=1366){
    autoHeight = sizeWidth(context).height*0.10;
  }
  return autoHeight;
}
  double justList(BuildContext context,double height){
    double autoHeight=0.0;

    if(height<700){
      autoHeight = sizeWidth(context).height*0.63;
    }else if(height>=700 && height<800){
      autoHeight = sizeWidth(context).height*0.65;
    }else if(height>800 && height<930){
      autoHeight = sizeWidth(context).height*0.70;
    }else if(height>=930 && height<1133){
      autoHeight = sizeWidth(context).height*0.70;
    }
    else if(height>=1133 && height<1365){
      autoHeight = sizeWidth(context).height*0.75;
    }else if(height>=1366){
      autoHeight = sizeWidth(context).height*0.80;
    }
    return autoHeight;
  }
double autoHeightSlider(BuildContext context,double height){
  double autoHeight=0.0;
  if(height<700){
    autoHeight = 120;
  }
  else if(height>=700 && height<800){
    autoHeight = 180;
  }else if(height>800 && height<=1180){
    autoHeight = 200;
  }else if(height>1180 && height<1365){
    autoHeight = 250;
  }else if(height>=1366){
    autoHeight = 250;
  }
  return autoHeight;
}

  double autoHeightAppBar(BuildContext context,double height){
    double autoHeight=0.0;
    if(height<700){
      autoHeight = 100;
    }
    else if(height>=700 && height<800){
      autoHeight = 130;
    }else if(height>800 && height<=1180){
      autoHeight = 160;
    }else if(height>1180 && height<1365){
      autoHeight = 210;
    }else if(height>=1366){
      autoHeight = 210;
    }
    return autoHeight;
  }
  Size sizeWidth(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    return mediaSize;
  }


  bool isWithinHours(String time) {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]); // Dakikayı ve AM/PM'yi alın
    String period = parts[1].split(' ')[1]; // AM/PM'yi alın


    DateTime now = DateTime.now();

    if(period == 'PM' && hour < 12) {
      hour += 12;
    } else if(period == 'AM' && hour == 12) {
      hour = 0;
    }

    DateTime appointmentTime = DateTime(now.year, now.month, now.day, hour, minute);
    DateTime twoHoursAhead = now.add(const Duration(hours: 2));

    return appointmentTime.isAfter(now) && appointmentTime.isBefore(twoHoursAhead);
  }

Map<String, dynamic> smashPhoneNumber(String phoneNumber) {

  Map<String, dynamic> phoneType = {};
  if(phoneType.isEmpty){
    phoneType["cCode"] = "";
    phoneType["phone"] = "";
  }else{
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r"""[+\-]"""), '');
    String lastTenDigits = cleanedNumber.substring(cleanedNumber.length - 10);
    String remainingDigits = cleanedNumber.substring(0, cleanedNumber.length - 10);

    phoneType["cCode"] = "+$remainingDigits";
    phoneType["phone"] = "-$lastTenDigits";
  }

  return phoneType;

}

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '##########',
      filter: { "#": RegExp(r"""[0-9]""") },
      type: MaskAutoCompletionType.lazy
  );

  String formatPhoneNumber(String number, String countryCode) {
    //String lastPhone = number.replaceAll("-", "");
    String lastPhone = number.replaceAll("-", "");
    return "$countryCode-$lastPhone";
  }
  String getRightSideOfPhoneNumber(String phoneNumber) {
    List<String> parts = phoneNumber.split('-');
    if (parts.length > 1) {
      return parts[1];
    } else {
      return phoneNumber;
    }
  }
  clearFocus(BuildContext context){
    FocusScope.of(context).unfocus();
  }
  String formatDateString(String inputDateString, String inputFormatStr, String outputFormatStr) {
    // Gelen string tarih formatını belirtin
    DateFormat inputFormat = DateFormat(inputFormatStr);

    // String tarihi DateTime nesnesine çevirin
    DateTime date = inputFormat.parse(inputDateString);
    DateFormat outputFormat = DateFormat(outputFormatStr);

    return outputFormat.format(date);
  }
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  String mmDDYDate(String? isoDateString) {
    if(isoDateString!.isNotEmpty){
      DateTime date = DateTime.parse(isoDateString);
      String formattedDate = DateFormat('MM-dd-yyyy').format(date);
      return formattedDate;
    }else{
      return "";
    }
  }
String mmDDYDateTime(String isoDateString) {
  String formattedDate="";
  if(isoDateString.isNotEmpty){
    DateTime date = DateTime.parse(isoDateString);
    formattedDate = DateFormat('MM-dd-yyyy hh:mm a').format(date);
  }

  return formattedDate;
}
String getDayOfWeek(String date) {
  DateFormat format = DateFormat('MM-dd-yyyy');
  DateTime dateTime = format.parse(date);

  return weeks[dateTime.weekday - 1]; // Use `weekday - 1` to get the correct index
}
String getPreviousMonthFirstAndLastDate(String inputDate) {
  inputDate = formatDateString(inputDate,"MM-dd-yyyy","yyyy-MM-dd");

  DateTime currentDate = DateTime.parse(inputDate);
  DateTime firstDayOfCurrentMonth = DateTime(currentDate.year, currentDate.month, 1);
  DateTime lastDayOfPreviousMonth = firstDayOfCurrentMonth.subtract(const Duration(days: 1));

  DateTime firstDayOfPreviousMonth = DateTime(lastDayOfPreviousMonth.year, lastDayOfPreviousMonth.month, 1);

  String firstDayOfPreviousMonthStr = "${firstDayOfPreviousMonth.day.toString().padLeft(2, '0')}-${firstDayOfPreviousMonth.month.toString().padLeft(2, '0')}-${firstDayOfPreviousMonth.year}";
  String lastDayOfPreviousMonthStr = "${lastDayOfPreviousMonth.day.toString().padLeft(2, '0')}-${lastDayOfPreviousMonth.month.toString().padLeft(2, '0')}-${lastDayOfPreviousMonth.year}";

  return "$firstDayOfPreviousMonthStr / $lastDayOfPreviousMonthStr";
}
Future<Map<String,dynamic>> getPreviousWeeksDates(String currentDate,String period, String day) async{
    Map<String,dynamic> map={};
  //takvimde seçilen günü baz al
  // Bugünün tarihi
  DateFormat inputFormatter = DateFormat('MM-dd-yyyy');
  DateTime now = inputFormatter.parse(currentDate);

  // Haftanın günlerini ve numaralarını eşleştirme
  Map<String, int> weekDays = {
    "monday": DateTime.monday,
    "tuesday": DateTime.tuesday,
    "wednesday": DateTime.wednesday,
    "thursday": DateTime.thursday,
    "friday": DateTime.friday,
    "saturday": DateTime.saturday,
    "sunday": DateTime.sunday
  };

  // Belirtilen günün bu haftadaki tarihini bulma
  int targetWeekDay = weekDays[day.toLowerCase()] ?? DateTime.monday;


  DateTime targetDate = now.add(Duration(days: targetWeekDay - (targetWeekDay-1)));

  // Bu haftanın Pazartesi gününü hesaplama
  DateTime startOfCurrentWeek = targetDate.subtract(Duration(days: targetDate.weekday - DateTime.monday));

  // Bitiş tarihini hesaplama (bu haftanın bir önceki Pazar günü)
  DateTime endOfPreviousWeek = startOfCurrentWeek.subtract(const Duration(days: 1));

  // Kaç hafta geriye gidileceği
  int weeksBack;
  if (period == 'weekly'.tr()) {
    weeksBack = 7;
  } else if (period == 'twoWeeks'.tr()) {
    weeksBack = 14;
  } else {
    throw ArgumentError('Geçersiz period değeri: $period');
  }

  // Başlangıç tarihini hesaplama (belirtilen haftanın Pazartesi gününden belirli haftalar önceki Pazartesi)
  DateTime startOfPreviousPeriod = startOfCurrentWeek.subtract(Duration(days: weeksBack));

  // Tarihleri formatlama
  DateFormat formatter = DateFormat('MM-dd-yyyy');
  String formattedStart = formatter.format(startOfPreviousPeriod);
  String formattedEnd = formatter.format(endOfPreviousWeek);

  map["startDate"]=formattedStart;
  map["endDate"]=formattedEnd;
  print("veriler :$formattedStart  -- $formattedEnd");
  return map;
}
String convertTo12HourFormat(int hour) {
  // Saat 12'den büyükse, saat 12 saat ekleyerek PM olarak yazdır
  if (hour > 12) {
    return '${hour - 12} PM';
  }
  // Saat 12 ise, 12 PM olarak yazdır
  else if (hour == 12) {
    return '12 PM';
  }
  // Saat 0 veya 24 ise, 12 AM olarak yazdır
  else if (hour == 0 || hour == 24) {
    return '12 AM';
  }
  // Diğer durumlar için AM olarak yazdır
  else {
    return '$hour AM';
  }
}
  String mmDDY(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String formattedDate = DateFormat('MM/dd/yyyy').format(date);
    return formattedDate;
  }
  String findTimeDifference(String dateString) {
    DateTime specifiedDateTime = DateTime.parse(dateString);

    DateTime now = DateTime.now();
    Duration difference = now.difference(specifiedDateTime);
    int hoursDifference = difference.inHours;
    int minutesDifference = difference.inMinutes % 60;

    String response="$hoursDifference hour $minutesDifference minute";
    return response;
  }
String calculateTimeDifference(String start, String end) {
  String differenceString = '';
  if(start.isNotEmpty && end.isNotEmpty){
    DateTime startTime = DateTime.parse(start);
    DateTime endTime = DateTime.parse(end);


    Duration difference = endTime.difference(startTime);

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;

    // Farkı string olarak formatlayın


    if (hours == 0) {
      differenceString = '$minutes minute';
    } else {
      differenceString = '$hours hour $minutes minute';
    }
  }

  return differenceString;
}
String calculateDay(String start,) {
  DateTime startTime = DateTime.parse(start);
  DateTime endTime = DateTime.now();


  Duration difference = endTime.difference(startTime);
  int day = difference.inDays;


  String differenceString = '';
  if(day==0){
    differenceString ="1 day";
  }else{
    differenceString ="$day day";
  }


  return differenceString;
}

int calculateDayDifference(String startDate, String endDate) {
  try {
    // "yyyy-MM-dd" formatındaki tarihleri parse et
    DateTime startDateTime = DateTime.parse(startDate);
    DateTime endDateTime = DateTime.parse(endDate);

    // Şu anki tarihi al
    DateTime currentDateTime = DateTime.now();

    // Eğer bitiş tarihi şu anki tarihten önceyse veya başlangıç tarihi şu andan sonra ise 0 dön
    if (endDateTime.isBefore(currentDateTime) || startDateTime.isAfter(currentDateTime)) {
      return 0;
    }

    // Eğer buraya kadar geldiysek, aradaki gün farkını hesapla ve dön
    int differenceInDays = endDateTime.difference(currentDateTime).inDays;
    return differenceInDays;
  } catch (e) {
    return 0;
  }
}

String stockProductName(int productId,List<StockProduct> stockProduct){
  String productName="";
  for(int i=0;i<stockProduct.length;i++){
    if(stockProduct[i].productId == productId){
      productName = stockProduct[i].productName!;
    }
  }
  return productName;
}



Future<String?> openImagePicker() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(
    source: ImageSource.camera,
  );

  if (image != null) {
    return image.path;
  }
  return null;
}

Future<String?> openGalleryPicker() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (image != null) {
    return image.path;
  }
  return null;
}

Future<String?> openDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  File? selectedFile;
  String? image;
  if (result != null) {
    selectedFile = File(result.files.single.path!);
    image = selectedFile.path;
  }

  return image;
}

String extractPhoneNumber(String phoneNumber) {
  String cleanPhoneNumber = "";

  if (phoneNumber.isEmpty) {
    return cleanPhoneNumber;
  } else {
    cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r"[^0-9-]"), '');
    int dashIndex = cleanPhoneNumber.indexOf('-');

    if (dashIndex != -1 && dashIndex + 1 < cleanPhoneNumber.length) {
      cleanPhoneNumber = cleanPhoneNumber.substring(dashIndex + 1);
    } else {
      cleanPhoneNumber = cleanPhoneNumber;
    }
    if (cleanPhoneNumber.startsWith('1')) {
      cleanPhoneNumber = cleanPhoneNumber.substring(1);
    }
  }

  return cleanPhoneNumber;
}

Future<LoginUser> getUser(BuildContext context) async {
  SharedPref pref = SharedPref();
  LoginUser? loginUser;
  var modelResponse = await pref.getString(context, SharedUtils.userModel);

  Map<String, dynamic> jsonMap = json.decode(modelResponse);
  loginUser = LoginUser.fromJson(jsonMap);
  if (kDebugMode) {
    print("login user bilgi :$jsonMap");
  }
  return loginUser;
}
Future<User> getUserUser(BuildContext context) async {
  SharedPref pref = SharedPref();
  User? user;
  var modelResponse = await pref.getString(context, SharedUtils.user);
  Map<String, dynamic> jsonMap = json.decode(modelResponse);
  if (kDebugMode) {
    print("user bilgi :$jsonMap");
  }
  user = User.fromJson(jsonMap);
  return user;
}
String drawCodeString(String input) {
  int endIndex = input.indexOf('}');

  if (endIndex != -1) {
    String codeWithBraces = input.substring(endIndex + 1);
    String codeWithoutBraces = codeWithBraces.replaceAll(RegExp('[^A-Z0-9-]'), '');

    return codeWithoutBraces;
  }
  return '';
}
Future<String> phoneFormat(String phone) async{

  String number="";
  String countryCode="";
  String result="";

  number = phone.replaceAll(RegExp(r"""[^0-9]"""), '');
  number = number.substring(number.length - 10);
  await CountryCodes.init();
  final CountryDetails details = CountryCodes.detailsForLocale();

  if (kDebugMode) {
    print("veriler :$number -- ${details.dialCode!}");
  }
  if(details.dialCode!.isEmpty){
    countryCode ="+1";
  }else{
    countryCode = details.dialCode!;
    result ="$countryCode-$number";
  }
  result ="$countryCode-$number";

  return result;
}
String upperFirstLetter(String value){
  String x="";
    if(value.isEmpty){
      return x;
    }else{
      x = value[0].toUpperCase() + value.substring(1);
    }
    return x;
}
statusCase(int type){
  String value="";
  switch(type){
    case 0:
      value= "Not Contacted";
      return value;
    case 1:
      value= "Appointment No Set";
      return value;
    case 2:
      value= "Appointment Set";
      return value;
    case 3:
      value= "Not Interested";
      return value;
    case 4:
      value= "Appointment Cancelled";
      return value;
    case 5:
      value= "Appointment Rescheduled";
      return value;
    case 6:
      value= "Demo Completed";
      return value;
    case 7:
      value= "Not Home";
      return value;
    case 8:
      value= "Sold";
      return value;
    case 9:
      value= "DNS";
      return value;
    case 10:
      value= "Not Contacted";
      return value;
    case 11:
      value= "DNQ";
      return value;
    case 12:
      value= "Confirmed";
      return value;
    default:
      value ="Not Selected";
      return value;
  }

}
financeType(int type){
  String value="";
  switch(type){
    case 1:
      value= "Cash";
      return value;
    case 2:
      value= "Check";
      return value;
    case 3:
      value= "Credit Card";
      return value;
    case 4:
      value= "Financed";
      return value;

    default:
      value ="Not Selected";
      return value;


  }
}
stockHistoryStatus(String type){
  String value="";
  switch(type){
    case "assign_distributor":
      value= "Assign to distributor";
      return value;
    case "assign_dealer":
      value= "Assign to dealer";
      return value;
    case "return_from_dealer":
      value= "Return from dealer";
      return value;
    case "paid":
      value= "Paid";
      return value;

    default:
      value ="";
      return value;


  }
}
String convertToFormattedString(dynamic number) {
  String result ="";

  if(number.toString().isEmpty){
    result ="0";
  }else{
    String numberString = number.toString();
    int length = numberString.length;
    String lastThreeDigits = length > 3 ? '.${numberString.substring(length - 3)}' : '';
    String firstDigits = length > 3 ? numberString.substring(0, length - 3) : numberString;
    result = '$firstDigits$lastThreeDigits';

  }
  return result;
}
String getDecimalPlaces(dynamic numberString, int decimalCount) {
  String value = numberString.toString();

  if(value.isEmpty){
    return value;
  }
  if (!value.contains('.')) {
    return value;
  }
  String decimalPart = value.split('.')[1];


  if (decimalPart.length <= decimalCount) {
    return value;
  }
  String decimalPlaces = decimalPart.substring(0, decimalCount);

  return '${value.split('.')[0]}.$decimalPlaces';
}
String moneyFormat(dynamic number) {
  dynamic value = number;
  value = NumberFormat.decimalPatternDigits(locale: 'tr_TR', decimalDigits: 2).format(value);

  // Nokta sayısını say
  int dotCount = '.'.allMatches(value).length;

  // Eğer 1'den fazla nokta varsa, son noktayı virgüle çevir
  if (dotCount > 1) {
    int lastDotIndex = value.lastIndexOf('.');
    value = value.substring(0, lastDotIndex) + ',' + value.substring(lastDotIndex + 1);
  }

  return value;
}
Future<bool> checkTwoWeekDate(String date) async {
  bool check = false;

  // Bugünün tarihini al
  DateTime today = DateTime.now();

  // İki hafta sonrasının tarihini al
  DateTime twoWeeksLater = today.add(const Duration(days: 14));

  // Gelen tarihi dd-MM-yyyy formatında parse et
  DateTime inputDate = DateFormat('dd-MM-yyyy').parse(date);

  // Gelen tarih iki hafta sonrasına eşitse, check true olsun
  if (inputDate.year == twoWeeksLater.year &&
      inputDate.month == twoWeeksLater.month &&
      inputDate.day == twoWeeksLater.day) {
    check = true;
  }

  return check;
}
String formatTime(dynamic time) {
  int hourPart = time ~/ 60; // Saati hesapla
  int minutePart = (time % 60).toInt(); // Dakikayı hesapla

  // Saati ve dakikayı birleştir
  String formattedTime = '';
  if (hourPart > 0) {
    formattedTime += '$hourPart Hour ';
  }
  formattedTime += '$minutePart Minute';

  return formattedTime;
}

List<int> calculateCounts(List<AppointmentBoard> appointments) {
  DateTime now = DateTime.now();
  DateTime startOfToday = DateTime(now.year, now.month, now.day);
  DateTime startOfYesterday = startOfToday.subtract(const Duration(days: 1));
  DateTime startOfWeek = startOfToday.subtract(Duration(days: now.weekday - 1));
  DateTime startOfMonth = DateTime(now.year, now.month, 1);
  DateTime startOfYear = DateTime(now.year, 1, 1);

  int dailyCount = appointments.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfToday)).length;
  int yesterdayCount = appointments.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfYesterday) && appointment.date!.isBefore(startOfToday)).length;
  int weeklyCount = appointments.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfWeek)).length;
  int monthlyCount = appointments.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfMonth)).length;
  int yearlyCount = appointments.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfYear)).length;

  return [yesterdayCount,dailyCount, weeklyCount, monthlyCount, yearlyCount];
}

List<int> calculateCountsSale(List<SaleBoard> saleBoard) {
  DateTime now = DateTime.now();
  DateTime startOfToday = DateTime(now.year, now.month, now.day);
  DateTime startOfYesterday = startOfToday.subtract(const Duration(days: 1));
  DateTime startOfWeek = startOfToday.subtract(Duration(days: now.weekday - 1));
  DateTime startOfMonth = DateTime(now.year, now.month, 1);
  DateTime startOfYear = DateTime(now.year, 1, 1);

  int dailyCount = saleBoard.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfToday)).length;
  int yesterdayCount = saleBoard.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfYesterday) && appointment.date!.isBefore(startOfToday)).length;
  int weeklyCount = saleBoard.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfWeek)).length;
  int monthlyCount = saleBoard.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfMonth)).length;
  int yearlyCount = saleBoard.where((appointment) =>
  appointment.date != null && appointment.date!.isAfter(startOfYear)).length;

  return [yesterdayCount,dailyCount, weeklyCount, monthlyCount, yearlyCount];
}

Map<String, double> calculateOverrideAmountsByOrg(List<AdminOverrideWinner> winners) {
  Map<String, double> orgTotals = {};

  for (var winner in winners) {

    double overrideAmount = double.tryParse(winner.overrideAmount ?? '0') ?? 0;

    if (orgTotals.containsKey(winner.organisationName)) {
      orgTotals[winner.organisationName!] = orgTotals[winner.organisationName!]! + overrideAmount;
    } else {
      orgTotals[winner.organisationName!] = overrideAmount;
    }
  }

  return orgTotals;
}

double totalDealerOverrideAmount(List<DealerOverrideWinner> winner){
    double total =0.0;
    for(int i=0;i<winner.length;i++){
      total = total+double.parse(winner[i].overrideAmount ?? "0.0");
    }
    return total;
}

bool getStatusVisibility(String key,List<Map<String, bool>> gridMap) {
  for (var map in gridMap) {
    if (map.containsKey(key)) {
      return map[key]!;
    }
  }
  return false;
}
String? getOrganisationName(List<AllOrganisations>? organisations, int distributorId) {
  try {
    return organisations!.firstWhere(
          (org) => org.id == distributorId,
    ).name;
  } catch (e) {
    return "None";
  }

}
Future<void> showErrorMessage(BuildContext context,String text) async{
  try{

    Map<String, dynamic> jsonData = json.decode(text);

    String message = jsonData["message"];
    valiDateInformation(context, message);

  }catch(error){
    return Future.error("hata mesajı :${error.toString()}");
  }

}

