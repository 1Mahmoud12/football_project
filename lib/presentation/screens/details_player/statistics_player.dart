import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/colors.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/strings.dart';
import '../../../data/data_source/remote_data_source.dart';

class StatisticsPlayer extends StatelessWidget {
  const StatisticsPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return BlocBuilder<MatchesCubit,MatchesState>(
      builder: (context,state)=> Scaffold(
          body:ConditionalBuilder(
              condition:RemoteDataSource.modelStatistics != null,
              builder:(context) {
                var model = RemoteDataSource.modelStatistics;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [

                        ///Matches
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.matched,style: Theme.of(context).textTheme.bodyText1!.copyWith(color:AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.totalMatches,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model!.statistics.game!.appearences.toString()??'0')
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.startedMatch,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.game!.lineups.toString()??'0')
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.minutesPerGame,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text((model.statistics.game!.minutes??0/model.statistics.game!.appearences??1).round().toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.rate,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.game!.rating[0])
                              ],
                            ),





                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Substitutes
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.substitutes,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.substitutesIn,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.substitutes!.inSubstitutes.toString()??'0')
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.substitutesOut,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.substitutes!.outSubstitutes.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.substitutesBench,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.substitutes!.benchSubstitutes.toString())
                              ],
                            ),






                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Goals
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.goals,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.totalGoals,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.goals!.totalGoals.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.totalAssists,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.goals!.assistsGoals.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.saved,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.goals!.savesGoals.toString())
                              ],
                            ),






                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Shots
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.shots,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.totalShots,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.shots!.totalShots.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.onShots,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.shots!.onShots.toString())
                              ],
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Passes
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.passes,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.totalPasses,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.passes!.totalPasses.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.keyPasses,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.passes!.keyPasses.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.accuracyPasses,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.passes!.accuracyPasses.toString())
                              ],
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Tackles
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.tackles,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.totalTackles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.tackles!.totalTackles.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.blockTackles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.tackles!.blocksTackles.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.interceptionsTackles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.tackles!.interceptionsTackles.toString())
                              ],
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// dribbles
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.dribbles,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.attemptsDribbles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.dribbles!.attemptsDribbles.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.successDribbles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.dribbles!.successDribbles.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.pastDribbles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.dribbles!.pastDribbles.toString())
                              ]
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Fouls
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.fouls,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.drawnFouls,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.fouls!.drawnFouls.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.committedFouls,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.fouls!.committedFouls.toString())
                              ],
                            ),
                            Row(
                                children: [
                                  Text(AppString.pastDribbles,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                  const Spacer(),
                                  Text(model.statistics.dribbles!.pastDribbles.toString())
                                ]
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Fouls
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.cards,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.yellowCards,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.card!.yellowCards.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.redCards,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.card!.redCards.toString())
                              ],
                            ),







                          ],
                        ),
                        SizedBox(height: height*.03,),
                        /// Penalty
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.penalty,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.titleStatistics),),
                            Row(
                              children: [
                                Text(AppString.wonPenalty,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.penalty!.wonPenalty.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.redCards,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.penalty!.scoredPenalty.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppString.missedPenalty,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:20)),
                                const Spacer(),
                                Text(model.statistics.penalty!.missedPenalty.toString())
                              ],
                            ),







                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context)=>  const Center(child: CircularProgressIndicator()))
      ),
    );
  }
}
