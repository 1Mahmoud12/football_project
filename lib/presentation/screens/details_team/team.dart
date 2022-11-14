import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import 'package:sofa_sccore/presentation/screens/details_team/details_team.dart';
import 'package:sofa_sccore/presentation/screens/details_team/matches.dart';
import 'package:sofa_sccore/presentation/screens/details_team/squad_team.dart';
import 'package:sofa_sccore/presentation/screens/details_team/standing_team.dart';

import '../../../core/network/local.dart';
import '../../bloc/cubit.dart';

class Team extends StatelessWidget {
  final  int idTeam;
 const  Team({Key? key,required this.idTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchesCubit.get(context).selectFavorites(idTeam);
   return BlocBuilder<MatchesCubit,MatchesState>(
      builder: (context,state)=> DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title:const Text('Team Info'),
                actions: [
                  IconButton(onPressed: (){
                    MatchesCubit.get(context).favorites(idTeam);

                   // print(Constants.favorites );
                  }, icon:MatchesCubit.get(context).checkFavorites?const Icon(Icons.favorite): const Icon(Icons.favorite_border))
                ],
                bottom: const TabBar(tabs: [
                  Tab(text: 'Details', icon: Icon(Icons.info)),
                  Tab(text: 'Squad', icon: Icon(Icons.people)),
                  Tab(text: 'Standing', icon: Icon(Icons.calendar_today)),
                  Tab(text: 'Matches', icon: Icon(Icons.sports_volleyball_outlined)),

                ]),
              ),
              body:  const TabBarView(
                children:  [
                  DetailsTeam(),
                  SquadTeam(),
                  StandingTeam()    ,
                  MatchesTeam(),
                ],
              ))),
    );
  }
}
