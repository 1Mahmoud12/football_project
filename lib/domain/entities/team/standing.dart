class StandingTeam
{
  dynamic idLeague;
  dynamic nameLeague;
  dynamic seasonLeague;
  dynamic logoLeague;
  late List<Standing> standingsTeam;

  StandingTeam(Map<String ,dynamic>json)
  {
    idLeague=json['id'];
    nameLeague=json['name'];
    seasonLeague=json['season'];
    logoLeague=json['logo'];
    standingsTeam=[];
    for(int i=0;i<json['standings'].length;i++){
      json['standings'][i].forEach((element){
        standingsTeam.add(Standing(element));
      });


    }

  }
}

class Standing{
  dynamic rank;
  dynamic nameTeam;
  dynamic logoTeam;
  dynamic points;
  dynamic goalsDiff;
  dynamic description;
  dynamic played;
  dynamic win;
  dynamic draw;
  dynamic lose;
  dynamic update;
  Standing(Map<String,dynamic>json)
  {
    rank=json['rank'];
    nameTeam=json['team']['name'];
    logoTeam=json['team']['logo'];
    points=json['points'];
    goalsDiff=json['goalsDiff'];
    description=json['description'];
    played=json['all']['played'];
    win=json['all']['win'];
    draw=json['all']['draw'];
    lose=json['all']['lose'];
  }
}