import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/locale_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        Locale? currentLocale = localeProvider.locale;
        String currentLanguage =
            _getLanguageName(currentLocale?.languageCode ?? 'pt');

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0.5,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                'Idioma atual: $currentLanguage',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildLanguageOption(context, 'Português', Icons.language, 'pt'),
              _buildLanguageOption(context, 'Español', Icons.language, 'es'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String title, IconData icon, String localeCode) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title),
      iconColor: Colors.blue,
      onTap: () {
        _updateLanguage(context, localeCode);
      },
    );
  }

  void _updateLanguage(BuildContext context, String localeCode) {
    Provider.of<LocaleProvider>(context, listen: false)
        .setLocale(Locale(localeCode));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idioma alterado para ${_getLanguageName(localeCode)}'),
      ),
    );
  }

  String _getLanguageName(String localeCode) {
    switch (localeCode) {
      case 'pt':
        return 'Português';
      case 'es':
        return 'Español';

      default:
        return 'Português';
    }
  }
}
