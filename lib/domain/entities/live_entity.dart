class LiveEntity{
 late Fixture fixture;
  late League leagues;
  late Teams teams;
  late Status status;
  LiveEntity(Map<String,dynamic> json){
    fixture=Fixture(json['fixture']);
    leagues=League(json['league']);
    teams=Teams(json['teams']);
    status=Status(json['status']);
  }
}

class Fixture{
  dynamic idFixture;
  dynamic statusLong;
  dynamic elapsed;
  dynamic seconds;
  Fixture(Map<String,dynamic> json){
    idFixture=json['id'];
    statusLong=json['status']['long'];
    elapsed=json['status']['elapsed'];
    seconds=json['status']['seconds'];
  }
}

class Teams{
  dynamic homeId;
  dynamic homeGoals;
  dynamic awayId;
  dynamic awayGoals;
  Teams(Map<String,dynamic> json){
    homeId=json['home']['id'];
    homeGoals=json['home']['goals'];
    awayId=json['away']['id'];
    awayGoals=json['away']['goals'];
  }
}

class League{
  dynamic id;
  dynamic season;

  League(Map<String,dynamic> json){
    id=json['id'];
    season=json['season'];
  }
}

class Status{
  dynamic stopped;
  dynamic blocked;
  dynamic finished;
  Status(Map<String,dynamic> json){
    stopped=json['stopped'];
    blocked=json['blocked'];
    finished=json['finished'];
  }
}