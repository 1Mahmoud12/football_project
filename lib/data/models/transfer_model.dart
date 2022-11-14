
import 'package:sofa_sccore/domain/entities/player/transfer_entity.dart';

class TransferModel extends Transfers
{
  TransferModel(super.json);
  factory TransferModel.fromJson(Map<String,dynamic>json)=>TransferModel(json);
}