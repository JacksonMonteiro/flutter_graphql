import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeView extends StatefulWidget {
  final String title;

  const HomeView({super.key, required this.title});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> characters = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : characters.isEmpty
              ? Center(
                  child: ElevatedButton(
                    child: const Text("Fetch API Data"),
                    onPressed: fetchData,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image(
                            image: NetworkImage(characters[index]['image']),
                          ),
                          title: Text(
                            characters[index]['name'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  void fetchData() async {
    setState(() {
      _loading = true;
    });

    HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");

    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(
          """
        query {
	        characters {
            results {
			        name
              image
            }
	        }
        }
      """,
        ),
      ),
    );

    setState(() {
      characters = queryResult.data!['characters']['results'];
      _loading =  false;
    });
  }
}
