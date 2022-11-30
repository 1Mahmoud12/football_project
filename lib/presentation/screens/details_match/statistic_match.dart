import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../domain/entities/details_match/statistics_match.dart';
import '../../../domain/entities/fixtures.dart';

class Statistics extends StatelessWidget {
  final int idFixture;
  final ResponseFixtures responseFixtures;
  const Statistics({Key? key,required this.idFixture,required this.responseFixtures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthMedia =MediaQuery.of(context).size.width;
    double heightMedia =MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<MatchesCubit,MatchesState>(
        builder: (context,state) {

          return ConditionalBuilder(
          condition: state is MatchesGetStatisticsSuccessState,
          builder: (context) {
            List<StatisticsMatch> statistics=RemoteDataSource.statisticsMatch??[];
            return statistics.isNotEmpty?Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
              children: [
                Container(
                  color: HexColor('232e4b'),
                  child: Row(

                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: widthMedia*.02),
                        child: CircleAvatar(
                            radius: widthMedia*.05,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(

                              image: NetworkImage(responseFixtures.teams.homeLogo),
                              width: widthMedia * .1,
                            )),
                      ),
                      const Spacer(),
                      Padding(
                        padding:  EdgeInsets.only(right: widthMedia*.02),
                        child: CircleAvatar(
                            radius: widthMedia*.05,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(responseFixtures.teams.awayLogo),
                              width: widthMedia * .1,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height:heightMedia*.02 ,),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.shotsOnGoal}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('shots on goal',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.shotsOnGoal}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.shotsOffGoal}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('shots off goal',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.shotsOffGoal}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.shotsInsideBox}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('shots in side box',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.shotsInsideBox}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.shotsOutSideBox}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('shots out side box',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.shotsOutSideBox}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.fouls}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('fouls',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.fouls}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.cornerKicks}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('corner Kicks',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.cornerKicks}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.offsides}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('offsides',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.offsides}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.ballPossession}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('ball Possession',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.ballPossession}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.yellowCards}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('yellow cards',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.yellowCards}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.redCards}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('red cards',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.redCards}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.goalKeeperSaves}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('goal Keeper Saves',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.goalKeeperSaves}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.totalPasses}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('total Passes',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.totalPasses}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.passesAccurate}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('passes accurate',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.passesAccurate}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${statistics[0].homeTeam.passes}',style: Theme.of(context).textTheme.bodyText2,),
                      )),
                      Text('passes %',style: Theme.of(context).textTheme.bodyText2,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${statistics[1].awayTeam.passes}',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
                      ))
                    ],
                  ),
                ),
              ],
          ),
            ):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [ Center(child: Text('No Statistics Yet'))],);
          },
          fallback: (context)=>SizedBox(
            height: 30,
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
        },
      ),
    );
  }
}
