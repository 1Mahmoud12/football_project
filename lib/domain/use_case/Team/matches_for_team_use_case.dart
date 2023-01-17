import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class MatchesForTeam{
  final BaseFootballTeams baseFootballTeams;

  MatchesForTeam(this.baseFootballTeams);
  Future<List<ResponseFixtures>> execute(int team) async
  {
    return await baseFootballTeams.matchesForTeam(team);
  }
}