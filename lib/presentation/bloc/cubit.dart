import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sofa_sccore/core/firebase/messaging.dart';
import 'package:sofa_sccore/core/network/local.dart';
import 'package:sofa_sccore/core/utils/constants.dart';
import 'package:sofa_sccore/core/utils/functions.dart';
import 'package:sofa_sccore/core/utils/services/get_it.dart';
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/entities/live_entity.dart';
import 'package:sofa_sccore/domain/entities/team/squad.dart';
import 'package:sofa_sccore/domain/use_case/Team/champions_use_case.dart';
import 'package:sofa_sccore/domain/use_case/Team/info_venue_team_use_case.dart';
import 'package:sofa_sccore/domain/use_case/details_match_use_case/events_use_casr.dart';
import 'package:sofa_sccore/domain/use_case/details_match_use_case/statistics_use_casr.dart';
import 'package:sofa_sccore/domain/use_case/league/standing_league_use_case.dart';
import 'package:sofa_sccore/domain/use_case/live_use_case.dart';
import 'package:sofa_sccore/domain/use_case/player/statistics_player_use_case.dart';
import 'package:sofa_sccore/domain/use_case/player/transfer_use_case.dart';
import 'package:sofa_sccore/domain/use_case/search_use_case.dart';

import 'package:sofa_sccore/domain/use_case/Team/squad_use_case.dart';
import 'package:sofa_sccore/domain/use_case/Team/standing_league_use_case.dart';
import 'package:sofa_sccore/presentation/bloc/states.dart';
import '../../domain/entities/league/standing_league.dart';
import '../../domain/use_case/details_match_use_case/fixtures_lineup_use_case.dart';
import '../../domain/use_case/get_all_games_use_case.dart';
import '../../domain/use_case/Team/matches_for_team_use_case.dart';

class MatchesCubit extends Cubit<MatchesState> {
  final GetAllGamesUseCase getAllGamesUseCase;
  final GetFixturesAndLineup getFixturesAndLineup;
  final SquadsUseCase squadsUseCase;
  final StandingLeagueUseCase standingUseCase;
  final MatchesForTeam matchesForTeam;
  final SearchUseCase searchUseCase;
  final SearchLeagueUseCase searchLeagueUseCase;
  final ChampionsUseCase championsUseCase;
  final InfoVenueTeamUseCase infoVenueTeam;
  final StatisticsPlayerUseCase statisticsPlayerUseCase;
  final TransferUseCase transferUseCase;
  final LiveUseCase liveUseCase;
  final StatisticsUseCase statisticsUseCase;
  final GetEventsUseCase eventsUseCase;

  MatchesCubit(
      this.getAllGamesUseCase,
      this.getFixturesAndLineup,
      this.squadsUseCase,
      this.standingUseCase,
      this.matchesForTeam,
      this.searchUseCase,
      this.championsUseCase,
      this.infoVenueTeam,
      this.statisticsPlayerUseCase,
      this.transferUseCase,
      this.liveUseCase,
      this.searchLeagueUseCase,
      this.statisticsUseCase,
      this.eventsUseCase,
     )
      : super(MatchesInitialState());

  static MatchesCubit get(context) => BlocProvider.of(context);

  int countAllGames =0;
  void increment(){
    countAllGames++;
    //emit(MatchesCountPlusState());
  }
  List<ResponseFixtures> sortModel=[];
  Future<void> allGames( fromDate, toDate) async {
    emit(MatchesGetAllGamesLoadingState());
    await GetAllGamesUseCase(seGet())
        .execute( fromDate, toDate)
        .then((value) {
        // print( SharedPreference.getData('fixtures'));
      sortModel=sortMatches(RemoteDataSource.modelOfFixtures!);
      emit(MatchesGetAllGamesSuccessState());
    }).catchError((error) {

      print(error.toString());
      emit(MatchesGetAllGamesErrorState());
    })
    ;
  }

  Future fixturesAndLineup(dynamic id) async {
    emit(MatchesFixturesAndLineupLoadingState());
    await GetFixturesAndLineup(seGet()).execute(id).then((value) {
      emit(MatchesFixturesAndLineupSuccessState());
    })/*.catchError((error) {
      print(error.toString());
      emit(MatchesFixturesAndLineupErrorState());
    })*/;
  }

  Squads? modelSquads;

  Future getSquad(int id) async {
    emit(MatchesGetSquadsLoadingState());

    await SquadsUseCase(seGet()).execute(id).then((value) {
      modelSquads = value;
      emit(MatchesGetSquadsSuccessState());
    }).catchError((error) {
      emit(MatchesGetSquadsErrorState());
    });
  }

