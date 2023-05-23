import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex_challenge_davidfernandes/src/models/pokemon_model.dart';
import 'package:pokedex_challenge_davidfernandes/src/resources/pokedex_api_provider/pokedex_api_interface.dart';
import 'package:mockito/mockito.dart';

import 'pokedex_api_provider_test.mocks.dart';

class PokedexApiProviderTest extends Mock implements PokedexApiInterface {}

@GenerateMocks([PokedexApiProviderTest])
void main() async {
  late MockPokedexApiProviderTest mockPokedexApiProviderTest;
  setUp(() {
    mockPokedexApiProviderTest = MockPokedexApiProviderTest();
  });

  group("Pokedex Api Provider", () {
    test(
      "Test - Fetch a limited list of pokemons",
      () async {
        PokemonSimpleResult pokemonModel = PokemonSimpleResult(
          url: "test.com",
          name: 'test',
        );
        List<PokemonSimpleResult> pokemons =
            List.generate(20, (index) => pokemonModel);
        when(mockPokedexApiProviderTest.getPokemons(offSet: 0))
            .thenAnswer((result) async => pokemons);
        final res = await mockPokedexApiProviderTest.getPokemons(offSet: 0);
        expect(res, isA<List<PokemonSimpleResult>>());
        expect(res, pokemons);
      },
    );

    test("Test - Fetch a limited list of pokemons throws exception", () async {
      when(mockPokedexApiProviderTest.getPokemons(offSet: 0))
          .thenAnswer((result) async {
        throw Exception();
      });

      final res = mockPokedexApiProviderTest.getPokemons(offSet: 0);
      expect(res, throwsException);
    });

    test("Test - Fetch the details gave a pokemon", () async {
      PokemonModel pokemonModel = PokemonModel(id: 1, name: "PokeTest");
      when(mockPokedexApiProviderTest.getPokemonDetails(id: pokemonModel.id))
          .thenAnswer(
        (result) async => pokemonModel,
      );
      final res =
          mockPokedexApiProviderTest.getPokemonDetails(id: pokemonModel.id);
      expect(res, isA<PokemonModel>());
      expect(res, pokemonModel);
    });

    test("Test - Fetch the details gave a pokemon throws exception", () async {
      when(mockPokedexApiProviderTest.getPokemonDetails(id: 1))
          .thenAnswer((result) async {
        throw Exception();
      });
      final res = mockPokedexApiProviderTest.getPokemonDetails(id: 1);
      expect(res, throwsException);
    });
  });
}
