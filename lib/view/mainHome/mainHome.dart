import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/utils/function/providerFunc/AppStateNotifier.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/CustomerAppBar.dart';
import 'package:wizzsales/view/home/home.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    deactivate();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(autoHeightAppBar(context,sizeWidth(context).height)),
          child: const CustomerAppBar(),
        ),
        key: key,
        drawer: ChangeNotifierProvider(
          create: (_) => AppStateNotifier(),
          child: Consumer<AppStateNotifier>(
            builder: (context,theme,_) {
              theme.setTheme(context);
              if(theme.loginUser == null && theme.index == null && theme.user == null){
                theme.getModel(context);
              }
              if(theme.loginUser == null && theme.index ==null && theme.user == null){
                return Drawer(
                  child: spinKit(context),
                );
              }else{
                return createDrawer(context,theme.loginUser!,theme.index!,theme.user!);
              }

            },
          ),
        ),
        onDrawerChanged: (change) async{
          if(change) {
            await getUserUser(context);
          }

        },
        body: const Home(null),

        bottomNavigationBar: navigationBar()
    );
  }

}
