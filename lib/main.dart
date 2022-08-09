import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/pubnub_instance.dart';
import 'providers/app_data.dart';
import 'providers/messages.dart';
import 'providers/signals.dart';
import 'providers/presence.dart';
import 'screens/conversation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppData.init();
  await dotenv.load(fileName: '.env');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pn = PubNubInstance();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MessageProvider(pn),
        ),
        ChangeNotifierProvider.value(
          value: PresenceProvider(pn),
        ),
        ChangeNotifierProvider.value(
          value: SignalProvider(pn),
        )
      ],
      child: MaterialApp(
          title: 'PubNub Chat',
          theme: ThemeData(
            backgroundColor: Colors.blueGrey[50],
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.black12)),
            primarySwatch: Colors.blue,
          ),
          home: Conversation(),
          routes: {
            Conversation.routeName: (context) => Conversation(),
          }),
    );
  }
}
