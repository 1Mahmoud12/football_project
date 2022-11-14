import 'package:flutter/material.dart';
import 'package:sofa_sccore/presentation/screens/details_player/details_player.dart';
import 'package:sofa_sccore/presentation/screens/details_player/statistics_player.dart';
import 'package:sofa_sccore/presentation/screens/details_team/matches.dart';
import 'package:sofa_sccore/presentation/screens/details_team/squad_team.dart';
import 'package:sofa_sccore/presentation/screens/details_team/standing_team.dart';

class PlayerInfo extends StatelessWidget {
  final int idPlayer;
  final int idTeam;
  const PlayerInfo({Key? key,required this.idPlayer,required this.idTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:const Text('Player Info'),
              bottom: const TabBar(tabs: [
                Tab(text: 'Details ', icon: Icon(Icons.menu)),
                Tab(text: 'Statistics', icon: Icon(Icons.calendar_today_outlined)),
                //Tab(text: 'Matches', icon: Icon(Icons.sports_volleyball_outlined)),
              ]),
            ),
            body: const TabBarView(
              children: [
                DetailsPlayer( ),
                StatisticsPlayer()    ,
                //MatchesPlayer(idPlayer:  idPlayer),
              ],
            )
        ));
  }
}
