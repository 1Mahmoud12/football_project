
import 'package:sofa_sccore/data/data_source/remote_data_source.dart';
import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:sofa_sccore/data/models/transfer_model.dart';
import 'package:sofa_sccore/domain/entities/details_match/events_match.dart';
import 'package:sofa_sccore/domain/entities/details_match/statistics_match.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/entities/details_match/fixtures_lineup.dart';
import 'package:sofa_sccore/domain/entities/league/standing_league.dart';
import 'package:sofa_sccore/domain/entities/live_entity.dart';
import 'package:sofa_sccore/domain/entities/player/player_details_entity.dart';
import 'package:sofa_sccore/domain/entities/team/champions_team.dart';
import 'package:sofa_sccore/domain/entities/team/squad.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../models/standing_model.dart';
import '../models/details_match/statistics_model.dart';

class FootballRepository implements BaseFootballTeams
{
   final BaseRemoteDataSource baseRemoteDataSource;

  FootballRepository(this.baseRemoteDataSource);

  @override
  Future<List<SearchTeamsModel>> searchTeam(String search) async{
        return await baseRemoteDataSource.searchTeam(search);
  }

  @override
  Future<List<ResponseFixtures>> getAllGames(int season,String fromDate,String toDate) async{
    return await baseRemoteDataSource.getAllGames( season, fromDate, toDate);

  }

  @override
  Future<List<FixturesAndLineup>> getFixturesAndLineup(dynamic id) async{
    return await baseRemoteDataSource.getFixturesAndLineup(id);

  }

  @override
  Future<Squads> getSquad(int id) async{
   return await baseRemoteDataSource.getSquad(id);
  }

  @override
  Future<StandingTeamModel> standing(int leagueId, String season) async{
    return await baseRemoteDataSource.standingLeague(leagueId,season);

  }

  @override
  Future<List<ResponseFixtures>> matchesForTeam(int team, int season) async{
    return await baseRemoteDataSource.matchesForTeam(team, season);
  }

  @override
  Future<List<ChampionEntity>> champions(int teamId, String season) async{
    return await baseRemoteDataSource.champions(teamId, season);

  }

  @override
  Future<SearchTeamsModel?> infoVenueTeam(int idTeam) async{
    return await baseRemoteDataSource.infoVenueTeam(idTeam);

  }

  @override
  Future<PlayerDetailsEntities?> statisticsPlayer(int idPlayer, String season) async{
    return await baseRemoteDataSource.statisticsPlayer(idPlayer,season);

  }
   @override
  Future<List<TransferModel?>> transferPlayer(int idPlayer) async{
    return await baseRemoteDataSource.transferPlayer(idPlayer);

  }

  @override
  Future<LiveEntity> liveMatch(int idFixtures) async{
    return await baseRemoteDataSource.liveMatch(idFixtures);

  }

  @override
  Future<List<StandingLeague>> searchLeague(String search) async{
    return await baseRemoteDataSource.searchLeague(search);

  }

  @override
  Future<List<StatisticsMatch>> getStatistics(int idFixtures) async{
    return await baseRemoteDataSource.getStatistics(idFixtures);

  }

  @override
  Future<List<EventsEntity>> getEvents(int idFixtures) async{
    return await baseRemoteDataSource.getEvents(idFixtures);

  }

}