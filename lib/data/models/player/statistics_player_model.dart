
import 'package:sofa_sccore/domain/entities/player/player_details_entity.dart';

class StatisticsPlayerModel extends PlayerDetailsEntities
{
  StatisticsPlayerModel(super.json);
  factory StatisticsPlayerModel.fromJson(Map <String,dynamic>? json)  => StatisticsPlayerModel(json!);
}

