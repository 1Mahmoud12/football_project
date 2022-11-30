class EventsEntity{
  late Time time;
  late Teams team;
  late Player player;
  late Assist assist;
  late dynamic type;
  late dynamic detail;
  late dynamic comments;
  EventsEntity(Map<String,dynamic> json){
    time=Time(json['time']);
    team=Teams(json['team']);
    player=Player(json['player']);
    assist=Assist(json['assist']);
    type=json['type']??"NS";
    detail=json['detail']??"NS";
    comments=json['comments']??"NS";
  }
}

class Time{
  dynamic elapsed;
  dynamic extra;

  Time(Map<String,dynamic> json){
    elapsed=json['elapsed'];
    extra=json['extra']??0;

  }
}

class Teams{
  dynamic id;
  dynamic name;
  dynamic logo;
  Teams(Map<String,dynamic> json){
    id=json['id']??0;
    name=json['name']??'NS';
    logo=json['logo']??'NS';
  }
}

class Player{
  dynamic id;
  String? namePlayer;

  Player(Map<String,dynamic> json){
    id=json['id']??0;
    namePlayer=json['name']??"NS";
  }
}

class Assist{
  dynamic id;
  dynamic name;
  Assist(Map<String,dynamic> json){
    id=json['id']??0;
    name=json['name']??'NS';
  }
}