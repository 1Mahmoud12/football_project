import 'package:sofa_sccore/domain/entities/live_entity.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../../data/models/search_teams_model.dart';

class LiveUseCase
{
  final BaseFootballTeams baseFootballTeams;

  LiveUseCase(this.baseFootballTeams);

  Future<LiveEntity> execute(int idFixtures)async {
    return await baseFootballTeams.liveMatch(idFixtures);
  }
}