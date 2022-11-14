class PlayerDetailsEntities {
 late PlayerInfo playerInfo;
 late Statistics statistics;

PlayerDetailsEntities(Map<String,dynamic>json){
  playerInfo=PlayerInfo(json['player']);
  statistics=Statistics(json['statistics'][0]);
}
}

class PlayerInfo {
  dynamic id;
  dynamic name;
  dynamic age;
  dynamic nationality;
  dynamic dateBirth;
  dynamic height;
  dynamic photo;
  dynamic injured;
  dynamic weight;

  PlayerInfo(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    age=json['age'];
    height=json['height'];
    photo=json['photo'];
    injured=json['injured'];
    nationality=json['nationality'];
    weight=json['weight'];
    dateBirth=json['birth']['date'];
  }
}

class Statistics {
  Team? team;
  League? league;
  Games? game;
  Substitutes? substitutes;
  Shots? shots;
  Goals? goals;
  Passes? passes;
  Tackles? tackles;
 // dynamic duels;
  Dribbles? dribbles;
  Fouls? fouls;
  Cards? card;
  Penalty? penalty;

  Statistics(Map<String,dynamic>json){
    team=Team(json['team']);
    league=League(json['league']);
    game=Games(json['games']);
    substitutes=Substitutes(json['substitutes']);
    shots=Shots(json['shots']);
    goals=Goals(json['goals']);
    passes=Passes(json['passes']);
    tackles=Tackles(json['tackles']);
    fouls=Fouls(json['fouls']);
    //duels=json['duels'];
    dribbles=Dribbles(json['dribbles']);
    card=Cards(json['card']);
    penalty=Penalty(json['penalty']);
  }
}

class Team{
  dynamic id;
  dynamic name;
  dynamic logo;
  Team(Map<String,dynamic>json) {
    id=json['id']??'0';
    name=json['name']??'0';
    logo=json['logo']??'0';
  }
}

class League{
  dynamic id;
  dynamic name;
  dynamic logo;
  dynamic flag;
  dynamic country;
  dynamic season;
  League(Map<String,dynamic>json) {
    id=json['id']??'0';
    name=json['name']??'0';
    country=json['country']??'0';
    logo=json['logo']??'0';
    flag=json['flag']??'0';
    season=json['season']??'0';
  }
}

class Games{
  dynamic appearences;
  dynamic lineups;
  dynamic minutes;
  dynamic number;
  dynamic position;
  dynamic rating;
  dynamic captain;

  Games(Map<String,dynamic>json) {
    appearences=json['appearences'] ?? 0;
    lineups=json['lineups'] ?? '0';
    minutes=json['minutes'] ?? 0;
    number=json['number'] ?? '0';
    position=json['position'] ?? '0';
    rating=json['rating'] ?? '0';
    captain=json['captain'] ?? '0';
  }
}

class Substitutes{
  dynamic inSubstitutes;
  dynamic outSubstitutes;
  dynamic benchSubstitutes;
  Substitutes(Map<String,dynamic>json) {
    inSubstitutes=json['in']??'0';
    outSubstitutes=json['out']??'0';
    benchSubstitutes=json['bench']??'0';
  }
}
class Shots{


  dynamic totalShots;
  dynamic onShots;
 Shots(Map<String,dynamic>json) {
   totalShots=json['total']??'0';
   onShots=json['on']??'0';
  }
}

class Goals{


  dynamic totalGoals;
  dynamic concededGoals;
  dynamic assistsGoals;
  dynamic savesGoals;
 Goals(Map<String,dynamic>json) {
   totalGoals=json['total'] ?? '0';
   concededGoals=json['conceded']??'0';
   assistsGoals=json['assists']??'0';
   savesGoals=json['saves'] ?? '0';
 }
}

class Passes{


  dynamic totalPasses;
  dynamic keyPasses;
  dynamic accuracyPasses;
 Passes(Map<String,dynamic>json) {
   totalPasses=json['total']??'0';
   keyPasses=json['key']??'0';
   accuracyPasses=json['accuracy']??'0';
 }
}

class Tackles{


  dynamic totalTackles;
  dynamic blocksTackles;
  dynamic interceptionsTackles;
 Tackles(Map<String,dynamic>json) {
   totalTackles=json['total']??'0';
   blocksTackles=json['blocks']??'0';
   interceptionsTackles=json['interceptions']??'0';
 }
}

class Dribbles{


  dynamic attemptsDribbles;
  dynamic successDribbles;
  dynamic pastDribbles;
 Dribbles(Map<String,dynamic>json) {
   attemptsDribbles=json['attempts']??'0';
   successDribbles=json['success']??'0';
   pastDribbles=json['past']??'0';
 }
}

class Fouls{


  dynamic drawnFouls;
  dynamic committedFouls;
 Fouls(Map<String,dynamic>json) {
   drawnFouls=json['drawn']??'0';
   committedFouls=json['committed']??'0';
 }
}
class Cards{


  dynamic yellowCards;
  dynamic redCards;
 Cards(Map<String,dynamic>?json) {
   yellowCards=json==null?0:(json['yellow']??0).toString();
   redCards=json==null?0:json['red']??'0';
 }
}
class Penalty{


  dynamic wonPenalty;
  dynamic commitedPenalty;
  dynamic scoredPenalty;
  dynamic missedPenalty;
  dynamic savedPenalty;
 Penalty(Map<String,dynamic>json) {
   wonPenalty=json['won']??'0';
   commitedPenalty=json['commited']??'0';
   scoredPenalty=json['scored']??'0';
   missedPenalty=json['missed']??'0';
   savedPenalty=json['saved']??'0';
 }
}
