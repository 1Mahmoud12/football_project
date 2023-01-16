

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sofa_sccore/core/utils/strings.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/data/models/champions_model.dart';
import 'package:sofa_sccore/domain/entities/league/standing_league.dart';
import 'package:sofa_sccore/presentation/screens/details_match/match.dart';

import '../../domain/entities/fixtures.dart';
import '../../presentation/bloc/cubit.dart';
import '../../presentation/screens/details_team/team.dart';
import 'colors.dart';

String subStringForDate({required String date }){

  String today=DateTime.now().toString().substring(5,10);
  String tomorrow=DateTime.now().add(const Duration(days: 1)).toString().substring(5,10);

  if (today == date.substring(5, 10)) {
    return 'Today';
  } else if (tomorrow == date.substring(5, 10)) {
    return 'Tomorrow';
  } else {
    return DateFormat('MMM dd').format(DateTime.parse(date.substring(0, 10)));
  }
}


String subStringForTime({required String time}) {
  int checkAmOrPm = int.parse(time.substring(11, 13)) ;
  if (checkAmOrPm > 12) {
    return '${(checkAmOrPm - 12)}${time.substring(13, 16)} Pm';
  } else {
    return '${(checkAmOrPm)}${time.substring(13, 16)} am';
  }
}

String simplyFormat({required DateTime time}) {

  String year = time.year.toString();
  String month = time.month.toString().padLeft(2, '0');
  String day = time.day.toString().padLeft(2, '0');


  // return the "yyyy-MM-dd HH:mm:ss" format
  return "$year-$month-$day";
}

List<ResponseFixtures> sortMatches(List<ResponseFixtures> sortedList){
  sortedList=sortedList.toSet().toList();
  sortedList.sort((a,b) => DateTime.parse(a.fixtures.date).compareTo(DateTime.parse(b.fixtures.date)));
return sortedList;
}

Widget separator(widthMedia){
  return Container(
    color: Colors.grey,
    width: widthMedia,
    height:1,
  );
}
navigatorReuse(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

Widget logo(widthMedia, model){
  return Padding(
    padding: const EdgeInsets.only(top:10,left: 8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(

          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white.withOpacity(0),
                  child: Image(image: NetworkImage(model.logo))),
            ),
            Expanded(
                flex: 3,
                child: Text(model.name,style:  TextStyle(fontSize: widthMedia*.06,fontWeight: FontWeight.bold),)),
            Expanded(flex: 2,
                child: Text('substitution',style:  TextStyle(fontSize: widthMedia*.05,fontWeight: FontWeight.w500),)),
          ],),
      ),
    ),
  );
}
Widget logoSearch(widthMedia,List<StandingLeague> model,index,context,bool check){
  return check?InkWell(
    onTap: (){
            MatchesCubit.get(context).selectedLeague(model[index],check);
            },
    child: Padding(
      padding: const EdgeInsets.only(top:10,left: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white.withOpacity(0),
                    child: const Icon(Icons.add,color: Colors.white,)),
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white.withOpacity(0),
                    child: Image(image: NetworkImage(model[index].logoLeague))),
              ),
              Expanded(
                  flex: 3,
                  child: Text(model[index].nameLeague,maxLines: 2,style:  TextStyle(fontSize: widthMedia*.04,fontWeight: FontWeight.bold),)),
            ],),
        ),
      ),
    ),
  ):InkWell(
    onTap: (){
      MatchesCubit.get(context).selectedLeague(model[index],check);
    },
    child: Padding(
      padding: const EdgeInsets.only(top:10,left: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white.withOpacity(0),
                    child: const Icon(Icons.remove,color: Colors.white,)),
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white.withOpacity(0),
                    child: Image(image: NetworkImage(model[index].logoLeague))),
              ),
              Expanded(
                  flex: 3,
                  child: Text(model[index].nameLeague,maxLines: 2,style:  TextStyle(fontSize: widthMedia*.04,fontWeight: FontWeight.bold),)),
            ],),
        ),
      ),
    ),
  );
}
String stringToDigits(int n) => n.toString().padLeft(2, '0');

