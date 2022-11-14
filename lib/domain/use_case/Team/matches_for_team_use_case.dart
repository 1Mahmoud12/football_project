import 'package:sofa_sccore/data/models/search_teams_model.dart';
import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class MatchesForTeam{
  final BaseFootballTeams baseFootballTeams;

  MatchesForTeam(this.baseFootballTeams);
  Future<List<ResponseFixtures>> execute(int team,int season) async
  {
    return await baseFootballTeams.matchesForTeam(team, season);
  }
}