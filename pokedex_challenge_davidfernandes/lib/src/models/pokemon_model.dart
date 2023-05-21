class PokemonModel {
  int id;
  String name;
  String? image;
  List<String>? types;
  double? wight;
  double? height;
  List<String>? moves;
  String? description;
  PokemonBaseStatsModel? baseStats;
  String? specie;
  List<PokemonModel>? others;

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json["id"],
      others: [],
      name: json["forms"][0]["name"],
      image: json["sprites"]["other"]["official-artwork"]["front_default"],
      types: (json["types"] as List)
          .map((e) => e["type"]["name"].toString())
          .toList(),
      wight: double.parse(json["weight"].toString()),
      height: double.parse(json["height"].toString()),
      moves: (json["abilities"] as List)
          .map((e) => e["ability"]["name"].toString())
          .toList(),
      description: "",
      baseStats: PokemonBaseStatsModel.fromJson(json),
    );
  }

  PokemonModel({
    required this.id,
    required this.name,
    this.image,
    this.types,
    this.wight,
    this.height,
    this.moves,
    this.description,
    this.baseStats,
    this.specie,
    this.others,
  });
}

class PokemonBaseStatsModel {
  final double hp;
  final double atk;
  final double def;
  final double satk;
  final double sdef;
  final double spd;

  PokemonBaseStatsModel({
    required this.hp,
    required this.atk,
    required this.def,
    required this.satk,
    required this.sdef,
    required this.spd,
  });

  factory PokemonBaseStatsModel.fromJson(Map<String, dynamic> json) {
    List stats = json["stats"];
    return PokemonBaseStatsModel(
      hp: double.parse(stats[0]["base_stat"].toString()),
      atk: double.parse(stats[1]["base_stat"].toString()),
      def: double.parse(stats[2]["base_stat"].toString()),
      satk: double.parse(stats[3]["base_stat"].toString()),
      sdef: double.parse(stats[4]["base_stat"].toString()),
      spd: double.parse(stats[5]["base_stat"].toString()),
    );
  }
}

class PokemonSimpleResult {
  final String name;
  final String url;

  PokemonSimpleResult({required this.name, required this.url});

  factory PokemonSimpleResult.fromJson(Map<String, dynamic> json) {
    return PokemonSimpleResult(
      name: json["name"],
      url: json["url"],
    );
  }
}
