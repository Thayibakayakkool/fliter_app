import 'package:filter_app/core/constants.dart';
import 'package:filter_app/pages/bloc/filter_page/filter_page_bloc.dart';
import 'package:filter_app/pages/bloc/home_page/home_page_bloc.dart';
import 'package:filter_app/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc(userDetailsList),
        ),
        BlocProvider(
          create: (context) => FiltersBloc(userDetailsList),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        ),
        home: const HomePage(),
      ),
    );
  }
}
