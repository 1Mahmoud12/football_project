import 'package:sofa_sccore/domain/entities/fixtures.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class GetAllGamesUseCase
{
  final BaseFootballTeams teamEngland;

  GetAllGamesUseCase(this.teamEngland);

  Future<List<ResponseFixtures>> execute(int season,String fromDate,String toDate)async {
    return await teamEngland.getAllGames(season, fromDate,toDate);
  }
}