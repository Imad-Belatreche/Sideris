import 'package:flutter_animate/flutter_animate.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/pages/home_page.dart';
import 'package:sideris/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildPage() {
    if (_selectedIndex == 0) {
      return HomePage(key: ValueKey("home"));
    } else {
      return BlocProvider(
        create: (context) => SettingsCubit(),
        child: SettingsPage(key: ValueKey("settings")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),

      floatingActionButton: (_selectedIndex == 0)
          ? FloatingActionButton(
                  onPressed: () {
                    //TODO: Navigate to create notification screen
                  },

                  child: Icon(Icons.add),
                )
                .animate()
                .fade(duration: 400.ms)
                .slideY(duration: 400.ms, begin: 0.05, curve: Curves.easeOut)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 10,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
