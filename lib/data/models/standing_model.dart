
import 'package:sofa_sccore/domain/entities/team/standing.dart';

class StandingTeamModel extends StandingTeam
{
  StandingTeamModel(super.json);
  factory StandingTeamModel.fromJson(Map<String,dynamic>json)=>StandingTeamModel(json);
}