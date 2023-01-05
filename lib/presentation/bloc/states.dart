abstract class MatchesState{}
class MatchesInitialState extends MatchesState{}

class MatchesGetAllGamesLoadingState extends MatchesState{}
class MatchesGetAllGamesSuccessState extends MatchesState{}
class MatchesGetAllGamesErrorState extends MatchesState{}

class MatchesFixturesAndLineupLoadingState extends MatchesState{}
class MatchesFixturesAndLineupSuccessState extends MatchesState{}
class MatchesFixturesAndLineupErrorState extends MatchesState{}

class MatchesGetSquadsLoadingState extends MatchesState{}
class MatchesGetSquadsSuccessState extends MatchesState{}
class MatchesGetSquadsErrorState extends MatchesState{}

class MatchesGetStandingLoadingState extends MatchesState{}
class MatchesGetStandingSuccessState extends MatchesState{}
class MatchesGetStandingErrorState extends MatchesState{}

class MatchesGetMatchesForTeamLoadingState extends MatchesState{}
class MatchesGetMatchesForTeamSuccessState extends MatchesState{}
class MatchesGetMatchesForTeamErrorState extends MatchesState{}

class MatchesGetMatchesForTeamFavoritesLoadingState extends MatchesState{}
class MatchesGetMatchesForTeamFavoritesSuccessState extends MatchesState{}
class MatchesGetMatchesForTeamFavoritesErrorState extends MatchesState{}

// search TEAM
class MatchesSearchTeamLoadingState extends MatchesState{}
class MatchesSearchTeamSuccessState extends MatchesState{}
class MatchesSearchTeamErrorState extends MatchesState{}

// search LEAGUE
class MatchesSearchLeagueLoadingState extends MatchesState{}
class MatchesSearchLeagueSuccessState extends MatchesState{}
class MatchesSearchLeagueErrorState extends MatchesState{}


class MatchesChampionsTeamLoadingState extends MatchesState{}
class MatchesChampionsTeamSuccessState extends MatchesState{}
class MatchesChampionsTeamErrorState extends MatchesState{}

class MatchesInfoVenueLoadingState extends MatchesState{}
class MatchesInfoVenueSuccessState extends MatchesState{}
class MatchesInfoVenueErrorState extends MatchesState{}

class MatchesStatisticsPlayerLoadingState extends MatchesState{}
class MatchesStatisticsPlayerSuccessState extends MatchesState{}
class MatchesStatisticsPlayerErrorState extends MatchesState{}

class MatchesTransferPlayerLoadingState extends MatchesState{}
class MatchesTransferPlayerSuccessState extends MatchesState{}
class MatchesTransferPlayerErrorState extends MatchesState{}

class MatchesGetEventsLoadingState extends MatchesState{}
class MatchesGetEventsSuccessState extends MatchesState{}
class MatchesGetEventsErrorState extends MatchesState{}


class MatchesLiveLoadingState extends MatchesState{}
class MatchesLiveSuccessState extends MatchesState{}
class MatchesLiveErrorState extends MatchesState{}

// Dark or Light
class MatchesModeLoadingState extends MatchesState{}
class MatchesModeSuccessState extends MatchesState{}
class MatchesModeErrorState extends MatchesState{}

// FAVORITES
class MatchesTeamsFavoritesSuccessState extends MatchesState{}
class MatchesTeamsFavoritesRemoveState extends MatchesState{}
class MatchesTeamsFavoritesErrorState extends MatchesState{}
class MatchesSelectFavoritesState extends MatchesState{}

// search LEAGUE
class MatchesGetStatisticsLoadingState extends MatchesState{}
class MatchesGetStatisticsSuccessState extends MatchesState{}
class MatchesGetStatisticsErrorState extends MatchesState{}


// Matches Live
class MatchesLiveState extends MatchesState{}

// Timer

class MatchesStartTimerState extends MatchesState{}
class MatchesStopTimerState extends MatchesState{}
class MatchesContinueState extends MatchesState{}

// Count

class MatchesCountPlusState extends MatchesState{}

//select league
class MatchesAddLeagueState extends MatchesState{}

//select message
class MatchesMessageState extends MatchesState{}

