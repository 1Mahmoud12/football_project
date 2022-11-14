class Squads{
  late Team team;
  late List<Player> player;

  Squads(Map<String,dynamic>json)
  {
    team=Team(json['team']);
    player=[];
      json['players'].forEach((element){
     player.add(Player(element));
   });
  }


}
class Team
{
  dynamic id;
  dynamic name;
  dynamic logo;
  Team(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    logo=json['logo'];
  }
}
class Player{
  dynamic id;
  dynamic name;
  dynamic age;
  dynamic number;
  dynamic photo;
  dynamic position;
  Player(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    age=json['age'];
    number=json['number'];
    position=json['position'];
    photo=json['photo'];
  }
}