  Future standing(int leagueId) async {
    emit(MatchesGetStandingLoadingState());

      await StandingLeagueUseCase(seGet()).execute(leagueId).then((value) {
      emit(MatchesGetStandingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MatchesGetStandingErrorState());
    });



  }


  Future matchesForTeamFun(int teamId) async {
    emit(MatchesGetMatchesForTeamLoadingState());
    return await MatchesForTeam(seGet()).execute(teamId).then((value) {
      emit(MatchesGetMatchesForTeamSuccessState());
    }).catchError((error) {
      emit(MatchesGetMatchesForTeamErrorState());
    });
  }

  List<ResponseFixtures> modelFavorites = [];
  int countListFavorites=0;
  double index=0.0;

  Future matchesForTeamFavorites(int teamId) async {
    emit(MatchesGetMatchesForTeamFavoritesLoadingState());
    modelFavorites = [];
    return await MatchesForTeam(seGet()).execute(teamId).then((value) {
      modelFavorites.addAll(value);
      countListFavorites++;

      emit(MatchesGetMatchesForTeamFavoritesSuccessState());

    }).catchError((error) {
      print(error);
      emit(MatchesGetMatchesForTeamFavoritesErrorState());
    });
  }

  Future searchTeam(String search) async {
    emit(MatchesSearchTeamLoadingState());
    await SearchUseCase(seGet()).execute(search).then((value) {
      emit(MatchesSearchTeamSuccessState());
    }).catchError((onError) {
      emit(MatchesSearchTeamErrorState());
    });
  }
  Future searchLeague(String search) async {
    emit(MatchesSearchLeagueLoadingState());
    await SearchLeagueUseCase(seGet()).execute(search).then((value) {
      emit(MatchesSearchLeagueSuccessState());
    }).catchError((onError) {
      emit(MatchesSearchLeagueErrorState());
    });
  }
  bool checkMode = false;

  void mode({bool? mode}) {
    if (mode == null) {
      checkMode = !checkMode;
    } else {
      checkMode = mode;
    }
    emit(MatchesModeSuccessState());
    SharedPreference.putDataBool('mode', checkMode);
  }

  bool checkFavorites = false;

  void selectFavorites(int idTeam) {
    checkFavorites = false;
    for (int i = 0; i < Constants.favorites.length; i++) {
      if (Constants.favorites[i] == idTeam) {
        checkFavorites = true;

        // break;
      }
    }
    print(checkFavorites);
    emit(MatchesSelectFavoritesState());
  }

  void favorites(int idTeam) {
    if (checkFavorites == true) {
      checkFavorites = false;
      Constants.favorites.remove(idTeam);
      emit(MatchesTeamsFavoritesRemoveState());
    } else {
      checkFavorites = true;
      Constants.favorites.add(idTeam);
      SharedPreference.putDataStringList('favorites', Constants.favorites)
          .then((value) {
        emit(MatchesTeamsFavoritesSuccessState());
      }).catchError((onError) {
        emit(MatchesTeamsFavoritesErrorState());
      });
    }
  }

  Future championsTeam(int teamId, {bool search =false}) async {
    emit(MatchesChampionsTeamLoadingState());
    return await championsUseCase.execute(teamId).then((value) {
      if(search) {
        standing(championsLeague()[0].league!.id);
      }
      emit(MatchesChampionsTeamSuccessState());
    });
  }

  Future detailsVenueTeam(int idTeam, ) async {
    emit(MatchesInfoVenueLoadingState());
    return await InfoVenueTeamUseCase(seGet()).execute(idTeam).then((value) {
      emit(MatchesChampionsTeamSuccessState());
    });
  }

  Future statisticsPlayer(int idPlayer, ) async {
    emit(MatchesStatisticsPlayerLoadingState());
    return await StatisticsPlayerUseCase(seGet())
        .execute(idPlayer)
        .then((value) {
      emit(MatchesStatisticsPlayerSuccessState());
    });
  }

  Future transferPlayer(int idPlayer) async {
    emit(MatchesTransferPlayerLoadingState());
    return await TransferUseCase(seGet()).execute(idPlayer).then((value) {
      emit(MatchesTransferPlayerSuccessState());
    });
  }


  Future<void> getStatistics(int id) async {
    emit(MatchesGetStatisticsLoadingState());
    await StatisticsUseCase(seGet())
        .execute(id)
        .then((value) {
      // print( SharedPreference.getData('fixtures'));

      emit(MatchesGetStatisticsSuccessState());
    }).catchError((error) {

      print(error.toString());
      emit(MatchesGetStatisticsErrorState());
    })
    ;
  }


