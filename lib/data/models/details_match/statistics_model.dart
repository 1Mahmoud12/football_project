

import '../../../domain/entities/details_match/statistics_match.dart';

class StatisticsModel extends StatisticsMatch
{
  StatisticsModel(super.json);
  factory StatisticsModel.fromJson(Map <String,dynamic>json)  => StatisticsModel(json);
}

