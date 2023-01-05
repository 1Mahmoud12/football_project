// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import 'package:sofa_sccore/presentation/screens/favorites.dart';
import 'package:sofa_sccore/presentation/screens/search_team.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/loading_screen.dart';

class MatchesAndLives extends StatelessWidget {
  bool enabled = true;

  MatchesAndLives({super.key});

  @override
  Widget build(BuildContext context) {
    if (RemoteDataSource.modelOfFixtures == null) {
      MatchesCubit.get(context).allGames(2022,Constants.fromDate,Constants.toDate);

    } else if (RemoteDataSource.modelOfFixtures != null &&
        MatchesCubit.get(context).countAllGames == 0) {
      MatchesCubit.get(context).sortModel=sortMatches(RemoteDataSource.modelOfFixtures!);
      MatchesCubit.get(context).timeToStartLive(MatchesCubit.get(context).sortModel, context);
      MatchesCubit.get(context).increment();
    }

    var widthMedia = MediaQuery.of(context).size.width;
    var heightMedia = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size.aspectRatio;
    return BlocConsumer<MatchesCubit, MatchesState>(
      listener: (context, state) {
        if (state is MatchesGetAllGamesSuccessState) {
          enabled = false;
          MatchesCubit.get(context).timeToStartLive(MatchesCubit.get(context).sortModel, context);
        }
        if (state is MatchesSearchLeagueSuccessState) {
          enabled = false;

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Matches'),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  navigatorReuse(context, Favorites());
                },
                icon: const Icon(Icons.favorite)),
            actions: [
              IconButton(
                  onPressed: () {
                    navigatorReuse(context, SearchTeam());
                  },
                  icon: const Icon(Icons.search_rounded)),
              IconButton(
                  onPressed: () {
                    MatchesCubit.get(context).mode();
                  },
                  icon: MatchesCubit.get(context).checkMode
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.dark_mode)),
            ],
          ),
          body: SingleChildScrollView(
            child: ConditionalBuilder(
                condition: state is MatchesGetAllGamesLoadingState,
                builder: (context) =>SizedBox(
                    width: double.infinity,
                    height: heightMedia * 5,
                    child: LoadingScreen(
                      enabled: enabled,
                    )),
                fallback: (context) =>  ConditionalBuilder(
                  condition: RemoteDataSource.modelOfFixtures!.isNotEmpty,
                  builder: (context)=> SingleChildScrollView(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              MatchesCubit.get(context).allGames(2022,
                                  DateTime.now().add(const Duration(days: -7)).toString().substring(0, 10),
                                  DateTime.now().add(const Duration(days: -1)).toString().substring(0, 10));
                            },
                            child: const Text('SHOW LAST 7 DAYS')),
                        SizedBox(
                          height: heightMedia * .81,
                          child: RefreshIndicator(
                            edgeOffset: 100.0,
                            onRefresh: () async {
                                  MatchesCubit.get(context).allGames(2022,Constants.fromDate,Constants.toDate);
                            },
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return matches(sortMatches( RemoteDataSource.modelOfFixtures!), index, context, live: MatchesCubit.get(context).liveDate[index]);
                                },
                                itemCount: RemoteDataSource.modelOfFixtures!.length),
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context)=>Column(

                    children: [
                      Image.asset('assets/no_matches.png',height: heightMedia*.8),
                    ],
                  ),
                )
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.indigo,
            onPressed: () {},
            child: IconButton(
                onPressed: () {
                  MatchesCubit.get(context).selectedOneLeague = [];
                  RemoteDataSource.changeLeaguesModel = [];
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.black,
                      isScrollControlled: true,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: heightMedia * .01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Ionicons.search_circle_outline,
                                      color: Colors.white,
                                      size: size + 35,
                                    ),
                                    SizedBox(
                                      width: widthMedia * .03,
                                    ),
                                    Text(
                                      'Search about Leagues',
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white70),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: heightMedia * .02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'leagues',
                                      prefix: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Ionicons.search_circle_outline,
                                          color: Colors.white,
                                          size: size + 30,
                                        ),
                                      ),
                                      labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white70),
                                      border: const OutlineInputBorder(),
                                    ),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20, color: Colors.white),
                                    onFieldSubmitted: (league) {
                                      if (league.length > 2) {
                                        MatchesCubit.get(context).searchLeague(league);
                                      }
                                    },
                                    onChanged: (String league) {
                                      if (league.length > 2) {
                                        MatchesCubit.get(context).searchLeague(league);
                                      }
                                    },
                                  ),
                                ),
                                BlocBuilder<MatchesCubit, MatchesState>(
                                  builder: (context, state) =>
                                      ConditionalBuilder(
                                          condition: MatchesCubit.get(context).selectedOneLeague.isNotEmpty,
                                          builder: (context) => Stack(
                                                alignment: AlignmentDirectional.bottomCenter,
                                                children: [
                                                  SizedBox(
                                                    height: heightSizeBox(context),
                                                    child: GridView.count(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 0,
                                                      childAspectRatio: 2.5,
                                                      children: List.generate(
                                                        MatchesCubit.get(context).selectedOneLeague.length,
                                                        (index) => logoSearch(widthMedia, MatchesCubit.get(context).selectedOneLeague, index, context, false),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);},
                                                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.circleAvatarColor),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text('cancel', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white)),
                                                              const Spacer(),
                                                              const Icon(Icons.cancel,
                                                                color: Colors.white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            List<int>newLeagues = [];
                                                            MatchesCubit.get(context).selectedOneLeague.forEach((element) {newLeagues.add(element.idLeague);
                                                            });

                                                            if (newLeagues.isNotEmpty) {
                                                              Constants.leagueId = newLeagues;
                                                              MatchesCubit.get(context).allGames(2022,Constants.fromDate,Constants.toDate);
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.circleAvatarColor),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text('go', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                                                              ),
                                                              const Spacer(),
                                                              const Icon(Icons.arrow_forward_ios,
                                                                color: Colors.white,)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                          fallback: (context) => const SizedBox()),
                                ),
                                BlocBuilder<MatchesCubit, MatchesState>(
                                  builder: (context, state) =>
                                      ConditionalBuilder(
                                          condition: RemoteDataSource.changeLeaguesModel!.isNotEmpty,
                                          builder: (context) => SizedBox(
                                                height: 300,
                                                child: GridView.count(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 0,
                                                  childAspectRatio: 2.5,
                                                  children: List.generate(RemoteDataSource.changeLeaguesModel!.length,
                                                    (index) => logoSearch(widthMedia, RemoteDataSource.changeLeaguesModel!, index, context, true),
                                                  ),
                                                ),
                                              ),
                                          fallback: (context) => const SizedBox()),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Ionicons.football_outline)),
          ),
        );
      },
    );
  }

  double heightSizeBox(context) {
    int length = MatchesCubit.get(context).selectedOneLeague.length;
    double height = 0;
    if (length == 0) {
    } else if (length < 3) {
      height = 100;
    } else {
      height = 200;
    }

    return height;
  }
}
