import 'dart:convert';

import 'package:sofa_sccore/data/models/details_match/events_model.dart';
import 'package:sofa_sccore/data/models/live_match_model.dart';
import 'package:sofa_sccore/data/models/player/statistics_player_model.dart';
import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:http/http.dart' as http;
import 'package:sofa_sccore/data/models/transfer_model.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/entities/league/standing_league.dart';

import '../../core/network/local.dart';
import '../../core/utils/constants.dart';
import '../../domain/entities/details_match/statistics_match.dart';
import '../models/champions_model.dart';
import '../models/details_match/fixture_lineup_model.dart';
import '../models/squad_model.dart';
import '../models/standing_model.dart';

import '../models/details_match/statistics_model.dart';


abstract class BaseRemoteDataSource {

  Future<List<SearchTeamsModel>> searchTeam(String search);
  Future<SearchTeamsModel?> infoVenueTeam(int idTeam);
  Future<List<ResponseFixtures>> matchesForTeam(int team);
  Future<List<ResponseFixtures>> getAllGames( String fromDate,String toDate);
  Future<List<FixtureAndLineupModel>> getFixturesAndLineup(dynamic id);
  Future<SquadModel> getSquad(int id);
  Future<StandingTeamModel> standingLeague(int leagueId);
  Future<List<StandingLeague>> searchLeague(String search );
  Future<List<ChampionsModel>> champions(int teamId);
  Future<StatisticsPlayerModel?> statisticsPlayer(int idPlayer);
  Future<List<TransferModel?>> transferPlayer(int idPlayer);
  Future<dynamic> liveMatch(int idFixture);
  Future<List<StatisticsMatch>> getStatistics(int idFixture);
  Future<void> getEvents(int idFixture);


}

class RemoteDataSource implements BaseRemoteDataSource {
  static late List<SearchTeamsModel> searchModel ;
  @override
  Future<List<SearchTeamsModel>> searchTeam(String search) async {


    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[0]}?search=$search'),
        headers: Constants.headers);

    searchModel = List<SearchTeamsModel>.from(
        (jsonDecode(request.body)['response']).map((e) => SearchTeamsModel(e)));

    return searchModel;
  }

  static  SearchTeamsModel? infoTeam ;
  @override
  Future<SearchTeamsModel?> infoVenueTeam(int idTeam) async {

      print(idTeam);
      final request = await http.get(
          Uri.parse(
              '${Constants.api}/${Constants.endPoints[0]}?id=$idTeam'),
          headers: Constants.headers);
      if(jsonDecode(request.body)['results']>0) {
      infoTeam = SearchTeamsModel(jsonDecode(request.body)['response'][0]);
    }else{
      print(jsonDecode(request.body)['errors']);
    }

    return infoTeam;
  }


  static  List<ResponseFixtures>? modelOfFixtures;
  static String? today;
  static int countLeagueId = 0;
  @override
  Future<List<ResponseFixtures>> getAllGames( String fromDate,String toDate) async {
    modelOfFixtures = [];
    List<String> storeModel=[];
    for (countLeagueId = 0; countLeagueId < Constants.leagueId.length; countLeagueId++) {
      final request = await http.get(
          Uri.parse(
              '${Constants.api}/${Constants.endPoints[1]}?league=${Constants.leagueId[countLeagueId].toString()}&from=$fromDate&to=$toDate&season=${Constants.season}&timezone=${Constants.timezone}'),
          headers: Constants.headers);


      if (jsonDecode(request.body)['results'] > 0) {

        today=DateTime.now().toString().substring(11,13) ;
        SharedPreference.putDataString('today', today!);

        jsonDecode(request.body)['response'].forEach((element) {
          //print(element);
          modelOfFixtures!.add(ResponseFixtures(element));
          storeModel.add(jsonEncode(element));

        });

      }
      else{
        print("error : ${jsonDecode(request.body)['errors']}");

      }
    }

    SharedPreference.putDataStringListModel('fixtures', storeModel);

    return modelOfFixtures!;
  }

  static late List<FixtureAndLineupModel> fixturesAndLineup;

  @override
  Future<List<FixtureAndLineupModel>> getFixturesAndLineup(dynamic id) async{
    fixturesAndLineup = [];
      final request = await http.get(
          Uri.parse(
              '${Constants.api}/${Constants.endPoints[2]}?fixture=$id'),
          headers: Constants.headers);
    print(jsonDecode(request.body)['parameters']);

      if (jsonDecode(request.body)['results'] > 0) {
        jsonDecode(request.body)['response'].forEach((element) {
          fixturesAndLineup.add(FixtureAndLineupModel(element));
        });
      }else{
        print('result of jason lineUp : ${jsonDecode(request.body)['errors']}');

      }

    //print(fixturesAndLineup[0].name);

    return fixturesAndLineup;
  }

  static SquadModel? squad;

  @override
  Future<SquadModel> getSquad(int id) async{

    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[3]}?team=$id'),
        headers: Constants.headers);
    if (jsonDecode(request.body)['results'] > 0) {
      squad=SquadModel(jsonDecode(request.body)['response'][0]);
    }else{
      print(jsonDecode(request.body)['errors']);
    }
    return  squad!;
  }

  static StandingTeamModel? stand;

  @override
  Future<StandingTeamModel> standingLeague(int leagueId) async{
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[4]}?league=$leagueId&season=${Constants.season}'),
        headers: Constants.headers);
      print("standing league ${jsonDecode(request.body)['parameters']}");
    if (jsonDecode(request.body)['results'] > 0) {
      stand=StandingTeamModel(jsonDecode(request.body)['response'][0]['league']);
    }

   return stand!;
  }


  static late List<ResponseFixtures> modelMatchesForTeam;

  @override
  Future<List<ResponseFixtures>> matchesForTeam(int team)async {
    modelMatchesForTeam = [];

      final request = await http.get(
          Uri.parse(
              '${Constants.api}/${Constants.endPoints[1]}?team=$team&season=${Constants.season}'),
          headers: Constants.headers);
      print(jsonDecode(request.body)['parameters']);
      if (jsonDecode(request.body)['results'] > 0) {
        jsonDecode(request.body)['response'].forEach((element) {
          modelMatchesForTeam.add(ResponseFixtures(element));
        });
      }



    return modelMatchesForTeam;
  }
  static late List<ChampionsModel> modelChampionsTeam;

  @override
  Future<List<ChampionsModel>> champions(int teamId) async{
    modelChampionsTeam=[];
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[5]}?team=$teamId&season=${Constants.season}'),
        headers: Constants.headers);

    if (jsonDecode(request.body)['results'] > 0) {
      jsonDecode(request.body)['response'].forEach((element){
        modelChampionsTeam.add( ChampionsModel(element)); });

    }

    return  modelChampionsTeam;
  }

  static  StatisticsPlayerModel? modelStatistics;


  @override
  Future<StatisticsPlayerModel?> statisticsPlayer(int idPlayer ) async{

    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[6]}?id=$idPlayer&season=${Constants.season}'),
        headers: Constants.headers);
    print(jsonDecode(request.body)['parameters']);

    if (jsonDecode(request.body)['results'] > 0) {
     // print(jsonDecode(request.body)['response']);
        modelStatistics=StatisticsPlayerModel(jsonDecode(request.body)['response'][0]);

    }

    return  modelStatistics;
  }

  static late List<TransferModel> modelTransfer;
  @override
  Future<List<TransferModel?>> transferPlayer(int idPlayer) async{
    modelTransfer=[];
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[7]}?player=$idPlayer'),
        headers: Constants.headers);
    if (jsonDecode(request.body)['results'] > 0) {
      jsonDecode(request.body)['response'][0]['transfers'].forEach((element){
        modelTransfer.add( TransferModel(element)); });

    }

    return  modelTransfer;
  }
