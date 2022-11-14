import 'package:sofa_sccore/domain/entities/league/standing_league.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';


class SearchLeagueUseCase{
  final BaseFootballTeams baseFootballTeams;

  SearchLeagueUseCase(this.baseFootballTeams);
  Future<List<StandingLeague>> execute(String search)async{
    return await baseFootballTeams.searchLeague( search);
  }
}