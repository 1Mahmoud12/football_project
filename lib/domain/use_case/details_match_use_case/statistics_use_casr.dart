import 'package:sofa_sccore/domain/repository/football_team.dart';

import '../../../data/models/details_match/statistics_model.dart';
import '../../entities/details_match/statistics_match.dart';

class StatisticsUseCase{
  final BaseFootballTeams baseFootballTeams;

  StatisticsUseCase(this.baseFootballTeams);
  Future<List<StatisticsMatch>> execute(dynamic id)async{
    return await baseFootballTeams.getStatistics(id);
  }
}