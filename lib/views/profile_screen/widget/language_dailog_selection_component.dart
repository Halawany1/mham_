import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';

class BuildLanguageSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color=Theme.of(context);
    return Dialog(
      backgroundColor: color.scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locale.chooseLanguage,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            LanguageOption(
              language: locale.english,
              onPressed: () {
                LayoutCubit.get(context).changeLang('en');
                Navigator.pop(context);
              },
            ),
            LanguageOption(
              language: locale.arabic,
              onPressed: () {
                LayoutCubit.get(context).changeLang('ar');
                Navigator.pop(context);
              },
            ),
            // Add more LanguageOption widgets for other languages
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final VoidCallback onPressed;

  const LanguageOption({
    required this.language,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var font=Theme.of(context).textTheme;
    var color=Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Text(language,style: font.bodyMedium!.copyWith(
        color:color.backgroundColor,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}