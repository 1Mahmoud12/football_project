import 'dart:convert';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/network/local.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/core/utils/theme/dark_theme.dart';
import 'package:sofa_sccore/core/utils/theme/light_theme.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';


import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import 'package:sofa_sccore/presentation/screens/splash_view.dart';

import 'core/bloc_observer.dart';
import 'core/utils/services/get_it.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // FirebaseMessaging.onBackgroundMessage(const Messaging().firebaseMessagingBackgroundHandler);

  /* Future<AppUpdateInfo> checkForUpdate(){
    return ;
  };*/
  await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  );

  ServiceGetIt().init();
  bool? mode=await SharedPreference.getDataBool('mode');
  Constants.todaySharedPreference=await SharedPreference.getData('today');
  Constants.apiKey=await SharedPreference.getData('api');
 Constants.favorites=await SharedPreference.getDataString('favorites');
 Constants.leagueId=await SharedPreference.getDataString('newLeagues');
  Constants.leagueId=Constants.leagueId.isEmpty?[39]:await SharedPreference.getDataString('newLeagues');
  if(Constants.todaySharedPreference==null){}
  else if(int.parse(Constants.todaySharedPreference!)==int.parse(DateTime.now().toString().substring(11,13))){

    RemoteDataSource.modelOfFixtures=[];
    var  json=await SharedPreference.getData('fixtures');
    json.forEach((element) {
      RemoteDataSource.modelOfFixtures!.add(ResponseFixtures(jsonDecode(element) ));
    });


  }

  Bloc.observer = MyBlocObserver();

  runApp( MyApp(mode: mode??false));
}

class MyApp extends StatelessWidget {
  final bool mode;
  const MyApp({Key? key,required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (context)=>MatchesCubit(seGet(),seGet(),seGet(),seGet(),seGet(),seGet(),seGet(), seGet(),seGet(),seGet(),seGet(),seGet(),seGet(),seGet(),)
        ..mode(mode: mode)/*..messageFirebase()*/,
      child: BlocBuilder<MatchesCubit,MatchesState>(
        builder: (context,state) {
          return MaterialApp(
          theme: light,
          debugShowCheckedModeBanner: false,
          darkTheme: dark,
          themeMode:MatchesCubit.get(context).checkMode? ThemeMode.dark:ThemeMode.light,
          home:  const SplashView(),
        );
        },
      ),
    );
  }
}

