import 'package:flutter/material.dart';
import 'package:graphql/app/views/home_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(title: 'GraphQL Example'),
    );
  }
}

