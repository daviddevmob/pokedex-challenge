class PokeExtractor {
  PokeExtractor._();

  static String getId(String url) {
    return url
        .replaceAll("https://pokeapi.co/api/v2/pokemon/", "")
        .replaceAll('/', "");
  }

  static String getImageUrl(String url) {
    String id = PokeExtractor.getId(url);
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  static String getPokemonNumber(int id) {
    String parse = id.toString();

    if (parse.length == 1) {
      parse = "#00$parse";
    } else if (parse.length == 2) {
      parse = "#0$parse";
    } else {
      parse = "#$parse";
    }
    return parse.toString();
  }
}
