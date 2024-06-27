import 'Data.dart';

class CustomerEventModel {
  CustomerEventModel({
      this.pageNumber, 
      this.pageSize, 
      this.totalPages, 
      this.totalRecords, 
      this.nextPage, 
      this.previousPage, 
      this.firstPage, 
      this.lastPage, 
      this.data,});

  CustomerEventModel.fromJson(dynamic json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    firstPage = json['firstPage'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  String? nextPage;
  dynamic previousPage;
  String? firstPage;
  String? lastPage;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    map['totalRecords'] = totalRecords;
    map['nextPage'] = nextPage;
    map['previousPage'] = previousPage;
    map['firstPage'] = firstPage;
    map['lastPage'] = lastPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}