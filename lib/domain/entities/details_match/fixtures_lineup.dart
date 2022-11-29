
class FixturesAndLineup{
dynamic id;
dynamic name;
dynamic logo;
dynamic playerColorPrimary;
dynamic playerColorBorder;
dynamic playerColorNumber;
dynamic goalKeeperColorPrimary;
dynamic goalKeeperColorBorder;
dynamic goalKeeperColorNumber;
dynamic formation;
List<StartXI> startXI=[];
List<Substitutes> substitutes=[];
dynamic coachId;
dynamic coachName;
dynamic coachPhoto;

  FixturesAndLineup(Map<String,dynamic> json)
  {
    id=json['team']['id'];
    name=json['team']['name'];
    logo=json['team']['logo'];
    playerColorPrimary=json['team']['colors']['player']['primary'];
    playerColorBorder=json['team']['colors']['player']['border'];
    playerColorNumber=json['team']['colors']['player']['number'];
    goalKeeperColorPrimary=json['team']['colors']['player']['primary'];
    goalKeeperColorBorder=json['team']['colors']['player']['border'];
    goalKeeperColorNumber=json['team']['colors']['player']['number'];
    formation=json['formation'];
    json['startXI'].forEach(( element) {
      startXI.add(StartXI(element));

    });
    json['substitutes'].forEach((element) {
      substitutes.add(Substitutes(element));
    });
    coachId=json['coach']['id'];
    coachName=json['coach']['name'];
    coachPhoto=json['coach']['photo'];
  }

}
class StartXI{
  dynamic id;
  dynamic name;
  dynamic number;
  dynamic pos;
  dynamic grid;
  StartXI(Map<String,dynamic> json){
    id=json['player']['id'];
    name=json['player']['name'];
    number=json['player']['number'];
    pos=json['player']['pos'];
    grid=json['player']['grid'];
  }
}

class Substitutes{
  dynamic id;
  dynamic name;
  dynamic number;
  dynamic pos;
  dynamic grid;
  Substitutes(Map<String,dynamic> json){
    id=json['player']['id'];
    name=json['player']['name'];
    number=json['player']['number'];
    pos=json['player']['pos'];
  }
}
