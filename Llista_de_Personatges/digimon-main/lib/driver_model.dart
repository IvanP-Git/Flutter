import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Driver {
  final String name;
  final String id;
  String? teamId;
  int? number;

  double rating = 5.0;

  Driver({
    required this.name,
    required this.id,
  });

  static const Map<String, String> teamLogos = {
    "mclaren": "https://fabrikbrands.com/wp-content/uploads/McLaren-Logo-8.png",
    "red_bull": "https://cdn-6.motorsport.com/images/mgl/Y99JQRbY/s8/red-bull-racing-logo-1.jpg",
    "mercedes": "https://fabrikbrands.com/wp-content/uploads/Mercedes-F1-Logo-6-2048x1280.png",
    "ferrari": "https://fabrikbrands.com/wp-content/uploads/Ferrari-F1-Logo-1.png",
    "aston_martin": "https://fabrikbrands.com/wp-content/uploads/Aston-Martin-F1-Logo-3.png",
    "williams": "https://media.formula1.com/content/dam/fom-website/2018-redesign-assets/team%20logos/williams%20blue.jpg",
    "rb": "https://liquipedia.net/commons/images/3/39/RB_allmode.png",
    "sauber": "https://www.westcoastmotorsport.se/wp-content/uploads/2024/03/stake_f1_team_kick_sauber_logo_formula1_formel1_f1sweden_f1sverige_westcoast_motorsport.png",
    "haas": "https://fabrikbrands.com/wp-content/uploads/Haas-F1-Logo-6.png",
    "alpine": "https://tse1.mm.bing.net/th/id/OIP.xbubHvYRPF00-co-xA8XkgHaGq?rs=1",
  };

  String? get teamLogo {
    
    if (teamId == null) 
    {
      return null;
    }

    return teamLogos[teamId!];
  }

  static const Map<String, String> teamPrinc = {
    "mclaren": "McLaren",
    "red_bull": "Red Bull",
    "mercedes": "Mercedes",
    "ferrari": "Ferrari",
    "aston_martin": "Aston Martin",
    "williams": "Williams",
    "rb": "RB",
    "sauber": "Kick Sauber",
    "haas": "Haas",
    "alpine": "Alpine",
  };

  String get teamPrincName => teamPrinc[teamId] ?? (teamId ?? "Unknown");

  Future<void> getDriverData() async {
    HttpClient http = HttpClient();
    var uri = Uri.parse("https://f1api.dev/api/current/drivers");
    var request = await http.getUrl(uri);
    var response = await request.close();
    var body = await response.transform(utf8.decoder).join();

    Map<String, dynamic> data = json.decode(body);
    List drivers = data["drivers"];

    var driver = drivers.firstWhere(
      (d) => d["driverId"] == id,
      orElse: () => null,
    );

    if (driver != null) 
    {
      teamId = driver["teamId"];
      number = driver["number"];
    }
  }
}