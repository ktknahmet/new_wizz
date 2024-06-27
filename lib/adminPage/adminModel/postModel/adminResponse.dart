
import 'dart:convert';

AdminResponse adminResponseFromJson(String str) => AdminResponse.fromJson(json.decode(str));
String adminResponseToJson(AdminResponse data) => json.encode(data.toJson());


class AdminResponse {
  bool isSuccess;
  String message;

  AdminResponse({
    required this.isSuccess,
    required this.message,
  });

  factory AdminResponse.fromJson(Map<String, dynamic> json) => AdminResponse(
    isSuccess: json["isSuccess"] ?? false,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
