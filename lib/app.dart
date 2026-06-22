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
      title: 'Sideris',
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.outfit(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Colors.white30,
          ),
          headlineSmall: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
          labelLarge: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          labelMedium: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
          bodyMedium: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          bodySmall: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white24,
          ),
        ),
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
