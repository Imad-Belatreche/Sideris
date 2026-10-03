import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/cubits/local/locale_cubit.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/l10n/enum_labels.dart';
import 'package:sideris/l10n/l10n.dart';
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

class _SettingsPageState extends State<SettingsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isDocked = false;
  bool _lastDirty = false;

  static const double _saveSlotHeight = 65; // empty space for docked button
  static const double _floatingBottom =
      20; // space between button and navbar when floating
  static const double _dockedBottom = 12; // space under button when docked
  static const double _dockThreshold = 1;

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
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _defaultTitleController.addListener(_onTextChanged);
    _defaultDescriptionController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    _defaultTitleController.dispose();
    _defaultDescriptionController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || !_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (!position.hasPixels || !position.hasContentDimensions) return;

    final shouldDock =
        position.maxScrollExtent - position.pixels <= _dockThreshold;

    if (shouldDock != _isDocked) {
      setState(() => _isDocked = shouldDock);
    }
  }

  void _onTextChanged() {
    if (!mounted || _draft == null) return;

    final dirty = _checkIsDirty(context.read<SettingsCubit>().state);
    if (dirty != _lastDirty) setState(() {});
  }

  void _seedFromState(SettingsState state) {
    if (_draft != null || !state.isInitialized) return;

    final s = state.settings;

    _defaultTitleController.text = s.defaultTitle;
    _defaultDescriptionController.text = s.defaultDescription;
    language = s.uiLanguage;
    recurrenceType = s.recurrenceType;
    repetitionType = s.repetitionType;
    scheduleUnit = s.scheduleUnit;
    durationOption = s.durationOption;
    colorTag = s.colorTag;
    bypassDND = s.bypassDND;

    _draft = s;
  }

  bool _checkIsDirty(SettingsState state) {
    if (_draft == null) return false;

    final s = state.settings;
    return _defaultTitleController.text.trim() != s.defaultTitle ||
        _defaultDescriptionController.text.trim() != s.defaultDescription ||
        language != s.uiLanguage ||
        scheduleUnit != s.scheduleUnit ||
        recurrenceType != s.recurrenceType ||
        repetitionType != s.repetitionType ||
        durationOption != s.durationOption ||
        colorTag != s.colorTag ||
        bypassDND != s.bypassDND;
  }

  Widget _buildSettingsButtons<T extends Enum>({
    required IconData icon,
    required List<T> values,
    required T value,
    required String label,
    required String Function(T value) valueLabel,
    required ValueChanged onChanged,
  }) {
    final font = appFontOf(context);

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
        isRTL(context.read<LocaleCubit>().state.locale)
            ? Icons.keyboard_arrow_left
            : Icons.keyboard_arrow_right,
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
            style: font(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            valueLabel(value),
            style: font(color: Colors.white70),
          ).animate(key: ValueKey(value)).fadeIn(duration: 250.ms),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final font = appFontOf(context);
    final scaffoldBg = const Color(0xFF161233);

    final isDirty = _checkIsDirty(context.watch<SettingsCubit>().state);
    _lastDirty = isDirty;

    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());

    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            shrinkWrap: true,
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                centerTitle: false,
                backgroundColor: Colors.transparent,
                title:
                    Text(
                          context.l10n.settingsPageTitle,
                          style: font(
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
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _onScroll(),
                    );

                    if (_draft == null) {
                      return CircularProgressIndicator(color: Colors.white);
                    }

                    if (state.errorMessage != null) {
                      return Center(
                        child: Text(
                          context.l10n.settingsPageLoadingError(
                            state.errorMessage!,
                          ),
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
                            context.l10n.settingsPageTheme,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 10),

                          //TODO: Add theme changing
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                            context.l10n.settingsPageLanguage,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 10),

                          Row(
                            spacing: 10,
                            children: UiLanguage.values
                                .map(
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
                                )
                                .toList(),
                          ),
                          SizedBox(height: 16),

                          Text(
                            context
                                .l10n
                                .settingsPageDefaultNotificationTemplate,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 12),

                          NotificationTextfield(
                            controller: _defaultTitleController,
                            labelText: context.l10n.fieldTitle,
                            hintText: context.l10n.fieldTitle,
                            maxLines: 1,
                          ),
                          SizedBox(height: 12),

                          NotificationTextfield(
                            controller: _defaultDescriptionController,
                            labelText: context.l10n.fieldDescription,
                            hintText:
                                context.l10n.settingsPageDefaultDescriptionHint,
                            maxLines: 3,
                          ),
                          SizedBox(height: 12),

                          //TODO: Maybe add more default settings, like the scheduleEvery, random count, interval count, default specific time....etc
                          _buildSettingsButtons(
                            icon: Icons.category_outlined,
                            values: RepetitionType.values,
                            value: repetitionType ?? RepetitionType.oneTime,
                            label: context.l10n.settingsPageDefaultRepetition,
                            valueLabel: (value) => value.label(context.l10n),
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
                            label: context.l10n.settingsPageDefaultRecurrence,
                            valueLabel: (value) => value.label(context.l10n),
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
                            label: context.l10n.settingsPageDefaultTiming,
                            valueLabel: (value) => value.label(context.l10n),
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
                            label: context.l10n.settingsPageDefaultDuration,
                            valueLabel: (value) => value.label(context.l10n),
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
              SliverToBoxAdapter(child: SizedBox(height: _saveSlotHeight)),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _saveSlotHeight,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: isDirty && !_isDocked ? 1 : 0,
                duration: 250.ms,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [scaffoldBg.withAlpha(0), scaffoldBg],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: 250.ms,
            curve: Curves.easeOutCubic,
            left: 0,
            right: 0,
            bottom: _isDocked ? _dockedBottom : _floatingBottom,
            child: IgnorePointer(
              ignoring: !isDirty,
              child: AnimatedOpacity(
                opacity: isDirty ? 1 : 0,
                duration: 250.ms,
                child: Center(
                  child: CreateUpdateElevatedButton(
                    label: context.l10n.actionSave,
                    icon: Icons.check,
                    onPressed: () async {
                      final base = _draft;
                      if (base == null) return;

                      final settingsCubit = context.read<SettingsCubit>();

                      final title = _defaultTitleController.text.trim();

                      final description = _defaultDescriptionController.text
                          .trim();

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

                      context.read<LocaleCubit>().changeLanguage(
                        Locale(language?.value ?? base.uiLanguage.value),
                      );

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
                            context.l10n.settingsPageSavedSettings,
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
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
