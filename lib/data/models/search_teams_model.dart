import 'package:sofa_sccore/domain/entities/team_league.dart';

class SearchTeamsModel extends SearchTeams
{
  SearchTeamsModel(super.json);
   factory SearchTeamsModel.fromJson(Map <String,dynamic>json)  => SearchTeamsModel(json);
}

