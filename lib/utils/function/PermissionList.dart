import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionList{
  Future<void> checkAndRequestPermissions() async {
    final permissions = [
      Permission.notification,
      Permission.camera,
      Permission.location,
      Permission.photos,
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.contacts,
      Permission.sms,
    ];
    Map<Permission, PermissionStatus> statuses = await requestPermissions(permissions);

    statuses.forEach((permission, status) {
      if (status.isGranted) {

      } else if (status.isDenied) {

      } else if (status.isPermanentlyDenied) {

      }
    });
  }
  Future<Map<Permission, PermissionStatus>> requestPermissions(List<Permission> permissions) async {
    final statuses = await permissions.request();
    return statuses;
  }
}