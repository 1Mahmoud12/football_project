
import 'package:sofa_sccore/domain/entities/team/champions_team.dart';

class ChampionsModel extends ChampionEntity
{
  ChampionsModel(super.json);
  factory ChampionsModel.fromJson(Map <String,dynamic>? json)  => ChampionsModel(json!);
}

