import 'package:flutter/material.dart';
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
              flex: 6,
              child: Stack(
                alignment: AlignmentDirectional.center,

                children: [
                  Image.asset('assets/playstore.png',width:widthMedia*.4,height: 80 ,),

                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MaterialButton(
                onPressed: ()=> Future.delayed(const Duration(milliseconds: 100),()async => await Navigator.of(context).push(createRoute(Constants.apiKey==null?OnBoarding1():MatchesAndLives(),-1,0))),
                colorBrightness: Brightness.dark,
                 //splashColor: Colors.indigo,
                  disabledColor: Colors.amber,

                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("go"),
                    SizedBox(width: widthMedia*.01,),
                    const Icon( Icons.arrow_forward_ios),

                  ],
                ) ,),
            )
          ],
        ),
      ),
    );
  }
}
