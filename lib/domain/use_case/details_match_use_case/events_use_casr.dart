import 'package:sofa_sccore/domain/entities/details_match/events_match.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class GetEventsUseCase{
  final BaseFootballTeams baseFootballTeams;

  GetEventsUseCase(this.baseFootballTeams);
  Future<List<EventsEntity>> execute(dynamic idFixtures)async{
    return await baseFootballTeams.getEvents(idFixtures);
  }
}