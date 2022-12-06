// ignore_for_file: must_be_immutable


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/presentation/screens/matches_and_lives.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/local.dart';

class SpecificDialog extends StatelessWidget {
   SpecificDialog({Key? key}) : super(key: key);
var dialogController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightMedia=MediaQuery.of(context).size.height;
    double widthMedia=MediaQuery.of(context).size.width;
    return Scaffold(
      body: AlertDialog(
        title: Row(
          children: [
            Image.asset('assets/warning.png',height: heightMedia*.05,width: widthMedia*.08,),
            SizedBox(width: widthMedia*.01,),
            const Text(' attention'),
          ],
        ),
        content:  RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'you should create account from ',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black)),
                TextSpan(text: 'dashboard api',style:Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue),recognizer: TapGestureRecognizer()..onTap=()async{
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
            style:const TextStyle(fontSize: 15,color: Colors.black),


            controller:dialogController ,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(

              label: Text('    API',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.05,color: Colors.blue)),
              prefix: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(Icons.edit,color: Colors.black,size: 15),
              ),
              hintText: 'ex:20ca5e99a094f9fd31713a90b0b75446',
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey,fontSize: widthMedia*.037),
              border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(width: 1,color: Colors.white)
              ),


            ),

    ),
          ElevatedButton(

              onPressed: dialogController.text.length!=32? null:() {
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
