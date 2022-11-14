import 'package:sofa_sccore/domain/entities/team/champions_team.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class ChampionsUseCase{
  final BaseFootballTeams baseFootballTeams;

  ChampionsUseCase(this.baseFootballTeams);
  Future<List<ChampionEntity>> execute(int teamId,String season)async{
    return await baseFootballTeams.champions(teamId, season);
  }
}