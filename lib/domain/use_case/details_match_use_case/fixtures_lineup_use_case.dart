import 'package:sofa_sccore/domain/entities/details_match/fixtures_lineup.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class GetFixturesAndLineup{
  final BaseFootballTeams baseFootballTeams;

  GetFixturesAndLineup(this.baseFootballTeams);
  Future<List<FixturesAndLineup>> execute(dynamic id)async{
    return await baseFootballTeams.getFixturesAndLineup(id);
  }
}