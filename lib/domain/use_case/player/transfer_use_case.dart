import 'package:sofa_sccore/domain/entities/player/transfer_entity.dart';
import 'package:sofa_sccore/domain/repository/football_team.dart';

class TransferUseCase{
  final BaseFootballTeams baseFootballTeams;

  TransferUseCase(this.baseFootballTeams);
  Future<List<Transfers?>> execute(int playerId)async{
    return await baseFootballTeams.transferPlayer(playerId);
  }
}