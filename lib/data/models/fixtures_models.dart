import '../../domain/entities/fixtures.dart';

class FixtureModel extends ResponseFixtures
{
  FixtureModel(super.json);
  factory FixtureModel.fromJson(Map <String,dynamic>json)  => FixtureModel(json);

}