import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/Resources.dart';

class ResourceProvider extends ChangeNotifier{
  String query="";


  setQuery(String value){
    query = value;
    notifyListeners();
  }
  List<Resource> searchResources(List<Resource> list, String query) {

    if (query.isEmpty) {
      return list;
    }
    List<Resource> filteredList = list.where((resource) => resource.title!.toLowerCase().contains(query.toLowerCase())).toList();

    return filteredList;
  }
}