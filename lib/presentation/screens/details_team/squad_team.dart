import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import 'package:sofa_sccore/presentation/screens/details_player/player.dart';

import '../../../core/utils/functions.dart';
import '../../../domain/entities/team/squad.dart';

class SquadTeam extends StatelessWidget {


  const SquadTeam({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthMedia=MediaQuery.of(context).size.width;
    //MatchesCubit.get(context).getSquad(idTeam);
    //MatchesCubit.get(context).championsTeam(leagueId,season: DateTime.now().year.toString());

    return BlocConsumer<MatchesCubit,MatchesState>(
      listener: (context,state){},
        builder: (context,state) {
          return Scaffold(
            primary: false,


            body: ConditionalBuilder(
                condition: RemoteDataSource.squad != null,
                builder: (context) {
                  Squads model=MatchesCubit.get(context).modelSquads!;
                  return ListView(
                    children: [
                      logo(widthMedia, model),
                      players(widthMedia, model)

                    ],
                  );
                },
                fallback: (context) => const Center(child: CircularProgressIndicator(),)
            ),);
        });
  }
  Widget logo(widthMedia, model){
    return Padding(
      padding: const EdgeInsets.only(top:10,left: 8.0,right: 8.0),
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
                    child: Image(image: NetworkImage(model.team.logo))),
              ),
              Expanded(
                  flex: 3,
                  child: Text(model.team.name,style:  TextStyle(fontSize: widthMedia*.06,fontWeight: FontWeight.bold),)),
              Expanded(flex: 2,
                  child: Text('Squad',style:  TextStyle(fontSize: widthMedia*.05,fontWeight: FontWeight.w500),)),
            ],),
        ),
      ),
    );
  }
  Widget playersDetails(Squads model,index,widthMedia,context){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          print(model.player[index].id.toString());
          MatchesCubit.get(context).statisticsPlayer(model.player[index].id,season: DateTime.now().year.toString());
          MatchesCubit.get(context).transferPlayer(model.player[index].id);
          navigatorReuse(context, PlayerInfo(idPlayer: model.player[index].id, idTeam: model.team.id));
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: Image(image:NetworkImage(model.player[index].photo))),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [


                  Text(model.player[index].name.toString(),maxLines: 1,style: Theme.of(context).textTheme.bodyText1,),
                  Text(' (${model.player[index].position})',style:Theme.of(context).textTheme.bodyText1,)
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text('Number : ${model.player[index].number??'Not Selected'}',style: Theme.of(context).textTheme.bodyText1,),
                  Text('Age : ${model.player[index].age.toString()}',style: Theme.of(context).textTheme.bodyText1,),                              ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget players(widthMedia, model){
    return SizedBox(
      height: 650,
      child: ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder:(context,index)=> playersDetails(model,index,widthMedia,context),
          separatorBuilder: (context,index)=>separator(widthMedia),
          itemCount: model.player.length),
    );
  }
  
}
