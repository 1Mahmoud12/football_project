import 'package:sofa_sccore/domain/entities/details_match/events_match.dart';

class EventsModel extends EventsEntity
{
  EventsModel(super.json);
  factory EventsModel.fromJson(Map <String,dynamic>json)  => EventsModel(json);
}

