// ignore_for_file: deprecated_member_use, unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:wizzsales/adminPage/adminMainHome.dart';
import 'package:wizzsales/utils/function/RouteGenerator.dart';
import 'package:wizzsales/view/internetPage/internet.dart';
import 'package:wizzsales/view/login/login_view.dart';
import 'package:wizzsales/view/mainHome/mainHome.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
import 'utils/function/providerFunc/AppStateNotifier.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'), // İngilizce (ABD)
            Locale('en', 'GB'), // İngilizce (UK)
            Locale('ar', 'SA'), // Arapça (Suudi Arabistan)
            Locale('es', 'ES'), // İspanyolca (İspanya)
            Locale('fr', 'FR'), // Fransızca (Fransa)
            Locale('de', 'DE'), // Almanca (Almanya)
            Locale('pt', 'BR'), // Portekizce (Brezilya)
            Locale('ru', 'RU'), // rusça
          ],
          path: 'assets/language',
          fallbackLocale: const Locale('en', 'US'),
          child: ChangeNotifierProvider<AppStateNotifier>(
            create: (_)=>AppStateNotifier(),
            child: Consumer<AppStateNotifier>(
              builder: (context,value,_){
                value.setTheme(context);

                return Phoenix(
                  child: const MyApp(),
                );
              },
            ),
          )
      ),
    );
  });
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppStateNotifier viewModel = AppStateNotifier();
  @override
  void initState() {
    viewModel.connection(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hyla North America',
        onGenerateRoute: RouteGenerator.generateRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        locale: context.locale,
        home:ChangeNotifierProvider.value(
          value: viewModel,
          child: Consumer<AppStateNotifier>(
              builder: (context, value, _) {
                //viewModel.connection(context); yazarsak her saniye dinler
                if (viewModel.checkInternet == null) {
                  return spinKit(context);
                } else if (viewModel.checkInternet == true) {
                  if (viewModel.state == "admin") {
                    return const AdminMainHome();
                  } else if (viewModel.state == "main") {
                    return const MainHome();
                  } else if(viewModel.state =="login"){
                    return const LoginView(null);
                  }else{
                    return spinKit(context);
                  }
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                  return const Internet();
                }
              }
          ),
        ),

        /*FutureBuilder<String>(
          future: isLoggedIn(context),
          builder: (BuildContext context,snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return spinKit(context);
            }else if(snapshot.data =="admin"){
              return const AdminHome(null);
            }else if(snapshot.data =="main"){
              return const MainHome();
            }else{
              return const LoginView(null);
            }
          },
        ),*/

    );
  }

}
