import 'package:sofa_sccore/domain/entities/details_match/fixtures_lineup.dart';

class FixtureAndLineupModel extends FixturesAndLineup
{
  FixtureAndLineupModel(super.json);
  factory FixtureAndLineupModel.fromJson(Map <String,dynamic>json)  => FixtureAndLineupModel(json);
}

