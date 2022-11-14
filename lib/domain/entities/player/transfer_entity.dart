class Transfers{
  dynamic date;
  dynamic type;
  late Teams teams;
  Transfers(Map<String,dynamic>json){
      date=json['date'];
      type=json['type'];
      teams=Teams(json['teams']);
  }
}
class Teams{
  late InTeam inTeam;
  late OutTeam outTeam;

  Teams(Map<String,dynamic>json){
    inTeam=InTeam(json['in']);
    outTeam=OutTeam(json['out']);
  }
}

class InTeam{
  dynamic id;
  dynamic name;
  dynamic logo;
  InTeam(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    logo=json['logo'];
  }
}
class OutTeam{
  dynamic id;
  dynamic name;
  dynamic logo;
  OutTeam(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    logo=json['logo'];
  }
}