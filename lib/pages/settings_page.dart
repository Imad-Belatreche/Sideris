import 'package:dakerni/cubits/settings/settings_cubit.dart';
import 'package:dakerni/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _defaultTitleController = TextEditingController();
  final TextEditingController _defaultDescriptionController =
      TextEditingController();
  late final SettingsCubit settingsCubit;
  UiLanguage? selectedLanguage;

  @override
  void initState() {
    super.initState();
    settingsCubit = context.read<SettingsCubit>();
    selectedLanguage = settingsCubit.state.settings.uiLanguage;
    _defaultTitleController.text = settingsCubit.state.settings.defaultTitle;
    _defaultDescriptionController.text =
        settingsCubit.state.settings.defaultDescription;
  }

  @override
  void dispose() {
    _defaultTitleController.dispose();
    _defaultDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
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
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Language",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                DropdownMenu<UiLanguage>(
                  enableSearch: false,
                  enableFilter: false,
                  width: double.infinity,
                  selectOnly: true,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.apply(color: Colors.indigoAccent),
                  decorationBuilder: (context, controller) =>
                      _buildInputDecoration(),
                  initialSelection: selectedLanguage,
                  onSelected: (value) {
                    if (value != null) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    }
                  },
                  dropdownMenuEntries: <DropdownMenuEntry<UiLanguage>>[
                    DropdownMenuEntry(
                      value: UiLanguage.english,
                      label: ReCase(UiLanguage.english.name).titleCase,
                    ),
                    DropdownMenuEntry(
                      value: UiLanguage.french,
                      label: ReCase(UiLanguage.french.name).titleCase,
                    ),
                    DropdownMenuEntry(
                      value: UiLanguage.arabic,
                      label: ReCase(UiLanguage.arabic.name).titleCase,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Default options",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),

                Text(
                  "Title :",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _defaultTitleController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: _buildInputDecoration(),
                ),
                SizedBox(height: 10),

                Text(
                  "Description :",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _defaultDescriptionController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: _buildInputDecoration(
                    hintText: "(Default is empty)",
                  ),
                ),
                SizedBox(height: 10),

                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final originalSettings = settingsCubit.state.settings;

                      final title = _defaultTitleController.text.trim();
                      final description = _defaultDescriptionController.text
                          .trim();
                      final newSettings = SettingsModel(
                        uiLanguage:
                            selectedLanguage ?? originalSettings.uiLanguage,
                        defaultTitle: title,
                        defaultDescription: description,
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shadowColor: Colors.black,
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({String? hintText}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 1, color: Colors.white12),
    );
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintText != null && hintText.isNotEmpty
          ? Theme.of(context).textTheme.bodySmall
          : null,
      border: border,
      enabledBorder: border,
      errorBorder: border,
      focusedBorder: border,
      disabledBorder: border,
      focusedErrorBorder: border,
    );
  }
}
