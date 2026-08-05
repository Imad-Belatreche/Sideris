import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String getGreeting() {
      final hour = now.hour;

      if (hour < 12) return 'Good Morning';
      if (hour < 17) return 'Good Afternoon';
      return 'Good Evening';
    }

    return SafeArea(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 70,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      getGreeting(),
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(
                      duration: 400.ms,
                      begin: -0.05,
                      curve: Curves.easeOut,
                    ),
                const SizedBox(height: 2),

                Text(
                      DateFormat.EEEE().addPattern(", MMMM dd").format(now),
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideX(
                      duration: 400.ms,
                      delay: 100.ms,
                      begin: -0.05,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 100,
              itemBuilder: (context, index) {
                final item = "Item $index";
                return ListTile(
                  title: Text(
                    item,
                    style: GoogleFonts.outfit(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
