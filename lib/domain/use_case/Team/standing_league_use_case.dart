import 'package:sofa_sccore/domain/entities/team/standing.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../../../data/models/standing_model.dart';

class StandingLeagueUseCase{
  final BaseFootballTeams baseFootballTeams;

  StandingLeagueUseCase(this.baseFootballTeams);
  Future<StandingTeamModel> execute(leagueId,season)async{
    return await baseFootballTeams.standing(leagueId, season);
  }
}