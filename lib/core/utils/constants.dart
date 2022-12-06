import 'package:sofa_sccore/domain/entities/fixtures.dart';

class Constants
{
  static String api ='https://v3.football.api-sports.io';
  static String? apiKey ;
  static Uri url =Uri.parse('https://dashboard.api-football.com/login/expirate');
  static List<String> endPoints=['teams','fixtures','fixtures/lineups',
    "players/squads",'standings','leagues','players','transfers',"odds/live","fixtures/statistics",'fixtures/events'];

  //'x-rapidapi-key': '20caee99a0c4f9fd91713690b0b75446',
  static var headers = {

    'x-rapidapi-key': apiKey!,
    'x-rapidapi-host': 'v3.football.api-sports.io',

  };
  static int alahly=1029;
  static int zamalek=1040;
  static int manchesterUnited=33;
  static int liverpool=40;
  static int arsenal=42;
  static int tottenham=47;
  static int chelsea=49;
  static int manchesterCity=50;
  static int barcelona=529;
  static int realMadrid=541;
  static int parisSaintGermain=85;
  static int juventus=496;
  static int acMilan=489;
  static int inter=505;
  static int roma=497;
  static int napoli=492;
  static int bayernMunich=157;
  static int egypt=32;
  static int france=2;
  static int belgium=1;

  // Leagues must input season
  static List<int> leagueId=[1,2,39,140,135,233,3];
  //static List<int> leagueId=[39];         //لغاية لما اخلص الابليكشن
  static int worldCup=1;
    static int uEFAChampionsLeague=2;
    static int premierLeague=39;
    static int bundesliga=78;
    static int ligue1=61;
    static int laLiga=140;
    static int serieA=135;
    static int premierLeagueEgypt=233;
    static int uefaNationsLeague=5;

    /// Date Time
    static String fromDate=DateTime.now().add(const Duration(days: -1)).toString().substring(0, 10);
    static String toDate=DateTime.now().add(const Duration(days: 7)).toString().substring(0, 10);
    static String timezone="Africa/Cairo";

   /// List Favorite Team
    static List<int> favorites=[];

   /// List For match live
    static List<ResponseFixtures> liveFixtures=[];

  /// date Today for Fixtures
    static String? todaySharedPreference;

    static bool runAllGames= true;

  /// Type of events
  static Map<String,String> typeEvents={'Goal':'assets/ball.svg',
    'Yellow Card':'assets/Yellow_card.svg.png',
    'Red Card':'assets/Red_card.svg.png',
    'subst':'assets/repeat_318-596159.jpg',
    'Var':'assets/var.jpg'};
  /// No Image
  static String noImage='https://previews.123rf.com/images/urfandadashov/urfandadashov1806/urfandadashov180601827/150417827-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg';
}