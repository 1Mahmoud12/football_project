class StandingLeague
{
  dynamic idLeague;
  dynamic nameLeague;
  dynamic logoLeague;
  late List<Seasons> seasons;

  StandingLeague(Map<String ,dynamic>json)
  {
    idLeague=json['league']['id'];
    nameLeague=json['league']['name'];
    logoLeague=json['league']['logo'];
    seasons=[];
    for(int i=0;i<json['seasons'].length;i++){
      json['seasons'].forEach((element){
        seasons.add(Seasons(element));
        //print(json['seasons'][i]);
      });


    }

  }
}

class Seasons{
  dynamic year;
  dynamic startDate;
  dynamic endDate;
  dynamic current;
  dynamic standings;

  Seasons(Map<String,dynamic>json)
  {
    year=json['year'];
    startDate=json['start'];
    endDate=json['end'];
    current=json['current'];
    standings=json['coverage']['standings'];

  }
}