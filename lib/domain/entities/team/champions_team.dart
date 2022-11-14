class ChampionEntity
{
  late League? league;
  late Country? country;
  dynamic standing;

  ChampionEntity(Map <String,dynamic>json){
    league= League(json['league']) ;
    country= Country(json['country']);
    standing= json['seasons'][0]['coverage']['standings'];
  }
}

class League
{
  dynamic id;
  dynamic name;
  dynamic type;
  dynamic logo;

  League(Map <String,dynamic>json){
    id= json['id'];
    name= json[ 'name' ];
    type= json[ 'type' ];
    logo= json[ 'logo' ];
  }
}

class Country
{
  String? name;
  String? flag;

  Country(Map <String,dynamic>json){
    name= json['name'];
    flag= json[ 'flag' ];
  }
}