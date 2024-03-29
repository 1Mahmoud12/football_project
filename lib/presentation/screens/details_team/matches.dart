import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/functions.dart';


class MatchesTeam extends StatelessWidget {
   MatchesTeam({Key? key}) : super(key: key);
   ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    double heightMedia=MediaQuery.of(context).size.height;

    var model =RemoteDataSource.modelMatchesForTeam;
    MatchesCubit.get(context).timeToStartLive(RemoteDataSource.modelMatchesForTeam, context);
    return BlocBuilder<MatchesCubit,MatchesState>(
        builder: (context,state) {
          return Scaffold(
            body: Column(
              children: [
                ConditionalBuilder(
                    condition: model.isNotEmpty,
                    builder: (context)
                    {

                        Future.delayed(const Duration(milliseconds: 500),() async => selectNotStarted(sortMatches(model),scrollController),);

                      return SizedBox(
                        height: heightMedia * .78,
                        child: ScrollablePositionedList.builder(
                          itemScrollController: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                matches(sortMatches(model), index, context),
                            itemCount: sortMatches(model).length),
                      );
                    }, fallback: (context)=>indicator()),
              ],
            ),
          );

        });
  }


}
