import 'package:sofa_sccore/domain/entities/player/player_details_entity.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class StatisticsPlayerUseCase{
  final BaseFootballTeams baseFootballTeams;

  StatisticsPlayerUseCase(this.baseFootballTeams);
  Future<PlayerDetailsEntities?> execute(int idPlayer,String season)async{
    return await baseFootballTeams.statisticsPlayer(idPlayer, season);
  }
}