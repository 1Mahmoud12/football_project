import 'package:sofa_sccore/domain/entities/live_entity.dart';

class LiveMatchModel extends LiveEntity
{
  LiveMatchModel(super.json);
  factory LiveMatchModel.fromJson(Map <String,dynamic>json)  => LiveMatchModel(json);
}

