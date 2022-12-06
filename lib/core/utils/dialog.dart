import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/presentation/screens/matches_and_lives.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/local.dart';

class DialogMe extends StatelessWidget {
   DialogMe({Key? key}) : super(key: key);
var dialogController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('attention'),
        content:  RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'you should create account from ',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black)),
                TextSpan(text: 'dashboard api',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue),recognizer: TapGestureRecognizer()..onTap=()async{
                  _launchUrl();

                }),
              ]
            )
        ),
        actions: [
          TextFormField(
            onFieldSubmitted: (s){
            Constants.apiKey=s;
          },
      style: TextStyle(fontSize: 15,color: Colors.black),

      controller:dialogController ,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(

        //label: Text('  Team',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
        //prefix: const Icon(Icons.search,color: Colors.white,size: 19),
        hintText: '🔍 Input Your api',
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(width: 1,color: Colors.white)
        ),


      ),

    ),
          TextButton(
              onPressed: () {
                SharedPreference.putDataString('api',dialogController.text );
                navigatorReuse(context, MatchesAndLives());

              },
              child: const Text('go'))
        ],

      ),
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(Constants.url)) {
      throw 'Could not launch $Constants.url';
    }
  }
}
