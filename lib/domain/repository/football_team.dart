import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/entities/fixtures_lineup.dart';
import 'package:sofa_sccore/domain/entities/league/standing_league.dart';
import 'package:sofa_sccore/domain/entities/live_entity.dart';
import 'package:sofa_sccore/domain/entities/player/transfer_entity.dart';
import 'package:sofa_sccore/domain/entities/team/champions_team.dart';
import 'package:sofa_sccore/domain/entities/team/squad.dart';
import 'package:sofa_sccore/domain/entities/team/standing.dart';

import '../../data/models/standing_model.dart';
import '../entities/player/player_details_entity.dart';


abstract class BaseFootballTeams{
  Future<List<SearchTeamsModel>> searchTeam(String search);
  Future<List<StandingLeague>> searchLeague(String search);
  Future<SearchTeamsModel?> infoVenueTeam(int idTeam);
  Future<List<ResponseFixtures>> matchesForTeam(int team,int season);
  Future<List<ResponseFixtures>> getAllGames(String season,String fromDate,String toDate);
  Future<List<FixturesAndLineup>> getFixturesAndLineup(dynamic id);
  Future<Squads> getSquad(int id);
  Future<StandingTeamModel> standing(int leagueId,String season);
  Future<List<ChampionEntity>> champions(int teamId,String season);
  Future<PlayerDetailsEntities?> statisticsPlayer(int idPlayer,String season);
  Future<List<Transfers?>> transferPlayer(int idPlayer);
  Future<LiveEntity> liveMatch(int idFixtures);
}