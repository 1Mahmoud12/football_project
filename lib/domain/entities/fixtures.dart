
class ResponseFixtures{
late Fixtures fixtures;
late League league;
late Teams teams;
late Goals goals;
ResponseFixtures(Map<String,dynamic>json){
  fixtures=Fixtures.fromJson(json['fixture']);
  league=League.fromJson(json['league']);
  teams=Teams.fromJson(json['teams']);
  goals=Goals.fromJson(json['goals']);
}
}
class Fixtures {
dynamic referee;
dynamic shortTime;
String? longTime;
dynamic elapsed;
dynamic date;
dynamic idFixtures;

  Fixtures.fromJson(Map<String,dynamic>json){
   referee=json['referee'];
   shortTime=json['status']['short'];
   longTime=json['status']['long'].substring(5);
   elapsed=json['status']['elapsed']??-1;
   date=json['date'];
   idFixtures=json['id'];
  }
}
class League {
  dynamic name;
  dynamic logo;
  dynamic group;
  dynamic idLeague;
  League.fromJson(Map<String,dynamic>json){
    name=json['name'];
    logo=json['logo'];
    group=json['round'];
    idLeague=json['id'];
  }
}
class Teams {
  dynamic homeName;
  dynamic homeLogo;
  dynamic homeWinner;
  dynamic awayName;
  dynamic awayLogo;
  dynamic awayWinner;
  dynamic idHome;
  dynamic idAway;
  Teams.fromJson(Map<String,dynamic>json){
    homeName=json['home']['name'];
    homeLogo=json['home']['logo'];
    homeWinner=json['home']['winner'];
    idHome=json['home']['id'];
    awayName=json['away']['name'];
    awayLogo=json['away']['logo'];
    idAway=json['away']['id'];
  }
}
class Goals {
  dynamic homeGoals;
  dynamic awayGoals;
  Goals.fromJson(Map<String,dynamic>json){
    homeGoals=json['home']??0;
    awayGoals=json['away']??0;
  }
}