  Future<void> getEvents(int idFixture) async {
    emit(MatchesGetEventsLoadingState());
    await GetEventsUseCase(seGet())
        .execute(idFixture)
        .then((value) {
      // print( SharedPreference.getData('fixtures'));

      emit(MatchesGetEventsSuccessState());
    })/*.catchError((error) {

      print(error.toString());
      emit(MatchesGetEventsErrorState());
    })*/
    ;
  }








  Map<int,LiveEntity> modelLive={};
  List<bool> liveDate = [];
  Map<int,Duration> matchDuration = {};
  List<Timer>? countUpTimer=[];
  Future liveMatch(int idFixtures) async {
    emit(MatchesLiveLoadingState());


   return await LiveUseCase(seGet()).execute(idFixtures).then((value) {

     modelLive[idFixtures]=value;

     for(int i=0;i<RemoteDataSource.modelOfFixtures!.length;i++){
       if( value.fixture.idFixture==sortModel[i].fixtures.idFixtures){
         sortModel[i].goals.homeGoals =value.teams.homeGoals;
         sortModel[i].goals.awayGoals=value.teams.awayGoals;
         sortModel[i].fixtures.longTime=value.fixture.statusLong;
         print('${sortModel[i].goals.homeGoals} : ${sortModel[i].goals.awayGoals}');

         matchDuration[sortModel[i].fixtures.idFixtures]= Duration(seconds:int.parse(value.fixture.seconds.substring(value.fixture.seconds.length-2)) ,minutes: value.fixture.elapsed);
         Timer? timer;
         bool checkStopTimer=false;
         if(value.status.stopped){
           stopTimer(i);
           timer=Timer.periodic(const Duration(minutes: 1), (t) {
             checkStopTimer=true;
             liveMatch(idFixtures);
           });
         }
         if(checkStopTimer){
           timer!.cancel();
           startTimer(i, sortModel);
         }

          if(value.status.finished||value.fixture.statusLong=='Match Finished'){
            stopTimer(i);
            liveDate[i]=false;

          }

       }
     }

      emit(MatchesLiveSuccessState());
    }).catchError((error){
     emit(MatchesLiveErrorState());
      print(error.toString());

   });
  }


  void timeToStartLive(List<ResponseFixtures> model, context) {
        print('time to start live');
    for (int i = 0; i < model.length; i++) {
      liveDate.add(false);
      matchDuration[model[i].fixtures.idFixtures]=Duration.zero;
      countUpTimer!.add(Timer(const Duration(seconds: 0), () { }));
    }
    for (int i = 0; i < model.length; i++) {

      bool toDay=DateFormat('yyyy-MM-dd').format(DateTime.now())==(DateFormat('yyyy-MM-dd').format(DateTime.parse(model[i].fixtures.date.substring(0,10))));
      int hour = (int.parse(model[i].fixtures.date.substring(11, 13)))-DateTime.now().hour;
      int minutes = (int.parse(model[i].fixtures.date.substring(14, 16)))-DateTime.now().minute;

      if(toDay &&hour+2>0 &&false) {


        Timer(Duration(hours: hour,minutes: minutes), () {
          emit(MatchesLiveState());

          liveDate[i] = true;
        startTimer(i,sortMatches(RemoteDataSource.modelOfFixtures!));
        liveMatch(model[i].fixtures.idFixtures);

        });
      }

    }
  }

  void startTimer(int index,List<ResponseFixtures> model){

    countUpTimer![index]=Timer.periodic(const Duration(seconds: 1), (timer) {
      checkCount(index,model);});
    liveMatch(model[index].fixtures.idFixtures);

  }


  void stopTimer(index) {
   countUpTimer![index].cancel();
    emit(MatchesStopTimerState());
  }

  void checkCount(index,List<ResponseFixtures> model) {
    var plusSecondBy = 1;
    int seconds = matchDuration[model[index].fixtures.idFixtures]!.inSeconds + plusSecondBy;
    if (seconds > 20000) {
      countUpTimer![index].cancel();
    } else {
      if(seconds%180==0){
        print('minutes + 2');
        liveMatch(model[index].fixtures.idFixtures);
        emit(MatchesContinueState());
      }
      matchDuration[model[index].fixtures.idFixtures] = Duration(seconds: seconds);
      emit(MatchesContinueState());
    }
  }
  List<StandingLeague> selectedOneLeague=[];

  void selectedLeague(StandingLeague model,bool check){
    emit(MatchesAddLeagueState());
      check?selectedOneLeague.add(model):selectedOneLeague.remove(model);
  }
  void messageFirebase(){
      const Messaging().message();
      emit(MatchesMessageState());
  }
}
