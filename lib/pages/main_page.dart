import 'package:flutter_animate/flutter_animate.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/pages/create_update_notification_page.dart';
import 'package:sideris/pages/home_page.dart';
import 'package:sideris/pages/settings_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:sideris/widgets/night_sky_background.dart';

class MainPage extends StatefulWidget {
  final NotificationsRepository repository;
  final NotificationService notificationService;
  const MainPage({
    super.key,
    required this.repository,
    required this.notificationService,
  });

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
      extendBody: true,
      body: NightSkyBackground(child: _buildPage()),

      floatingActionButton: (_selectedIndex == 0)
          ? FloatingActionButton(
                  onPressed: () async {
                    //TODO: Navigate to create notification screen
                    await ensureNotificationPermission(context);
                    if (!mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NightSkyBackground(
                          child:
                              BlocProvider(
                                    create: (context) => NotificationCubit(
                                      repository: widget.repository,
                                      service: widget.notificationService,
                                    ),
                                    child: const CreateUpdateNotificationPage(),
                                  )
                                  .animate()
                                  .slideY(duration: 400.ms, begin: 0.1)
                                  .fadeIn(duration: 500.ms),
                        ),
                      ),
                    );
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
          backgroundColor: Colors.transparent,
          elevation: 0,
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
