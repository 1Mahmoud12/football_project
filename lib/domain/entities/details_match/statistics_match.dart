
class StatisticsMatch{

  late StatisticsTeam awayTeam;
  late StatisticsTeam homeTeam;

  StatisticsMatch(Map<String,dynamic> json)
  {
    homeTeam=StatisticsTeam(json['statistics']);
    awayTeam=StatisticsTeam(json['statistics']);
  }
}
class StatisticsTeam{
  dynamic shotsOnGoal;
  dynamic shotsOffGoal;
  dynamic totalShots;
  dynamic blockedShots;
  dynamic shotsInsideBox;
  dynamic shotsOutSideBox;
  dynamic fouls;
  dynamic cornerKicks;
  dynamic offsides;
  dynamic ballPossession;

  dynamic yellowCards;
  dynamic redCards;
  dynamic goalKeeperSaves;
  dynamic totalPasses;
  dynamic passesAccurate;
  dynamic passes;

  StatisticsTeam(List<dynamic> json)
  {
    shotsOnGoal=json[0]['value']??0;
    shotsOffGoal=json[1]['value']??0;
    totalShots=json[2]['value']??0;
    blockedShots=json[3]['value']??0;
    shotsInsideBox=json[4]['value']??0;
    shotsOutSideBox=json[5]['value']??0;
    fouls=json[6]['value']??0;
    cornerKicks=json[7]['value']??0;
    offsides=json[8]['value']??0;
    ballPossession=json[9]['value']??0;


    yellowCards=json[10]['value']??0;
    redCards=json[11]['value']??0;
    goalKeeperSaves=json[12]['value']??0;
    totalPasses=json[13]['value']??0;
    passesAccurate=json[14]['value']??0;
    passes=json[15]['value']??0;
  }
}