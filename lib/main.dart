import 'package:flutter/material.dart';
import 'cubits/cubits.dart';
import 'cubits/bloc_providers.dart';
import 'pages/todos_page/todos_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final blocProviderHandler = BlocProviderHandler();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviderHandler.blocProviders,
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
