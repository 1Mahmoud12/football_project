import 'package:sofa_sccore/domain/entities/team/squad.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class SquadsUseCase{
  final BaseFootballTeams baseFootballTeams;

  SquadsUseCase(this.baseFootballTeams);
  Future<Squads> execute(int id) async
  {
    return await baseFootballTeams.getSquad(id);
  }
}