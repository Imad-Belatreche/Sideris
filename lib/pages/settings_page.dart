import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/models/settings_model.dart';
import 'package:sideris/widgets/create_update_elevated_button.dart';
import 'package:sideris/widgets/dnd_switch.dart';
import 'package:sideris/widgets/notification_outlined_button.dart';
import 'package:sideris/widgets/notification_textfield.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//TODO: Add settings page
//TODO: Add settings logic

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _defaultTitleController = TextEditingController();
  final TextEditingController _defaultDescriptionController =
      TextEditingController();

  SettingsModel? _draft;

  UiLanguage? language;
  RecurrenceType? recurrenceType;
  RepetitionType? repetitionType;
  ScheduleUnit? scheduleUnit;

  DurationOption? durationOption;
  bool? bypassDND;
  ColorTag? colorTag;

  @override
  void dispose() {
    _defaultTitleController.dispose();
    _defaultDescriptionController.dispose();
    super.dispose();
  }

  void _seedFromState(SettingsState state) {
    if (_draft != null || !state.isInitialized) return;

    final s = state.settings;
    _draft = s;
    _defaultTitleController.text = s.defaultTitle;
    _defaultDescriptionController.text = s.defaultDescription;
    language = s.uiLanguage;
    recurrenceType = s.recurrenceType;
    repetitionType = s.repetitionType;
    scheduleUnit = s.scheduleUnit;
    durationOption = s.durationOption;
    colorTag = s.colorTag;
    bypassDND = s.bypassDND;
  }

  Widget _buildSettingsButtons<T extends Enum>({
    required IconData icon,
    required List<T> values,
    required T value,
    required String label,
    required ValueChanged onChanged,
  }) {
    return NotificationOutlinedButton(
      label: "",
      isExpanded: true,
      onPressed: () {
        if (values.isEmpty) return;
        final currentIndex = values.indexOf(value);
        final safeIndex = currentIndex == -1 ? 0 : currentIndex;

        final nextValue = values[(safeIndex + 1) % values.length];

        onChanged(nextValue);
      },
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      tailingWidget: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.white,
        size: 20,
      ),
      leadingWidget: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          color: Colors.indigo.withAlpha(50),
        ),
        child: Icon(icon, color: Colors.indigo, size: 25),
      ),
      labelWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ReCase(value.name).titleCase,
            style: GoogleFonts.outfit(color: Colors.white70),
          ).animate(key: ValueKey(value)).fadeIn(duration: 250.ms),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            title:
                Text(
                      "Settings",
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
                      curve: Curves.easeIn,
                    ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 6)),

          SliverToBoxAdapter(
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                _seedFromState(state);

                if (_draft == null) {
                  return CircularProgressIndicator(color: Colors.white);
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Text(
                      "An error happened while loading settings: ${state.errorMessage}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Theme",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 10),

                      //TODO: Add theme changing
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 50,
                            width: 100,
                            child: Placeholder(),
                          );
                        },
                      ),
                      SizedBox(height: 16),

                      Text(
                        "Language",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 10),

                      Row(
                        spacing: 10,
                        children: [
                          ...UiLanguage.values.map(
                            (lang) => NotificationOutlinedButton(
                              label: lang.label,
                              isSelected: language?.name == lang.name,
                              onPressed: () {
                                setState(() {
                                  //TODO: Add multi-language support
                                  language = lang;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      Text(
                        "Default notification template",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 12),

                      NotificationTextfield(
                        controller: _defaultTitleController,
                        labelText: "Title",
                        hintText: "Title",
                        maxLines: 1,
                      ),
                      SizedBox(height: 12),

                      NotificationTextfield(
                        controller: _defaultDescriptionController,
                        labelText: "Description",
                        hintText: "(Default is empty)",
                        maxLines: 3,
                      ),
                      SizedBox(height: 12),

                      //TODO: Maybe add more default settings, like the scheduleEvery, random count, interval count, default specific time....etc
                      _buildSettingsButtons(
                        icon: Icons.category_outlined,
                        values: RepetitionType.values,
                        value: repetitionType ?? RepetitionType.oneTime,
                        label: "Default Repetition",
                        onChanged: (value) {
                          setState(() {
                            repetitionType = value;
                          });
                        },
                      ),
                      SizedBox(height: 12),

                      _buildSettingsButtons(
                        icon: Icons.loop_outlined,
                        values: ScheduleUnit.values,
                        value: scheduleUnit ?? ScheduleUnit.daily,
                        label: "Default Recurrence",
                        onChanged: (value) {
                          setState(() {
                            scheduleUnit = value;
                          });
                        },
                      ),

                      SizedBox(height: 12),

                      _buildSettingsButtons(
                        icon: Icons.access_time,
                        values: RecurrenceType.values,
                        value: recurrenceType ?? RecurrenceType.specific,
                        label: "Default Timing",
                        onChanged: (value) {
                          setState(() {
                            recurrenceType = value;
                          });
                        },
                      ),

                      SizedBox(height: 12),

                      _buildSettingsButtons(
                        icon: Icons.access_time_filled_outlined,
                        values: DurationOption.values,
                        value: durationOption ?? DurationOption.forever,
                        label: "Default Duration",
                        onChanged: (value) {
                          setState(() {
                            durationOption = value;
                          });
                        },
                      ),
                      SizedBox(height: 12),

                      DndSwitch(
                        value: bypassDND ?? false,
                        isSelected: bypassDND,
                        onChanged: (value) {
                          setState(() {
                            bypassDND = value;
                          });
                        },
                      ),

                      SizedBox(height: 12),
                    ],
                  ),
                );
              },
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CreateUpdateElevatedButton(
                label: "Save",
                icon: Icons.check,
                onPressed: () async {
                  final base = _draft;
                  if (base == null) return;

                  final settingsCubit = context.read<SettingsCubit>();

                  final title = _defaultTitleController.text.trim();

                  final description = _defaultDescriptionController.text.trim();

                  final newSettings = SettingsModel(
                    uiLanguage: language ?? base.uiLanguage,
                    defaultTitle: title,
                    defaultDescription: description,
                    repetitionType: repetitionType ?? base.repetitionType,
                    recurrenceType: recurrenceType ?? base.recurrenceType,
                    scheduleUnit: scheduleUnit ?? base.scheduleUnit,

                    durationOption: durationOption ?? base.durationOption,
                    bypassDND: bypassDND ?? base.bypassDND,
                    colorTag: colorTag,
                  );

                  await settingsCubit.saveSettings(newSettings);

                  if (!context.mounted) return;
                  if (settingsCubit.state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(settingsCubit.state.errorMessage!),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      content: Text(
                        "Settings have been saved",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.apply(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
