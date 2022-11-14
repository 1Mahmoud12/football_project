import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../../../data/models/search_teams_model.dart';

class InfoVenueTeamUseCase
{
  final BaseFootballTeams baseFootballTeams;

  InfoVenueTeamUseCase(this.baseFootballTeams);

  Future<SearchTeamsModel?> execute(int idTeam)async {
    return await baseFootballTeams.infoVenueTeam(idTeam);
  }
}