Widget matches(List <ResponseFixtures>model,index,context,{ bool live=false}){
  var widthMedia=MediaQuery.of(context).size.width;
  var heightMedia=MediaQuery.of(context).size.height;
  final minutes=stringToDigits(MatchesCubit.get(context).matchDuration[model[index].fixtures.idFixtures]!.inMinutes.remainder(90));
  final seconds=stringToDigits(MatchesCubit.get(context).matchDuration[model[index].fixtures.idFixtures]!.inSeconds.remainder(60));
  return InkWell(
    onTap: ()async{
      MatchesCubit.get(context).fixturesAndLineup(model[index].fixtures.idFixtures);
      MatchesCubit.get(context).getStatistics(model[index].fixtures.idFixtures);
      MatchesCubit.get(context).getEvents(model[index].fixtures.idFixtures);


      navigatorReuse(context, Match(idFixtures:  model[index].fixtures.idFixtures,responseFixtures:  model[index]));
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0),
      child: Card(
        elevation: 7,
        color:AppColors.cardColor,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10)
          ),

          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.white.withOpacity(0),
                        child: Image(image:NetworkImage(model[index].league.logo),height:50,width: widthMedia*.08,)),
                    const SizedBox(width: 5,),
                    Text(model[index].league.name,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          MatchesCubit.get(context).matchesForTeamFun( model[index].teams.idHome, 2022)
                              .then((value) => MatchesCubit.get(context).timeToStartLive(RemoteDataSource.modelMatchesForTeam, '2022'));

                          MatchesCubit.get(context).championsTeam(model[index].teams.idHome);
                          MatchesCubit.get(context).detailsVenueTeam( model[index].teams.idHome);
                          MatchesCubit.get(context).getSquad( model[index].teams.idHome);
                          MatchesCubit.get(context).standing(model[index].league.idLeague, '2022');
                          Navigator.of(context).push(createRoute(Team(idTeam: model[index].teams.idHome),-1,0));
                          },
                        child: Column(
                          children: [
                            Image(image:NetworkImage(model[index].teams.homeLogo),height:50,width: widthMedia*.08,),
                            SizedBox(height: heightMedia*.005,),
                            Text(model[index].teams.homeName,style: Theme.of(context).textTheme.bodyText1,maxLines: 2,textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),

                    Expanded(

                      child:MatchesCubit.get(context).liveDate[index]  ?
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ConditionalBuilder(
                          condition: MatchesCubit.get(context).modelLive.isNotEmpty,
                          builder: (context)=> Column(
                            children: [
                              Container(
                                color: Colors.red.withOpacity(.8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text('$minutes : $seconds',style:Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
                                  ),),
                              SizedBox(height: heightMedia*.02,),
                              Text('${MatchesCubit.get(context).modelLive[model[index].fixtures.idFixtures]!.teams.homeGoals} : ${MatchesCubit.get(context).modelLive[model[index].fixtures.idFixtures]!.teams.awayGoals}'),
                            ],
                          ),
                          fallback: (context)=> const Center(child: CircularProgressIndicator(),),
                        ),
                      ):
                      Column(
                        children: [
                         // if(model[index].fixtures.shortTime!='NS'||model[index].fixtures.shortTime!='TBD')
                          if(model[index].goals.homeGoals!=null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('${model[index].goals.homeGoals } :',style:Theme.of(context).textTheme.bodyText1),
                                Text('${model[index].goals.awayGoals}',style: Theme.of(context).textTheme.bodyText1),

                              ],
                            ),
                          SizedBox(height: heightMedia*.005,),

                          if(model[index].fixtures.shortTime=='NS')
                            Column(
                              children: [
                                Text(subStringForDate(date: model[index].fixtures.date.toString()),style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: heightMedia*.01,),
                                Text(subStringForTime(time: model[index].fixtures.date.toString()),style: Theme.of(context).textTheme.bodyText1,),
                              ],
                            ),
                          if(model[index].fixtures.shortTime!='NS')
                            Text(AppString.durationMatch[model[index].fixtures.shortTime!]!,style: Theme.of(context).textTheme.bodyText1,)

                        ],
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: (){
                          MatchesCubit.get(context).championsTeam(model[index].teams.idAway)
                              .then((value) => MatchesCubit.get(context).timeToStartLive(RemoteDataSource.modelMatchesForTeam, '2022'));
                          MatchesCubit.get(context).detailsVenueTeam( model[index].teams.idAway);
                          MatchesCubit.get(context).matchesForTeamFun( model[index].teams.idAway, 2022);
                          MatchesCubit.get(context).getSquad( model[index].teams.idAway);
                          MatchesCubit.get(context).standing(model[index].league.idLeague, '2022');

                          Navigator.of(context).push(createRoute(Team(idTeam: model[index].teams.idAway),360,0));

                        },
                        child: Column(
                          children: [
                            Image(image:NetworkImage(model[index].teams.awayLogo),height:50,width: widthMedia*.08,),
                            SizedBox(height:heightMedia*.005,),
                            Text(model[index].teams.awayName,style: Theme.of(context).textTheme.bodyText1,maxLines: 2,textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),



                  ],
                ),
              ],
            ),
          ),

        ),
      ),
    ),
  );
}

List<ChampionsModel> championsLeague(){
  List<ChampionsModel> test=[];
  for (var element in RemoteDataSource.modelChampionsTeam) {
    if(element.standing){test.add(element);}
  }
  return test;
}

int selectNotStarted(List<ResponseFixtures> model){
  int item=0;
  for(int i=0;i<model.length;i++){
    //print(model[i].fixtures.shortTime);
    if(model[i].fixtures.shortTime=='NS'){
      item=i;
      break;
    }}
  return item;
  }
Widget indicator(){
  return SizedBox(
    height: 50,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LiquidLinearProgressIndicator(
        value: 0.6, // Defaults to 0.5.
        valueColor: const AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
        backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
        borderColor: Colors.red[100],
        borderWidth: 5.0,
        borderRadius: 12.0,
        direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
        center: const Text("Loading..."),
      ),
    ),
  );
}

Route createRoute(Widget detailsTeam,double x,double y) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  detailsTeam,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(x, y);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

