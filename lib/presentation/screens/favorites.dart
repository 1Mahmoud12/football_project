import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/core/utils/loading_screen.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../core/utils/constants.dart';

class Favorites extends StatelessWidget {

  ItemScrollController scrollController = ItemScrollController();
  bool enabled =true;
  int index2 = 0;

  Favorites({super.key});



  @override
  Widget build(BuildContext context) {
    favoritesMatches(context);
    var model = MatchesCubit.get(context).modelFavorites;
    MatchesCubit.get(context).countListFavorites =0;
      if(MatchesCubit.get(context).countListFavorites == Constants.favorites.length){
        enabled=false;
      }
    return BlocBuilder<MatchesCubit, MatchesState>(
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: MatchesCubit.get(context).countListFavorites == Constants.favorites.length ,
            builder: (context) {
              MatchesCubit.get(context).timeToStartLive(model, context);

            index2 = selectNotStarted(sortMatches(MatchesCubit.get(context).modelFavorites));

              if(MatchesCubit.get(context).countListFavorites!=0) {
                Future.delayed(const Duration(seconds: 1),() async=> await scrollToIndex(),);
              }

              return Padding(
                padding: const EdgeInsets.only(top:  15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemScrollController: scrollController,
                        itemBuilder: (context, index) => matches(sortMatches(model), index, context),
                        itemCount: model.length,
                      ),
                    )
                  ],
                ),
              );
            },
            fallback: (context) =>
                LoadingScreen(enabled: enabled),
          ),
        );
      },
    );
  }

  void favoritesMatches(context) {
    for (int i = 0; i < Constants.favorites.length; i++) {
      MatchesCubit.get(context).matchesForTeamFavorites(Constants.favorites[i], DateTime.now().year);
    }
  }

  Future scrollToIndex() async {
    scrollController.jumpTo(
        /*duration: Duration(seconds: Constants.favorites.length)*/ index: index2,alignment: 0.3);
  }


}
