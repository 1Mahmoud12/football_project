import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/functions.dart';


class MatchesTeam extends StatelessWidget {
  const MatchesTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model =RemoteDataSource.modelMatchesForTeam;
   // MatchesCubit.get(context).timeToStartLive(RemoteDataSource.modelMatchesForTeam, context);
    return BlocBuilder<MatchesCubit,MatchesState>(
        builder: (context,state) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: ConditionalBuilder(
                      condition: model.isNotEmpty,
                      builder: (context)=>ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder:(context,index)=> matches(sortMatches(model) ,index,context),
                          itemCount: sortMatches(model).length
                      ), fallback: (context)=>const Center(child: CircularProgressIndicator(),)),
                ),
              ],
            ),
          );

        });
  }


}
