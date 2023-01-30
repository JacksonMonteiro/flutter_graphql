import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          ? const CircularProgressIndicator()
          : characters.isEmpty
              ? Center(
                  child: ElevatedButton(
                    child: const Text("Fetch API Data"),
                    onPressed: () {
                      // fetchData();
                    },
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
}
