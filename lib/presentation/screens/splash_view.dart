import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofa_sccore/core/utils/dialog.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/presentation/screens/matches_and_lives.dart';

import '../../core/utils/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightMedia=MediaQuery.of(context).size.height;
    double widthMedia=MediaQuery.of(context).size.width;
    //Future.delayed(const Duration(seconds: 0),()async => await navigatorReuse(context, Constants.apiKey==null?SpecificDialog():MatchesAndLives()),);
    return Scaffold(
      body: OutlinedButton(
        onPressed: ()=>navigatorReuse(context, MatchesAndLives()),
        child: Container(

          height:heightMedia*1 ,
          width: double.infinity,
          color: Colors.indigo,
          child: Stack(
            alignment: AlignmentDirectional.center,

            children: [
              Image.asset('assets/playstore.png',width:widthMedia*.4,height: 80 ,),
            ],
          ),
        ),
      ),
    );
  }
}
