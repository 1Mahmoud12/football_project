import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofa_sccore/core/utils/strings.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/data/models/transfer_model.dart';
import 'package:sofa_sccore/presentation/bloc/cubit.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import 'package:widget_arrows/arrows.dart';
import 'package:widget_arrows/widget_arrows.dart';

class DetailsPlayer extends StatelessWidget {
  const DetailsPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;


    return BlocBuilder<MatchesCubit,MatchesState>(
      builder: (context,state)=> Scaffold(
        body:ConditionalBuilder(
            condition: RemoteDataSource.modelStatistics!= null,
            builder:(context) {
              var modelStatistics = RemoteDataSource.modelStatistics;
              var modelTransfer = RemoteDataSource.modelTransfer.isNotEmpty?RemoteDataSource.modelTransfer:[];
              return Column(
                children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         CircleAvatar(
                           radius: 25,
                           backgroundColor: Colors.black.withOpacity(0),
                           child: Image(image: NetworkImage(modelStatistics!.playerInfo.photo)),
                         ),
                         SizedBox(width: width*.05,),
                         Text(modelStatistics.playerInfo.name),


                       ],
              ),
                   ),
                   SizedBox(height: height*.03,),
                   ///Team Name
                   Padding(
                     padding: const EdgeInsets.only(left:  8.0),
                     child: Row(
                       children: [
                         CircleAvatar(
                           radius: 20,
                           backgroundColor: Colors.white.withOpacity(0),
                           child: Image(image: NetworkImage(modelStatistics.statistics.team!.logo)),
                         ),
                         SizedBox(width: width*.05,),
                         Text(modelStatistics.statistics.team!.name),



                       ],
              ),
                   ),
                   SizedBox(height: height*.03,),
                   Row(
                     children: [
                         Expanded(child: Column(
                           children: [
                             Text( modelStatistics.playerInfo.nationality??'NS'),
                              Text( AppString.nationality,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                           ],
                         )),
                          Expanded(child: Column(
                            children: [
                              Text(' ${modelStatistics.playerInfo.age??'NS'} Years'),
                              Text(' ${modelStatistics.playerInfo.dateBirth??'NS'} ',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),),
                            ],
                          )),
                          Expanded(child: Column(
                            children: [
                              Text( modelStatistics.playerInfo.height??'NS'),
                               Text( AppString.height,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                            ],
                          )),


              ],),
                   SizedBox(height: height*.03,),
                   Row(
                     children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text( modelStatistics.statistics.game!.position??'NS'),
                          Text( AppString.position,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                        ],
                      )),
                      Expanded(
                          child: Column(
                            children: [
                              Text(modelStatistics.statistics.game!.rating.length>3?modelStatistics.statistics.game!.rating.substring(0,3):modelStatistics.statistics.game!.rating??'NS'),
                              Text(AppString.rate,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),),
                        ],
                      )),
                      Expanded(child: Column(
                        children: [
                          Text( modelStatistics.playerInfo.weight??'NS'),
                          Text( AppString.weight,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15)),
                    ],
                  )),


                ],),
                   SizedBox(height: height*.03,),
                  if(RemoteDataSource.modelTransfer.isNotEmpty)
                    Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children:const [
                                Expanded(flex:2,child: Text('Out Team')),
                                Expanded(flex:2,child: Text('Type')),
                                Expanded(child: Text('In Team'))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
              itemBuilder: (context,index)=>transfer(modelTransfer[index],),
              itemCount: modelTransfer.length,
              ),
                          ),]
                      ),
                    )
                    

          ],
        );
            },
            fallback: (context)=>  const Center(child: CircularProgressIndicator()))
      ),
    );
  }
  Widget transfer(TransferModel modelTransfer)
  {
    return Row(
      children: [
        Expanded(child: Column(
          children:  [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0),
              child: Image(image: NetworkImage(modelTransfer.teams.outTeam.logo??
                  'https://img.freepik.com/premium-psd/soccer-ball-isolated-3d-rendering_286925-255.jpg?size=338&ext=jpg&uid=R75154930')),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(modelTransfer.teams.outTeam.name??'NS')
          ],
        ),),
        Expanded(child: Column(
          children:  [

            Text(modelTransfer.type??'NS'),
            Text(modelTransfer.date.substring(0,7)??'NS'),

          ],
        ),),
        Expanded(child: Column(
          children:  [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0),
              child: Image(image: NetworkImage(modelTransfer.teams.inTeam.logo??
              'https://img.freepik.com/premium-psd/soccer-ball-isolated-3d-rendering_286925-255.jpg?size=338&ext=jpg&uid=R75154930')),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(modelTransfer.teams.inTeam.name??'NS')
          ],
        ),)
        
      ],
    );
  }
}
