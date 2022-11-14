import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/colors.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/domain/entities/fixtures_lineup.dart';
import 'package:sofa_sccore/presentation/screens/details_player/player.dart';
import 'package:sofa_sccore/presentation/screens/details_team/team.dart';

import '../../core/utils/functions.dart';
import '../../domain/entities/fixtures.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

class DetailsOfMatches extends StatelessWidget {
  final int fixturesId;
  final ResponseFixtures responseFixture;

  const DetailsOfMatches({Key? key, required this.fixturesId, required this.responseFixture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FixturesAndLineup> model = RemoteDataSource.fixturesAndLineup;
    return BlocBuilder<MatchesCubit, MatchesState>(
        builder: (context, state) {
          var widthMedia = MediaQuery.of(context).size.width;
          var heightMedia = MediaQuery.of(context).size.height;

          return Scaffold(
              appBar: AppBar(),
              body:SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                                          MatchesCubit.get(context).matchesForTeamFun( responseFixture.teams.idHome,2022);

                                          MatchesCubit.get(context).standing(responseFixture.league.idLeague, '2022');
                                          navigatorReuse(context,Team(idTeam: responseFixture.teams.idHome,));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                              image: NetworkImage(responseFixture.teams.homeLogo),
                                              height: 50,
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

                                          MatchesCubit.get(context).matchesForTeamFun( responseFixture.teams.idAway,2022);
                                          MatchesCubit.get(context).standing(responseFixture.league.idLeague, '2022');
                                          navigatorReuse(context,Team(idTeam: responseFixture.teams.idAway,));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                              image: NetworkImage(responseFixture.teams.awayLogo),
                                              height: 50,
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
                      builder: (context)=> Padding(
                        padding: const EdgeInsets.only(left:5.0,right: 8.0),
                        child: Column(
                          children: [
                            Stack(
                              // alignment: AlignmentDirectional.topCenter,
                              children: [
                                Image.asset('assets/stadium.jpg'),

                                Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          positionPlayerLineup1(
                                              heightMedia: heightMedia,
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[0].name,
                                              numberPlayer: model[0].startXI[0].number,context: context),
                                        ]
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia:heightMedia,
                                              namePlayer: model[0].startXI[1].name,
                                              numberPlayer: model[0].startXI[1].number),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia: heightMedia,
                                              namePlayer: model[0].startXI[2].name,
                                              numberPlayer: model[0].startXI[2].number),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia:heightMedia,
                                              namePlayer: model[0].startXI[3].name,
                                              numberPlayer: model[0].startXI[3].number),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia: heightMedia,
                                              namePlayer: model[0].startXI[4].name,
                                              numberPlayer: model[0].startXI[4].number),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[5].name,
                                              numberPlayer: model[0].startXI[5].number,
                                              heightMedia: heightMedia),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[6].name,
                                              numberPlayer: model[0].startXI[6].number,
                                              heightMedia: heightMedia),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[7].name,
                                              numberPlayer: model[0].startXI[7].number,
                                              heightMedia: heightMedia),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[8].name,
                                              numberPlayer: model[0].startXI[8].number,
                                              heightMedia:  heightMedia),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup4(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[9].name,
                                              numberPlayer: model[0].startXI[9].number,
                                              heightMedia: heightMedia),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup4(
                                              widthMedia: widthMedia,
                                              namePlayer: model[0].startXI[10].name,
                                              numberPlayer: model[0].startXI[10].number,
                                              heightMedia: heightMedia),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),

                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup4(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[9].name,
                                              numberPlayer: model[1].startXI[9].number,
                                              heightMedia: heightMedia*.4,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup4(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[10].name,
                                              numberPlayer: model[1].startXI[10].number,
                                              heightMedia: heightMedia*.4,awayTeam: true),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[5].name,
                                              numberPlayer: model[1].startXI[5].number,
                                              heightMedia: heightMedia*1.5,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[6].name,
                                              numberPlayer: model[1].startXI[6].number,
                                              heightMedia: heightMedia*1.5,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[7].name,
                                              numberPlayer: model[1].startXI[7].number,
                                              heightMedia: heightMedia*1.5,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup3(
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[8].name,
                                              numberPlayer: model[1].startXI[8].number,
                                              heightMedia:  heightMedia*1.5,awayTeam: true),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia:heightMedia*5,
                                              namePlayer: model[1].startXI[1].name,
                                              numberPlayer: model[1].startXI[1].number,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia: heightMedia*5,
                                              namePlayer: model[1].startXI[2].name,
                                              numberPlayer: model[1].startXI[2].number,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia:heightMedia*5,
                                              namePlayer: model[1].startXI[3].name,
                                              numberPlayer: model[1].startXI[3].number,awayTeam: true),
                                        ),
                                        Expanded(
                                          child: positionPlayerLineup2(
                                              widthMedia: widthMedia,
                                              heightMedia: heightMedia*5,
                                              namePlayer: model[1].startXI[4].name,
                                              numberPlayer: model[1].startXI[4].number,awayTeam: true),
                                        ),
                                      ],
                                    ),


                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          positionPlayerLineup1(
                                              heightMedia: heightMedia*20,
                                              widthMedia: widthMedia,
                                              namePlayer: model[1].startXI[0].name,
                                              numberPlayer: model[1].startXI[0].number,context: context
                                          ,awayTeam: true),
                                        ]
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            logo(widthMedia,model[0]),
                            coach(widthMedia,model[0],context),
                            substitutionPlayers(widthMedia,model[0],responseFixture.teams.idHome),
                            logo(widthMedia,model[1]),
                            coach(widthMedia,model[1],context),
                            substitutionPlayers(widthMedia,model[1],responseFixture.teams.idAway),
                          ],
                        ),
                      ),
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

  Widget positionPlayerLineup1(
      {required widthMedia,
      required String namePlayer,
      required int numberPlayer,
      required heightMedia,required context,
        bool awayTeam=false

      }) {
    if(!awayTeam) {
      return Column(
      children: [
         SizedBox(
          height: heightMedia*.03,
        ),
        Text(
          namePlayer,
          style: TextStyle(
              fontSize: widthMedia * 0.04, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        CircleAvatar(
            radius: 15,
            child: Text(
              numberPlayer.toString(),
              style: TextStyle(
                  fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
            )),
      ],
    );
    }else{
      return Column(
        children: [
          SizedBox(
            height: heightMedia*.0325,
          ),

          CircleAvatar(
              radius: 15,
              child: Text(
                numberPlayer.toString(),
                style: TextStyle(
                    fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
              )),
          Text(
            namePlayer,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          ),
        ],
      );
    }
  }

  Widget positionPlayerLineup2(
      {required widthMedia,
        required heightMedia,
      required String namePlayer,
      required int numberPlayer,awayTeam=false}) {
    if(!awayTeam) {
      return Column(
      children: [
         SizedBox(
          height: heightMedia*.08,
        ),
        Text(
          namePlayer,
          style: TextStyle(
            fontSize: widthMedia * 0.04,
            fontWeight: FontWeight.bold,color: Colors.white
          ),
        ),
        CircleAvatar(
            radius: 15,
            child: Text(
              numberPlayer.toString(),
              style: TextStyle(
                  fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
            )),
      ],
    );
    }else{
      return Column(
        children: [
          SizedBox(
            height: heightMedia*.08,
          ),

          CircleAvatar(
              radius: 15,
              child: Text(
                numberPlayer.toString(),
                style: TextStyle(
                    fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
              )),
          Text(
            namePlayer,
            style: TextStyle(
              fontSize: widthMedia * 0.04,

              fontWeight: FontWeight.bold,color: Colors.white
            ),
          ),
        ],
      );
    }
  }

  Widget positionPlayerLineup3(
      {required widthMedia,
        required heightMedia,
        required String namePlayer,
        required int numberPlayer,
      awayTeam=false}) {
    if(!awayTeam) {
      return Column(
      children: [
         SizedBox(
          height: heightMedia*.17
        ),
        Text(
          namePlayer,
          style: TextStyle(
            fontSize: widthMedia * 0.04,
            fontWeight: FontWeight.bold,
              color: Colors.white,
            debugLabel: namePlayer
          ),maxLines: 1,overflow: TextOverflow.ellipsis,
        ),
        CircleAvatar(
            radius: 15,
            child: Text(
              numberPlayer.toString(),
              style: TextStyle(
                  fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
            )),
      ],
    );
    }
    else{ return Column(
      children: [
        SizedBox(
            height: heightMedia*.17
        ),

        CircleAvatar(
            radius: 15,
            child: Text(
              numberPlayer.toString(),
              style: TextStyle(
                  fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
            )),
        Text(
          namePlayer,
          style: TextStyle(
              fontSize: widthMedia * 0.04,
              fontWeight: FontWeight.bold,
              debugLabel: namePlayer,color: Colors.white
          ),maxLines: 1,overflow: TextOverflow.ellipsis,
        ),
      ],
    );}
  }
  Widget positionPlayerLineup4(
      {required widthMedia,
        required heightMedia,
        required String namePlayer,
        required int numberPlayer,
      awayTeam=false}) {

    if(!awayTeam) {
      return Column(
      children: [
        SizedBox(
            height: heightMedia*.26
        ),
        Text(
          namePlayer,
          style: TextStyle(
              fontSize: widthMedia * 0.04,
              fontWeight: FontWeight.bold,
              debugLabel: namePlayer,color: Colors.white
          ),maxLines: 1,overflow: TextOverflow.ellipsis,
        ),
        CircleAvatar(
            radius: 15,
            child: Text(
              numberPlayer.toString(),
              style: TextStyle(
                  fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
            )),
      ],
    );
    }
    else{
      return Column(
        children: [
          SizedBox(
              height: heightMedia*.26
          ),

          CircleAvatar(
              radius: 15,
              child: Text(
                numberPlayer.toString(),
                style: TextStyle(
                    fontSize: widthMedia * 0.05, fontWeight: FontWeight.bold,color: Colors.white),
              )),
          Text(
            namePlayer,
            style: TextStyle(
                fontSize: widthMedia * 0.04,
                fontWeight: FontWeight.bold,
                debugLabel: namePlayer,color: Colors.white
            ),maxLines: 1,overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }
  }

  Widget substitution(FixturesAndLineup model,index,widthMedia,context,idTeam){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          //print(model.substitutes[index].id.toString());
          MatchesCubit.get(context).statisticsPlayer(model.substitutes[index].id,season: DateTime.now().year.toString());
          MatchesCubit.get(context).transferPlayer(model.substitutes[index].id);
          navigatorReuse(context, PlayerInfo(idPlayer: model.substitutes[index].id, idTeam:idTeam));
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

  Widget substitutionPlayers(widthMedia,FixturesAndLineup model,idTeam){
    return SizedBox(
      height: 500,
      child: ListView.separated(
          physics:const BouncingScrollPhysics(),
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
