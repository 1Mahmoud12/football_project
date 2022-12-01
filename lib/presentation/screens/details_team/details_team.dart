import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/core/utils/strings.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/colors.dart';
import '../../../domain/entities/team/champions_team.dart';

class DetailsTeam extends StatelessWidget {
  const DetailsTeam({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var widthMedia = MediaQuery.of(context).size.width;
    var heightMedia = MediaQuery.of(context).size.height;
    return BlocBuilder<MatchesCubit, MatchesState>(
      builder: (context, state) {



        return Scaffold(
          body: ConditionalBuilder(
            condition:  RemoteDataSource.modelMatchesForTeam.isNotEmpty && RemoteDataSource.infoTeam !=null,
            builder: (context) {
              List<ChampionEntity> model = RemoteDataSource.modelChampionsTeam;
              SearchTeamsModel? modelInfo = RemoteDataSource.infoTeam;
              return SingleChildScrollView(
                child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.featuredMatch,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: heightMedia*.17,
                      child: featureMatch(context)),
                  separator(widthMedia),
                  Text(
                    AppString.tournaments,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: heightMedia*.01,),
                  SizedBox(

                    height:model.length>3? heightMedia*.25:heightMedia*.15,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.3,

                      children: List.generate(model.length, (index) => tournaments(model, index,context))

                        // RemoteDataSource.modelChampionsTeam[0].league.name
                      ,
                    ),
                  ),
                  separator(widthMedia),
                 info(context,modelInfo!)

                ],
            ),
              );
            },
            fallback: (context)=>indicator(),
          ),
        );
      },
    );
  }

  Widget tournaments(List<ChampionEntity> model, index,context) {
    return Column(
      children: [
        if(model[index].league!.name=='UEFA Champions League')
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Image(image: NetworkImage(model[index].league!.logo)),
        ), if(model[index].league!.name!='UEFA Champions League')
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black.withOpacity(0),
          child: Image(image: NetworkImage(model[index].league!.logo)),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(model[index].league!.name,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),maxLines: 4,)
      ],
    );
  }
  Widget info(context ,SearchTeamsModel modelInfo){
    var widthMedia=MediaQuery.of(context).size.width;
    var heightMedia=MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(AppString.info,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.05),),
            ],
          ),
        ),
        SizedBox(height: heightMedia*.001,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(AppString.foundationDate,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),),
              const Spacer(),
              Text(modelInfo.teamJson.founded.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.04),),

            ],
          ),
        ),
        SizedBox(height: heightMedia*.001,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(AppString.country,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),),
              const Spacer(),
              Text(modelInfo.teamJson.country.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.04),),

            ],
          ),
        ),
        SizedBox(height: heightMedia*.001,),
        separator(widthMedia),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(AppString.venue,style: Theme.of(context).textTheme.bodyText1,)
          ],),
        ),
        SizedBox(height: heightMedia*.001,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex:1,child: Text(AppString.nameVenue,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),)),
              const Spacer(),
              Expanded(flex:3,child: Text(modelInfo.venueJson.name.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.04),)),

            ],
          ),
        ),
        SizedBox(height: heightMedia*.001,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex:1,child: Text(AppString.address,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),)),
              const Spacer(),
              Expanded(flex:3,child: Text(modelInfo.venueJson.address.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.04),)),

            ],
          ),
        ),
        SizedBox(height: heightMedia*.001,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(AppString.capacity,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),),
              const Spacer(),
              Text(modelInfo.venueJson.capacity.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.04),),

            ],
          ),
        ),
        SizedBox(height: heightMedia*.01,),
        separator(widthMedia),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image(
              width: widthMedia,
              height: heightMedia*.2,

            fit: BoxFit.fitWidth,
              image: NetworkImage(modelInfo.venueJson.image,))

          ],
        ),
      ],
    );
  }
  Widget featureMatch(context) {
    var widthMedia = MediaQuery.of(context).size.width;
    var heightMedia = MediaQuery.of(context).size.height;

    ResponseFixtures? match;
    for(int id=0;id<RemoteDataSource.modelMatchesForTeam.length;id++){
      if(RemoteDataSource.modelMatchesForTeam[id].fixtures.shortTime=='NS')
        {
          match=RemoteDataSource.modelMatchesForTeam[id];
          break;
        }
    }

      return match!=null?Padding(
      padding: const EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0),
      child: Card(
        elevation: 0,
        color:AppColors.cardColor,
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.grey,
              borderRadius: BorderRadiusDirectional.circular(10)
          ),

          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.white.withOpacity(0),
                        child: Image(image:NetworkImage(match.league.logo??'https://img.freepik.com/premium-psd/soccer-ball-isolated-3d-rendering_286925-255.jpg?size=338&ext=jpg&uid=R75154930'),height:50,width: widthMedia*.08,)),
                    const SizedBox(width: 5,),
                    Text(match.league.name,style: Theme.of(context).textTheme.bodyText1,)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image(image:NetworkImage(match.teams.homeLogo),height:50,width: widthMedia*.08,),
                          SizedBox(height: heightMedia*.005,),
                          Text(match.teams.homeName,style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          if(match.goals.homeGoals!=null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('${match.goals.homeGoals} :',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.05),),
                                Text(match.goals.awayGoals.toString(),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.05)),

                              ],
                            ),

                          if(match.goals.homeGoals==null)
                            Column(
                              children: [
                                Text(subStringForDate(date: match.fixtures.date.toString()),style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),),
                                SizedBox(height: heightMedia*.01,),
                                Text(subStringForTime(time: match.fixtures.date.toString()),style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04) ,),
                              ],
                            ),
                          if(match.goals.homeGoals!=null)
                            Text(match.fixtures.shortTime,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04),)

                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          Image(image:NetworkImage(match.teams.awayLogo),height:50,width: widthMedia*.08,),
                          SizedBox(height:heightMedia*.005,),
                          Text(match.teams.awayName,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: widthMedia*.04)),
                        ],
                      ),
                    ),



                  ],
                ),
              ],
            ),
          ),

        ),
      ),
    ):Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('The ${AppString.featuredMatch} Not Selected',style: Theme.of(context).textTheme.bodyText1,)
        ],
      );
    }
  }


