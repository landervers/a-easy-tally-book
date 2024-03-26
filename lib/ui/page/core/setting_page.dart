import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Settings {
  static const String notificationsKey = 'notifications';
  static const String darkModeKey = 'darkMode';
  static const String fontSizeKey = 'fontSize';

  bool notificationsEnabled;
  bool darkModeEnabled;
  int fontSize;

  Settings({
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.fontSize,
  });

  // 将设置保存到 SharedPreferences
  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationsKey, notificationsEnabled);
    await prefs.setInt(fontSizeKey, fontSize);
  }

  // 从 SharedPreferences 加载设置
  static Future<Settings> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool notificationsEnabled = prefs.getBool(notificationsKey) ?? true;
    final bool darkModeEnabled = prefs.getBool(darkModeKey) ?? false;
    final int fontSize = prefs.getInt(fontSizeKey) ?? 1;
    return Settings(
      notificationsEnabled: notificationsEnabled,
      darkModeEnabled: darkModeEnabled,
      fontSize: fontSize,
    );
  }
}


class MyApp extends StatelessWidget {
  final Settings settings;

  const MyApp({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',

      theme: ThemeData(
        // 根据设置是否启用深色模式
        brightness: settings.darkModeEnabled ? Brightness.dark : Brightness.light,
      ),
      // home: SettingPage(settings: settings),
    );
  }
}

void main() async {
  // 加载设置
  final settings = await Settings.load();

  runApp(MyApp(settings: settings));
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Settings _settings = Settings(notificationsEnabled: true, darkModeEnabled: false, fontSize: 1);

  @override
  void initState() {
    super.initState();
    // 加载设置
    Settings.load().then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // SwitchListTile(
          //   title: Text('打开通知'),
          //   value: _settings.notificationsEnabled,
          //   onChanged: (value) {
          //     setState(() {
          //       _settings.notificationsEnabled = value;
          //     });
          //   },
          // ),
          IconButton(
            onPressed: () {
              EasyDynamicTheme.of(context).themeMode == ThemeMode.light
                  ? EasyDynamicTheme.of(context)
                  .changeTheme(dynamic: false, dark: true)
                  : EasyDynamicTheme.of(context)
                  .changeTheme(dynamic: false,dark: false);
            },
            icon: Icon(EasyDynamicTheme.of(context).themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
          ),

          // IconButton(
          //   onPressed: () {
          //
          //   },
          //   icon: Icon(
          //       ? Icons.format_size
          //       : Icons.format_size_outlined),
          // ),


          ElevatedButton(
            onPressed: () {
              // 保存设置
              _settings.save();
            },
            child: Text('保存'),
          ),
        ],
      ),
    );
  }
}
