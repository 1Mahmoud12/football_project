import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import 'package:sofa_sccore/presentation/screens/details_match/events_match.dart';
import 'package:sofa_sccore/presentation/screens/details_match/statistic_match.dart';


import '../../bloc/cubit.dart';
import 'line_up_tow.dart';

class Match extends StatelessWidget {
  final int idFixtures;
  final ResponseFixtures responseFixtures;
  const  Match({Key? key,required this.idFixtures,required this.responseFixtures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit,MatchesState>(
      builder: (context,state)=> DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title:const Text('Match Info'),
                bottom:  TabBar(tabs: const [
                  Tab(text: 'line up', icon: Icon(Icons.calendar_month)),
                  Tab(text: 'Statistics', icon:Icon(Ionicons.stats_chart) ),
                  Tab(text: 'Events', icon:Icon(Icons.calendar_today) ),

                ],onTap: (int index){
                  if(index==1)  MatchesCubit.get(context).getStatistics(idFixtures);
                  if(index==2)  MatchesCubit.get(context).getEvents(idFixtures);

                }),
              ),
              body:   TabBarView(
                children:  [
                  DetailsOfMatchesTwo(fixturesId: idFixtures,responseFixture: responseFixtures),
                  Statistics(idFixture: idFixtures,responseFixtures:  responseFixtures),
                   Events(responseFixture: responseFixtures),
                ],
              ),)),
    );
  }
}
