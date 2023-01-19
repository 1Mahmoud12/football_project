import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sofa_sccore/core/utils/colors.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/domain/entities/details_match/fixtures_lineup.dart';
import 'package:sofa_sccore/presentation/screens/details_player/player.dart';
import 'package:sofa_sccore/presentation/screens/details_team/team.dart';

import '../../../core/utils/functions.dart';
import '../../../domain/entities/fixtures.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';

class DetailsOfMatchesTwo extends StatelessWidget {
  final int fixturesId;
  final ResponseFixtures responseFixture;

  const DetailsOfMatchesTwo({Key? key, required this.fixturesId, required this.responseFixture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FixturesAndLineup> model = RemoteDataSource.fixturesAndLineup;
    return BlocBuilder<MatchesCubit, MatchesState>(
        builder: (context, state) {
          var widthMedia = MediaQuery.of(context).size.width;
          var heightMedia = MediaQuery.of(context).size.height;
          int lineUpA=0;
          int lineUpB=0;
          return Scaffold(
            body:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 10.0),
                    child: Card(
                      elevation: 7,
                      color: AppColors.cardColor,
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 13,
                                      backgroundColor:
                                      Colors.white.withOpacity(0),
                                      child: Image(
                                        image: NetworkImage(responseFixture.league.logo),
                                        height: 50,
                                        width: widthMedia * .08,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(responseFixture.league.name,style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap:() {
                                        MatchesCubit.get(context).championsTeam( responseFixture.teams.idHome);
                                        MatchesCubit.get(context).detailsVenueTeam( responseFixture.teams.idHome);
                                        MatchesCubit.get(context).getSquad( responseFixture.teams.idHome,);
                                        MatchesCubit.get(context).matchesForTeamFun( responseFixture.teams.idHome);

                                        MatchesCubit.get(context).standing(responseFixture.league.idLeague);
                                        Navigator.of(context).push(createRoute(Team(idTeam: responseFixture.teams.idHome),-1,0));

                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            image: NetworkImage(responseFixture.teams.homeLogo),
                                            height: heightMedia*.06,
                                            width: widthMedia * .08,
                                          ),
                                          SizedBox(
                                            height: heightMedia * .005,
                                          ),
                                          Text(responseFixture.teams.homeName,style: Theme.of(context).textTheme.bodyText1,),
                                          SizedBox(
                                            height: heightMedia * .005,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        if (responseFixture.goals.homeGoals != null)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${responseFixture.goals.homeGoals.toString()} :',style: Theme.of(context).textTheme.bodyText1,),
                                              Text(
                                                responseFixture.goals.awayGoals
                                                    .toString(),style: Theme.of(context).textTheme.bodyText1,),
                                            ],
                                          ),
                                        if (responseFixture.goals.homeGoals == null)
                                          Column(
                                            children: [
                                              Text(
                                                subStringForDate(
                                                    date: responseFixture.fixtures.date),style: Theme.of(context).textTheme.bodyText1,
                                              ),
                                              SizedBox(
                                                height: heightMedia * .01,
                                              ),
                                              Text(
                                                subStringForTime(
                                                    time: responseFixture.fixtures.date),style: Theme.of(context).textTheme.bodyText1,
                                              ),
                                            ],
                                          ),
                                        if (responseFixture.goals.homeGoals != null)
                                          Text(
                                            responseFixture.fixtures.shortTime,style: Theme.of(context).textTheme.bodyText1,
                                          )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        MatchesCubit.get(context).getSquad( responseFixture.teams.idAway,);
                                        MatchesCubit.get(context).championsTeam( responseFixture.teams.idAway);
                                        MatchesCubit.get(context).detailsVenueTeam( responseFixture.teams.idAway);

                                        MatchesCubit.get(context).matchesForTeamFun( responseFixture.teams.idAway);
                                        MatchesCubit.get(context).standing(responseFixture.league.idLeague);
                                        Navigator.of(context).push(createRoute(Team(idTeam: responseFixture.teams.idAway),360,0));
                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            image: NetworkImage(responseFixture.teams.awayLogo),
                                            height: heightMedia*.06,
                                            width: widthMedia * .08,
                                          ),
                                          SizedBox(
                                            height: heightMedia * .005,
                                          ),
                                          Text(responseFixture.teams.awayName,style: Theme.of(context).textTheme.bodyText1,),
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
                  if(model.isNotEmpty)
                    SizedBox(
                      height: heightMedia*.02,
                    ),
                  if(model.isEmpty)
                    SizedBox(
                      height: heightMedia*.3,
                    ),
                  ConditionalBuilder(
                    condition:model.isNotEmpty ,
                    builder: (context) {
                      List<String>teamALineUp=model[0].formation.split("-");
                      List<String>teamBLineUp=model[1].formation.split("-");
                      /*print(teamALineUp);
                      print(model[0].playerColorPrimary);*/

                      return Column(
                        children: [
                          Container(
                            color: HexColor('232e4b'),
                            child: Row(
                              
                              children: [
                              Padding(
                                padding:  EdgeInsets.only(left: widthMedia*.02),
                                child: CircleAvatar(
                                    radius: widthMedia*.05,
                                    backgroundColor:
                                    Colors.white.withOpacity(0),
                                    child: Image(
                                      image: NetworkImage(model[0].logo),
                                      height: 50,
                                      width: widthMedia * .1,
                                    )),
                              ),
                                const Spacer(),
                                Text(model[0].formation,style: const TextStyle(color: Colors.white70),)
                              ],
                            ),
                          ),
                          Container(
                            // alignment: AlignmentDirectional.topCenter,
                            width:double.infinity,
                            height: heightMedia*1,
                            decoration: const BoxDecoration(

                              image:DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/stadium.jpg',),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: heightMedia*.03),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        model[0].startXI[0].name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04,color: Colors.black,fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height:heightMedia*.001 ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: widthMedia*.038,
                                        child: CircleAvatar(
                                          radius:widthMedia*.035,
                                          backgroundColor: HexColor(
                                              "#${model[0].goalKeeperColorPrimary}"),
                                          child: Text(
                                            model[0].startXI[lineUpA]
                                                .number
                                                .toString(),
                                            style: TextStyle(
                                              color: HexColor(
                                                  "#${model[0].goalKeeperColorNumber}"),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                //SizedBox(height:heightMedia*.02 ),

                                Expanded(
                                  flex: 4,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                      SizedBox(height: heightMedia*.02),
                                      itemBuilder: (context, index) => Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:

                                         List.generate(
                                            int.parse(teamALineUp[index]),
                                                (_) {
                                                  lineUpA++;
                                              List<String> playerName =
                                              model[0].startXI[lineUpA].name.split(" ");
                                              return Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      playerName.length >= 3
                                                          ? playerName[1] + playerName[2]
                                                          : playerName.length == 2
                                                          ? playerName[1]
                                                          : playerName[0],
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04,color:Colors.black,fontWeight: FontWeight.w600),
                                                    ),
                                                     SizedBox(height: heightMedia*.008),
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: widthMedia*.038,
                                                      child: CircleAvatar(
                                                        radius:widthMedia*.035,
                                                        backgroundColor: HexColor(
                                                            "#${model[0].playerColorPrimary}"),
                                                        child: Text(
                                                          model[0].startXI[lineUpA]
                                                              .number
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: HexColor(
                                                                "#${model[0].playerColorNumber}"),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              );
                                            },
                                          ),

                                      ),
                                      itemCount: teamALineUp.length,
                                    ),
                                ),


                                Expanded(
                                  flex: 3,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: heightMedia*.02),
                                    itemBuilder: (context, index) => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:

                                      List.generate(
                                        int.parse(teamBLineUp.reversed.elementAt(index)),
                                            (_) {
                                          lineUpB++;
                                          List<String> playerName =
                                          model[1].startXI.reversed.elementAt(lineUpB).name.split(" ");
                                          return Expanded(
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: widthMedia*.038,
                                                  child: CircleAvatar(
                                                    radius:widthMedia*.035,
                                                    backgroundColor: HexColor(
                                                        "#${model[1].playerColorPrimary}"),
                                                    child: Text(
                                                      model[1].startXI.reversed.elementAt(lineUpB)
                                                          .number
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: HexColor(
                                                            "#${model[1].playerColorNumber}"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  playerName.length >= 3
                                                      ? playerName[1] + playerName[2]
                                                      : playerName.length == 2
                                                      ? playerName[1]
                                                      : playerName[0],
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04,color:Colors.black,fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),

                                    ),
                                    itemCount: teamBLineUp.length,
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: widthMedia*.038,
                                        child: CircleAvatar(
                                          radius:widthMedia*.035,
                                          backgroundColor: HexColor(
                                              "#${model[1].goalKeeperColorPrimary}"),
                                          child: Text(
                                            model[1].startXI.reversed.elementAt(lineUpB)
                                                .number
                                                .toString(),
                                            style: TextStyle(
                                              color: HexColor(
                                                  "#${model[1].goalKeeperColorNumber}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:heightMedia*.001 ),
                                      Text(
                                        model[1].startXI[0].name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04,color:Colors.black ,fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                //SizedBox(height:heightMedia*.05 ),

                              ],
                            ),



                          ),
                          Container(
                            color: HexColor('232e4b'),
                            child: Row(

                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: widthMedia*.02),
                                  child: CircleAvatar(
                                      radius: widthMedia*.05,
                                      backgroundColor:
                                      Colors.white.withOpacity(0),
                                      child: Image(
                                        image: NetworkImage(model[1].logo),
                                        height: 50,
                                        width: widthMedia * .1,
                                      )),
                                ),
                                const Spacer(),
                                Text(model[1].formation,style: const TextStyle(color: Colors.white70),)
                              ],
                            ),
                          ),
                          logo(widthMedia,model[0]),
                          coach(widthMedia,model[0],context),
                          substitutionPlayers(widthMedia,model[0],responseFixture.teams.idHome,context),
                          logo(widthMedia,model[1]),
                          coach(widthMedia,model[1],context),
                          substitutionPlayers(widthMedia,model[1],responseFixture.teams.idAway,context),
                        ],
                      );
                    },
                    fallback: (context) =>  Align(
                      alignment: AlignmentDirectional.center,
                      child: Text('Lineup don\'t Found yet',style: Theme.of(context).textTheme.bodyText1,),
                    ),
                  ),

                ],
              ),
            ),

          );
        });
  }





  Widget substitution(FixturesAndLineup model,index,widthMedia,context,idTeam){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          MatchesCubit.get(context).statisticsPlayer(model.substitutes[index].id,);
          MatchesCubit.get(context).transferPlayer(model.substitutes[index].id);
          //navigatorReuse(context, PlayerInfo(idPlayer: model.substitutes[index].id, idTeam:idTeam));
          Navigator.of(context).push(createRoute(PlayerInfo(idPlayer: model.substitutes[index].id, idTeam:idTeam),-1,0));
        },
        child: Row(
          children: [
            CircleAvatar(
                radius: 15,
                child: Text(model.substitutes[index].number.toString(),style: Theme.of(context).textTheme.bodyText1,)),
            SizedBox(width: widthMedia*.03,),
            Text(model.substitutes[index].name.toString(),style: Theme.of(context).textTheme.bodyText1,),
            Text(' (${model.substitutes[index].pos})',style: Theme.of(context).textTheme.bodyText1,)
          ],
        ),
      ),
    )
    ;
  }

  Widget substitutionPlayers(widthMedia,FixturesAndLineup model,idTeam,context){
    double heightMedia=MediaQuery.of(context).size.height;
    return SizedBox(
      height:model.substitutes.length* (heightMedia*.07),
      child: ListView.separated(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder:(context,index)=> substitution( model,index,widthMedia,context,idTeam),
          separatorBuilder: (context,index)=>separator(widthMedia),
          itemCount: model.substitutes.length),
    );
  }
  Widget coach(widthMedia, model,context){
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,top: 8.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 23,
              backgroundColor: Colors.white.withOpacity(0),
              child: Image(image: NetworkImage(model.coachPhoto))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: widthMedia*.15,),
                Text(model.coachName,style: Theme.of(context).textTheme.bodyText1,),
                Text('Coach',style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
          )
        ],),
    );
  }

}
