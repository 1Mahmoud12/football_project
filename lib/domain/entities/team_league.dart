class SearchTeams {
  late Teams teamJson;
  late Venue venueJson;

  SearchTeams(Map<String, dynamic> json) {
    venueJson = Venue.fromJson(json['venue']);
    teamJson = Teams.fromJson(json['team']);
  }
}

class Teams {
  dynamic id;
  dynamic name;

  dynamic country;
  dynamic founded;
  dynamic national;
  dynamic logo;

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    founded = json['founded'];
    national = json['national'];
    logo = json['logo'];
  }
}

class Venue {
  dynamic id;
  dynamic name;
  dynamic address;
  dynamic city;
  dynamic capacity;
  dynamic surface;
  dynamic image;

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    capacity = json['capacity'];
    surface = json['surface'];
    image = json['image'];
  }
}
