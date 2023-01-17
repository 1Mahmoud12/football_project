import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/colors.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/data/models/standing_model.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/functions.dart';


class StandingTeam extends StatefulWidget {
  const StandingTeam({Key? key}) : super(key: key);

  @override
  State<StandingTeam> createState() => _StandingTeamState();
}

class _StandingTeamState extends State<StandingTeam> {
  String value0= championsLeague()[0].league!.name;

  @override
  Widget build(BuildContext context) {
    double widthMedia=MediaQuery.of(context).size.width;
    double heightMedia=MediaQuery.of(context).size.height;

    return BlocBuilder<MatchesCubit,MatchesState>(

        builder: (context,state) {

          return Scaffold(
          body: ConditionalBuilder(
            condition: RemoteDataSource.stand != null,
            builder: (context) {
              var model=RemoteDataSource.stand;

              return Column(
                children: [
                  logo(widthMedia, model,context),
                  SizedBox(height: heightMedia*.02,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                          flex: 0,
                          child: Text('#',style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13),)),

                      Expanded(
                          flex: 2,
                          child: Text('Team',textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),

                      Expanded(
                          flex:2,
                          child: Text('PTS',textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                      Expanded(
                          flex: 1,
                          child: Text('DIFF',textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                      Expanded(flex:1,child: Text('PL',textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                      Expanded(child: Text('WIN',textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                      Expanded(flex:1,child: Text('DRAW',style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                      Expanded(flex: 0,child: Text('LOSE',textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13))),
                    ],),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index) {
                        print(model!.nameLeague);
                        return model.nameLeague=='UEFA Champions League'||model.nameLeague=='World Cup'||model.nameLeague=='CAF' ? tableChampions(model, index,context):tableLeague(model, index,context);
                      },
                      itemCount:model!.standingsTeam.length ,),
                  ),],)

              ;
            },
            fallback: (context)=> indicator(),
          ),
        );
        });
  }

  Widget logo(widthMedia,model,context){
    return DropdownButton(
      value: value0,
        items: championsLeague().map((element) {

          return DropdownMenuItem(
                value: element.league!.name ,
                child:  SizedBox(
                  width: widthMedia*.6,
                  height: 20,
                  child: Row(

                    children: [
                      Expanded(
                        flex: 1,
                        child:element.league!.name=='UEFA Champions League' ? CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Image(image: NetworkImage(element.league!.logo))):
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(image: NetworkImage(element.league!.logo))),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(element.league!.name,style:  Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.greenAccent),)),

                    ],),
                ));
        }).toList(),
        onChanged: ( newValue){

          setState(() {
            value0 = newValue.toString();
            for (var element in RemoteDataSource.modelChampionsTeam) {
              if(element.league!.name==newValue.toString()){

                  MatchesCubit.get(context).standing(element.league!.id, );
              }
            }
          });
        },
      dropdownColor: Colors.black,
    focusColor: Colors.white,
      alignment: AlignmentDirectional.bottomCenter,
    ) ;
  }

  Widget tableLeague(StandingTeamModel model,index,context){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if(model.standingsTeam[index].rank<=4)
            Expanded(
              flex: 1,
              child: CircleAvatar(
                  radius: 10,backgroundColor:AppColors.circleAvatarColor,
                  child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
            ),
          if(model.standingsTeam[index].rank==5  )
            Expanded(
              flex: 0,
              child: CircleAvatar(
                  radius: 10,
                  child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
            ),
          if(model.standingsTeam[index].rank==6  )
            Expanded(
              flex: 0,
              child: CircleAvatar(
                  radius: 10,backgroundColor:AppColors.circleAvatarColor[800],
                  child: Text(model.standingsTeam[index].rank.toString(),style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
            ),if(model.standingsTeam[index].rank>6  )
            Expanded(
              flex: 0,
              child: CircleAvatar(
                  radius: 10,backgroundColor:AppColors.circleAvatarColor.withOpacity(0),
                  child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
            ),


          Expanded(
            flex: 1,
            child: CircleAvatar(
                radius: 15,backgroundColor: Colors.white.withOpacity(0),
                child: Image(image: NetworkImage(model.standingsTeam[index].logoTeam))),
          ),
          Expanded(flex: 2,
              child: Text(model.standingsTeam[index].nameTeam,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15))),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].points.toString(),textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].goalsDiff.toString(),textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].played.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].win.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].draw.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1,
              child: Text(model.standingsTeam[index].lose.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),




        ],
      ),
    );
  }
  Widget tableChampions(StandingTeamModel model,index,context){
    double heightMedia=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              if(model.standingsTeam[index].rank<=4)
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                      radius: 10,backgroundColor:AppColors.circleAvatarColor,
                      child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
                ),
              if(model.standingsTeam[index].rank==5  )
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                      radius: 10,
                      child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
                ),
              if(model.standingsTeam[index].rank==6  )
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                      radius: 10,backgroundColor:AppColors.circleAvatarColor[800],
                      child: Text(model.standingsTeam[index].rank.toString(),style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
                ),if(model.standingsTeam[index].rank>6  )
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                      radius: 10,backgroundColor:AppColors.circleAvatarColor.withOpacity(0),
                      child: Text(model.standingsTeam[index].rank.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),)),
                ),


              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: CircleAvatar(
                      radius: 15,backgroundColor: Colors.white.withOpacity(0),
                      child: Image(image: NetworkImage(model.standingsTeam[index].logoTeam))),
                ),
              ),
              Expanded(flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(model.standingsTeam[index].nameTeam,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                  )),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].points.toString(),textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1)),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].goalsDiff.toString(),textAlign: TextAlign.end,style:Theme.of(context).textTheme.bodyText1)),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].played.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].win.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].draw.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),
              Expanded(flex: 1,
                  child: Text(model.standingsTeam[index].lose.toString(),textAlign: TextAlign.center,style:Theme.of(context).textTheme.bodyText1)),




            ],
          ),
          (index+1)%4==0?SizedBox(height: heightMedia*.06,):const SizedBox()
        ],
      ),
    );
  }
}
