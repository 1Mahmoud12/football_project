import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../../data/models/search_teams_model.dart';

class SearchUseCase
{
  final BaseFootballTeams baseFootballTeams;

  SearchUseCase(this.baseFootballTeams);

  Future<List<SearchTeamsModel>> execute(String search)async {
    return await baseFootballTeams.searchTeam(search);
  }
}