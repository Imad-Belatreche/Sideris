import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/generated/app_localizations.dart';

export 'package:sideris/l10n/generated/app_localizations.dart';

extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
