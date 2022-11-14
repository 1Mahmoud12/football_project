import 'package:sofa_sccore/domain/entities/team/squad.dart';

class SquadModel extends Squads{
  SquadModel(super.json);
  factory SquadModel.fromJson(Map<String,dynamic>json)=>SquadModel(json);
}