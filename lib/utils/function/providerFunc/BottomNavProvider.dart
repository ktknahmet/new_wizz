import 'package:flutter/cupertino.dart';
import 'package:wizzsales/utils/res/PageName.dart';

class BottomNavProvider extends ChangeNotifier{
  int currentIndex=0;


  setIndex(BuildContext context,int index){
    currentIndex = index;
    switch(index){
      case 0:
        return   Navigator.pushNamedAndRemoveUntil(context, '/${PageName.mainHome}', (Route<dynamic> route) => false,);
      case 1:
        return Navigator.pushNamed(context, '/${PageName.startDemo}');

      case 2:
        return    Navigator.pushNamed(context, '/${PageName.completeDemo}');
      case 3:
        return  Navigator.pushNamed(context, '/${PageName.dealerBoardPage}');
      case 4:
        return  Navigator.pushNamed(context, '/${PageName.quickAddSaleEnterValue}');

    }
    notifyListeners();
  }

}