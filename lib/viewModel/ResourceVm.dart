import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:wizzsales/model/OLD/Resources.dart';
import 'package:wizzsales/viewModel/OLD/UserVm.dart';

class ResourceVm extends ChangeNotifier {
  String? resource;
  List<String> names = [];
  Map<String, List<Resource>> allResourcesLists = {};
  List<Resource> allResourceFile=[];
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
  getAllResource(BuildContext context) async {
    await UserVM.getResourcesNew(context).then((value) {
      resource = value;
    });
    if (resource!.isNotEmpty) {
      var json = jsonDecode(resource!);

      json.forEach((key, list) {
        names.add(key.toString());

        var tagObjsJson = json[key] as List;

        List<Resource> resourcesList = tagObjsJson.map((tagJson) => Resource.fromJson(tagJson)).toList();
        allResourceFile.addAll(resourcesList);
        allResourcesLists[key] = resourcesList;
      });
    }

    notifyListeners();
  }

}
