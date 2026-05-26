import 'package:dakerni/cubits/notification/notification_cubit.dart';
import 'package:dakerni/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dakerni',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.interTextTheme().apply(bodyColor: Colors.white),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: Colors.indigo,
          elevation: 5,
          iconSize: 30,
        ),
      ),
      home: BlocProvider(
        create: (context) => NotificationCubit(),
        child: const MainPage(),
      ),
    );
  }
}