static  LiveMatchModel? liveModel;
  @override
  Future<dynamic> liveMatch(int idFixture) async{

    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[8]}?fixture=$idFixture'),
        headers: Constants.headers);

    if (jsonDecode(request.body)['results'] > 0) {
      liveModel=LiveMatchModel(jsonDecode(request.body)['response'][0]);
      return  liveModel!;

    }else{
       print(jsonDecode(request.body)['errors']);

    }


  }

  static List<StandingLeague>? changeLeaguesModel;
  @override
  Future<List<StandingLeague>> searchLeague(String search) async{
    changeLeaguesModel=[];
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[5]}?search=$search'),
        headers: Constants.headers);
    if (jsonDecode(request.body)['results'] > 0) {
      jsonDecode(request.body)['response'].forEach((element){
        changeLeaguesModel!.add(StandingLeague(element));

      });

    }else{
      print(jsonDecode(request.body)['errors']);

    }
    return changeLeaguesModel!;
  }
  static List<StatisticsMatch>? statisticsMatch;


  @override
  Future <List<StatisticsMatch>> getStatistics(int idFixture) async{
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[9]}?fixture=$idFixture'),
        headers: Constants.headers);
    if (jsonDecode(request.body)['results'] > 0) {
      statisticsMatch=[];
      print(jsonDecode(request.body)['response'][0]['statistics']);


      jsonDecode(request.body)['response'].forEach((element){
        statisticsMatch!.add(StatisticsModel(element));
      });

    }
    return  statisticsMatch??[];
  }
  static List<EventsModel>? eventsModel;

  @override
  Future<void> getEvents(int idFixture) async{
    eventsModel=[];
    final request = await http.get(
        Uri.parse(
            '${Constants.api}/${Constants.endPoints[10]}?fixture=$idFixture'),
        headers: Constants.headers);

    if (jsonDecode(request.body)['results'] > 0) {


      jsonDecode(request.body)['response'].forEach((element){
        if(element!=null) {
          eventsModel!.add(EventsModel(element));
        }
      });

    }

  }


}
