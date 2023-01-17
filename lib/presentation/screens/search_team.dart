import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../data/models/search_teams_model.dart';
import 'details_team/team.dart';

class SearchTeam extends StatelessWidget {
    SearchTeam({Key? key}) : super(key: key);
final searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightMedia=MediaQuery.of(context).size.height;
    return BlocConsumer<MatchesCubit,MatchesState>(
      listener: (context,state){},
      builder: (context,state)=> Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(onFieldSubmitted: (s){},
                style: Theme.of(context).textTheme.bodyText1,

                controller:searchController ,
                  keyboardType: TextInputType.text,
                  onChanged: (String s){
                  if(s.length>2){
                    MatchesCubit.get(context).searchTeam(s);
                  }
                  },
                  decoration: InputDecoration(

                      //label: Text('  Team',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                      //prefix: const Icon(Icons.search,color: Colors.white,size: 19),
                      hintText: '🔍 Input Your Team',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(width: 1,color: Colors.white)
                    ),


              ),

              ),
              SizedBox(height: heightMedia*.05,),
              ConditionalBuilder(condition: state is MatchesSearchTeamSuccessState,
                  builder: (context) {
                var model=RemoteDataSource.searchModel;
                    return Expanded(
                      child: ListView.builder(
                          itemBuilder: (context,index)=> searchItem(model, index,context),

                        itemCount: model.length,
                      ),
                    );
                  },
                  fallback: (context)=>const Center(child: Text('Please Enter Search Team'),)
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget searchItem(List<SearchTeamsModel> model , index,context){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Column(
      children: [
        InkWell(
          onTap: (){

            MatchesCubit.get(context).getSquad( model[index].teamJson.id);
            MatchesCubit.get(context).championsTeam(model[index].teamJson.id,search: true);
            MatchesCubit.get(context).detailsVenueTeam(   model[index].teamJson.id);
            MatchesCubit.get(context).matchesForTeamFun(model[index].teamJson.id);
            //navigatorReuse(context,Team(idTeam:   model[index].teamJson.id,));
            Navigator.of(context).push(createRoute(Team(idTeam:   model[index].teamJson.id,),-1,0));

            // navigatorReuse(context, SquadTeam(idTeam: model[index].teamJson.id,leagueId:model[index]. ,));
            //print(model[index].teamJson.id);
          },
          child: Row(
            children: [
            CircleAvatar(
              radius: width*.05,
              backgroundColor: Colors.white.withOpacity(0),
              child: Image(image: NetworkImage(model[index].teamJson.logo),),
            ),
            Text('  ${model[index].teamJson.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:width *.06),overflow: TextOverflow.ellipsis,maxLines: 2,)
          ],),
        ),
        SizedBox(height: height*.01,),
      ],
    );
  }
}
