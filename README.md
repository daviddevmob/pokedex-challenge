<h1 align="center">Desafio Pokédex Snapfi - David Fernandes </h1>

Projeto desenvolvido para o desafio da Snapfi, utilizando o layout disponibilizado através deste [link](https://www.figma.com/file/oyy40kpPCamOuJOQu1uYMo/Pok%C3%A9dex-(Community)?type=design&node-id=0-1) e utilizando a PokéApi que pode ser acessada neste [link](https://pokeapi.co/). Com a adição de uma Splash Screen, temos ao total três telas que, respectivamente, mostram: a animação de carregamento(que só busca dados uma vez), lista os pokemons com infity scroll e a ultima que mostra detalhes do pokemon e suas evoluções.

Tópicos
=================
<!--ts-->
  * [Estrutura do projeto](#estrutura-do-projeto)
  * [Bibliotecas](#bibliotecas)
  * [Desafios Encontrados](#desafios-encontrados)
  * [Layout e Animações](#layout-e-animacoes)
  * [Testes](#testes)
<!--te-->

Estrutura do projeto
=================

O projeto foi estruturado como mostra o código abaixo:

```
├── blinds
    ├── pokedex_blind.dart
├── controllers
    ├── pokedex_controller.dart
    ├── pokedex_details_controller.dart
├── models
    ├── pokemon_model.dart
├── resources
    ├── pokedex_api_provider
        ├── pokedex_api_provider_interface.dart
        ├── pokedex_api_provider.dart
    ├── extractor.dart
    ├── repository.dart
├── theme
    ├── widgets
    ├── colors.dart
    ├── font_style.dart
    ├── responsive.dart
├── ui
    ├── details_screen.dart
    ├── home_screen.dart
    ├── splash_screen.dart
├── app.dart
```

Bibliotecas
=================

Com a liberdade de escolher quais bibliotecas seriam utilizadas, neste contexto escolhi utilizar GetX para agilizar a entrega dessa pequena aplicação, mas sou adepto do Bloc Pattern para projetos robustos e principalmente com escopo de equipe. Aqui serão descritas as principais bibliotecas utilizadas e o motivo de estarem no projeto:

[GetX](https://pub.dev/packages/get): Apesar do GetX pecar em sua documentação e estar a uma ano sem atualizações, o que o torna bem preocupante, utilizei neste projeto por me proporcionar agilidade em gerenciamento de estado, injeção de dependência e gerenciamento de rotas. Foi instanciado um blind global PokedexBinding, um controller global PokedexController e um controller local PokedexDetailsController para a tela de detalhes do pokemon, este ultimo é descartado ao sair da tela de detalhes.

[GetStorage](https://pub.dev/packages/get_storage): Todas as chamadas de api que acontecem no PokedexApiProvider passam pelo GetStorage para verificar se existe um cache para esta rota. Código:
```
 Future<Map<String, dynamic>?> getCache({required String path}) async {
    try {
      var localJson = await box.read(path);
      late Map<String, dynamic> result;
      if (localJson != null) {
        result = localJson;
      } else {
        Response response = await dio.get(
          path,
        );
        if (response.statusCode == 200) {
          result = response.data;
          await box.write(path, result);
        } else {
          return null;
        }
      }
      return result;
    } catch (e) {
      return null;
    }
  }
```
[CachedNetworkImage](https://pub.dev/packages/cached_network_image): Biblioteca muito importante para melhorar a experiencia de uso do usuário, como o app lida com um GridView de imagens e o carregamento destas deve ser o mais rápido possível, esta biblioteca possibilita que tenhamos as imagens quase que instantaneamente.

[Mockito](https://pub.dev/packages/mockito): Utilizado aqui para fazer testes unitários e subir uma instância fake da PokedexApiProvider. Os testes de Widget infelizmente não consegui terminar devido ao meu tempo disponível, mas tem um código comentado em test/widget_test.

#Desafios Encontrados

O maior desafio encontrado foi criar um adaptador para carregar as imagens dos pokemons pela [rota principal da PokeApi](https://pokeapi.co/api/v2/pokemon?limit=20&offset=0), pois nela retorna somente o nome do pokemon e um link para seu perfil. Existem arquivos prontos - [link1](https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json) e [link2](https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json), [link3](https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json) -  no GitHub com todas as informações de todos os pokemons da PokeApi, mas eu segui as recomendações do desafio e utilizei somente a PokeApi. Identifiquei um padrão ao analisar o path da URL das imagens da PokeApi, assim criei um Extractor, localizado em Resources, onde eu extraio as informações básicas que preciso para construir a HomeScreen sem precisar chamar outra rota além da rota principal. Código:

```
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
```

Layout e Animações
=================

A aplicação tem um layout bem simples, resolvi dar mais vida com transições Hero entre a tela HomeScreen e DetailsScreen. Além disso, coloquei o SVG da Pokeball girando no cover do Pokemon. O gráfico de Base Stats foi feito customizado pois é bem específico e não queria perder tempo procurando alguma biblioteca de chart no PubDev.

Testes
=================

Foram conclúidos testes unitários para os Providers e iniciados os testes de Widgets, mas devido ao tempo não foram finalizados(estão comentados no arquivos widget.test.dart).


