import 'package:flutter/material.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogMe extends StatelessWidget {
   DialogMe({Key? key}) : super(key: key);
var dialogController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('attention'),
        content: const Text('you should create account from dashboard api'),
        actions: [
          TextFormField(onFieldSubmitted: (s){
            Constants.apiKey=s;
          },
      style: Theme.of(context).textTheme.bodyText1,

      controller:dialogController ,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(

        //label: Text('  Team',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
        //prefix: const Icon(Icons.search,color: Colors.white,size: 19),
        hintText: '🔍 Input Your api',
        hintStyle: Theme.of(context).textTheme.bodyText1,
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(width: 1,color: Colors.white)
        ),


      ),

    ),
          TextButton(
              onPressed: () {

              },
              child: const Text('create'))
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
