import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/entities/details_match/fixtures_lineup.dart';
import 'package:sofa_sccore/domain/entities/league/standing_league.dart';
import 'package:sofa_sccore/domain/entities/live_entity.dart';
import 'package:sofa_sccore/domain/entities/player/transfer_entity.dart';
import 'package:sofa_sccore/domain/entities/team/champions_team.dart';
import 'package:sofa_sccore/domain/entities/team/squad.dart';

import '../../data/models/standing_model.dart';
import '../entities/details_match/statistics_match.dart';
import '../entities/player/player_details_entity.dart';


abstract class BaseFootballTeams{
  Future<List<SearchTeamsModel>> searchTeam(String search);
  Future<List<StandingLeague>> searchLeague(String search);
  Future<SearchTeamsModel?> infoVenueTeam(int idTeam);
  Future<List<ResponseFixtures>> matchesForTeam(int team);
  Future<List<ResponseFixtures>> getAllGames(String fromDate,String toDate);
  Future<List<FixturesAndLineup>> getFixturesAndLineup(dynamic id);
  Future<Squads> getSquad(int id);
  Future<StandingTeamModel> standing(int leagueId);
  Future<List<ChampionEntity>> champions(int teamId);
  Future<PlayerDetailsEntities?> statisticsPlayer(int idPlayer);
  Future<List<Transfers?>> transferPlayer(int idPlayer);
  Future<LiveEntity> liveMatch(int idFixtures);
  Future<List<StatisticsMatch>> getStatistics(int idFixtures);
  Future<void> getEvents(int idFixtures);
}