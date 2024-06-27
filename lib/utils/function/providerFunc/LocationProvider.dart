import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class LocationProvider extends ChangeNotifier{

  Map<String, dynamic> locationDetails = {};

   getLocationDetails(BuildContext context) async{
    showProgress(context, true);
    bool serviceEnabled =  await Geolocator.isLocationServiceEnabled();

    print("servis $serviceEnabled");
    if (!serviceEnabled) {
      showProgress(context, false);
      snackBarDesign(context, StringUtil.error, "locationClose".tr());

      notifyListeners();
      return;
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        snackBarDesign(context, StringUtil.error, "givePermissionLocation".tr());
        Future.delayed(const Duration(seconds: 3)).then((_) => {
         Geolocator.openAppSettings(),
        });

        permission = await Geolocator.requestPermission();
      } else {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        List<Placemark> place = await placemarkFromCoordinates(position.latitude, position.longitude);

        locationDetails['latitude'] = position.latitude;
        locationDetails['longitude'] = position.longitude;
        if (place.isNotEmpty) {
          Placemark currentPlace = place[0];

          locationDetails['zipcode'] = currentPlace.postalCode;
          locationDetails['country'] = currentPlace.country;
          locationDetails['county'] = currentPlace.subAdministrativeArea;
          locationDetails['state'] = currentPlace.administrativeArea;
          locationDetails['city'] = currentPlace.locality;
          locationDetails['street'] = currentPlace.street;
        }
      }
    }
    await showProgress(context, false);
    notifyListeners();
  }

}