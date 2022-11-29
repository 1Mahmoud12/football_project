
import 'package:get_it/get_it.dart';
import 'package:sofa_sccore/data/repository/football_repository.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';
import 'package:sofa_sccore/domain/use_case/Team/champions_use_case.dart';
import 'package:sofa_sccore/domain/use_case/details_match_use_case/events_use_casr.dart';
import 'package:sofa_sccore/domain/use_case/details_match_use_case/fixtures_lineup_use_case.dart';
import 'package:sofa_sccore/domain/use_case/Team/info_venue_team_use_case.dart';
import 'package:sofa_sccore/domain/use_case/details_match_use_case/statistics_use_casr.dart';
import 'package:sofa_sccore/domain/use_case/league/standing_league_use_case.dart';
import 'package:sofa_sccore/domain/use_case/live_use_case.dart';
import 'package:sofa_sccore/domain/use_case/player/statistics_player_use_case.dart';
import 'package:sofa_sccore/domain/use_case/search_use_case.dart';
import 'package:sofa_sccore/domain/use_case/Team/matches_for_team_use_case.dart';
import 'package:sofa_sccore/domain/use_case/Team/squad_use_case.dart';

import '../../../data/data_source/remote_data_source.dart';
import '../../../domain/use_case/get_all_games_use_case.dart';
import '../../../domain/use_case/Team/standing_league_use_case.dart';
import '../../../domain/use_case/player/transfer_use_case.dart';

final seGet=GetIt.instance;


class ServiceGetIt{

void init()
{
  /// Data Source
  seGet.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  /// Repository
  seGet.registerLazySingleton<BaseFootballTeams>(() => FootballRepository(seGet()));

  ///USE CASE
  seGet.registerLazySingleton<GetAllGamesUseCase>(() => GetAllGamesUseCase(seGet()));
  seGet.registerLazySingleton<GetFixturesAndLineup>(() => GetFixturesAndLineup(seGet()));
  seGet.registerLazySingleton<SquadsUseCase>(() => SquadsUseCase(seGet()));
  seGet.registerLazySingleton<StandingLeagueUseCase>(() => StandingLeagueUseCase(seGet()));
  seGet.registerLazySingleton<MatchesForTeam>(() => MatchesForTeam(seGet()));
  seGet.registerLazySingleton<SearchUseCase>(() => SearchUseCase(seGet()));
  seGet.registerLazySingleton<SearchLeagueUseCase>(() => SearchLeagueUseCase(seGet()));
  seGet.registerLazySingleton<ChampionsUseCase>(() => ChampionsUseCase(seGet()));
  seGet.registerLazySingleton<InfoVenueTeamUseCase>(() => InfoVenueTeamUseCase(seGet()));
  seGet.registerLazySingleton<StatisticsPlayerUseCase>(() => StatisticsPlayerUseCase(seGet()));
  seGet.registerLazySingleton<TransferUseCase>(() => TransferUseCase(seGet()));
  seGet.registerLazySingleton<LiveUseCase>(() => LiveUseCase(seGet()));
  seGet.registerLazySingleton<StatisticsUseCase>(() => StatisticsUseCase(seGet()));
  seGet.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase(seGet()));
}


}