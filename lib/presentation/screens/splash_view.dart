import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/presentation/screens/matches_and_lives.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/onBoarding1.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightMedia=MediaQuery.of(context).size.height;
    double widthMedia=MediaQuery.of(context).size.width;
       // Future.delayed(const Duration(milliseconds: 400),()async => await Navigator.of(context).push(createRoute(Constants.apiKey==null?OnBoarding1():MatchesAndLives(),-1,0)));
    return Scaffold(
      body: Container(

        height:heightMedia*1 ,
        width: double.infinity,
        color: Colors.indigo,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Stack(
                alignment: AlignmentDirectional.center,

                children: [
                  Image.asset('assets/playstore.png',width:widthMedia*.4,height: 80 ,),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: ()=> Future.delayed(const Duration(milliseconds: 100),()async => await Navigator.of(context).push(createRoute(Constants.apiKey==null?OnBoarding1():MatchesAndLives(),0,1))),

                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("kick",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),),
                    SizedBox(width: widthMedia*.01,),
                    const Icon( Ionicons.football_outline,color:
                      Colors.white,),

                  ],
                ) ,),
            )
          ],
        ),
      ),
    );
  }
}
