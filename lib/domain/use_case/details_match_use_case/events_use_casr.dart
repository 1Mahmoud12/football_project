import 'package:sofa_sccore/domain/repository/football_team.dart';

class GetEventsUseCase{
  final BaseFootballTeams baseFootballTeams;

  GetEventsUseCase(this.baseFootballTeams);
  Future<void> execute(dynamic idFixtures)async{
    return await baseFootballTeams.getEvents(idFixtures);
  }
}