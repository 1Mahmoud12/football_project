import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/data/models/details_match/events_model.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';

import '../../../core/utils/functions.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../domain/entities/details_match/fixtures_lineup.dart';
import '../../../domain/entities/fixtures.dart';

class Events extends StatelessWidget {
  final ResponseFixtures responseFixture;

  const Events({Key? key,required this.responseFixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthMedia=MediaQuery.of(context).size.width;
    double heightMedia =MediaQuery.of(context).size.height;
    List<FixturesAndLineup> modelFixturesAndLineup = RemoteDataSource.fixturesAndLineup;
    return Scaffold(
      body:BlocBuilder<MatchesCubit,MatchesState>(
        builder: (context,state)=> Padding(
          padding: const EdgeInsets.all(15.0),
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
                          backgroundColor:
                          Colors.white.withOpacity(0),
                          child: Image(
                            image: NetworkImage(responseFixture.teams.homeLogo),
                            height: 50,
                            width: widthMedia * .1,
                          )),
                    ),
                    const Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: widthMedia*.02),
                      child: CircleAvatar(
                          radius: widthMedia*.05,
                          backgroundColor:
                          Colors.white.withOpacity(0),
                          child: Image(
                            image: NetworkImage(responseFixture.teams.awayLogo),
                            height: 50,
                            width: widthMedia * .1,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height:heightMedia*.02 ,),
              ConditionalBuilder(
                condition: state is MatchesGetEventsSuccessState,
                builder: (state) {

                  List<EventsModel>  eventsModel =RemoteDataSource.eventsModel??[];


                  return RemoteDataSource.eventsModel!.isNotEmpty?Column(
                  children: [
                    SizedBox(
                      height: heightMedia*.67,
                      child: ListView.separated(

                        itemBuilder: (context,index) => eventsModel[index].team.id==modelFixturesAndLineup[0].id?Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    height: heightMedia*.03,
                                    child:eventsModel[index].type=='Goal'? SvgPicture.asset(color: MatchesCubit.get(context).checkMode?Colors.white:Colors.black,'assets/ball.svg',height: heightMedia*.03,)
                                        :Image.asset('${Constants.typeEvents[eventsModel[index].type]}')
                                ),
                                        SizedBox(height:heightMedia*.014 ,),
                                Row(
                                  children: [
                                    Text('${ eventsModel[index].time.elapsed>0?eventsModel[index].time.elapsed:0}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                                    if(eventsModel[index].time.extra!=0)
                                      Text(' +${  eventsModel[index].time.extra}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(width:widthMedia*.009 ,),
                             padMe(heightMedia,widthMedia),
                            SizedBox(width:widthMedia*.009 ,),
                            Column(
                              children: [
                                Center(
                                  child:Text('${ eventsModel[index].player.namePlayer}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.05),),
                                ),
                                SizedBox(height:heightMedia*.008 ,),
                                Text('${ eventsModel[index].type=='Goal'?'Ass : ${eventsModel[index].assist.name}':eventsModel[index].type}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                              ],
                            ),


                          ],
                        ):
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Text('${eventsModel[index].player.namePlayer}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: widthMedia*.05),),
                                  SizedBox(height:heightMedia*.008 ,),
                                  Text('${ eventsModel[index].type=='Goal'?'Ass : ${eventsModel[index].assist.name}':eventsModel[index].type}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                                ],
                              ),
                              SizedBox(width:widthMedia*.009 ,),
                              padMe(heightMedia,widthMedia),
                              SizedBox(width:widthMedia*.009 ,),
                              Column(
                                children: [
                                  SizedBox(
                                      height: heightMedia*.03,
                                      child:eventsModel[index].type=='Goal'? SvgPicture.asset(color: MatchesCubit.get(context).checkMode?Colors.white:Colors.black,'assets/ball.svg',height: heightMedia*.03,)
                                          :Image.asset('${Constants.typeEvents[eventsModel[index].type]}')
                                  ),
                                  SizedBox(height:heightMedia*.014 ,),
                                  Row(
                                    children: [
                                      Text('${ eventsModel[index].time.elapsed}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                                      if(eventsModel[index].time.extra!=0)
                                      Text(' +${  eventsModel[index].time.extra}',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),),
                                    ],
                                  )
                                ],
                              ),


                            ],
                          ),
                        itemCount:eventsModel.length ,
                        separatorBuilder: (context,index)=>SizedBox(height: heightMedia*.01,),
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),

                  ],
                )
                      : SizedBox(
                        height: heightMedia*.67,
                        child: const Center(child: Text('No Events Yet')),
                      );
                },
                fallback: (context)=>indicator()
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget padMe(double heightMedia,double widthMedia){
    return Container(
      color: Colors.grey[800],
      height:heightMedia*.08,
      width: widthMedia*.003,
    );
  }
}
