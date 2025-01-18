import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foody_app/main.dart' show objectBox;
import 'package:foody_app/utils/download_and_save_file.dart';

import '../firebase_options.dart';
import '../models/user.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  print("NOTIFICA RICEVUTO IN BACKGROUND");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _setupFlutterNotifications();
  _showLocalNotification(message);
}

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidNotificationChannel _channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<void> _setupFlutterNotifications() async {
  _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

bool _hasChatOpen(RemoteMessage message) {
  final userBox = objectBox.store.box<User>();
  final user = userBox.getAll();

  return user.isNotEmpty &&
      message.data.containsKey("roomId") &&
      user.first.currentFirebaseRoomId == message.data["roomId"];
}

Future<void> _showLocalNotification(RemoteMessage message) async {
  if (_hasChatOpen(message)) return;

  final notification = message.notification;

  print(message.data);

  print('Notification: ${notification?.title}, ${notification?.body}');

  if (notification?.android != null) {
    StyleInformation? styleInformation;
    String icon = "launch_background";

    if (message.notification?.android?.imageUrl != null) {
      icon = await downloadAndSaveFile(
        message.notification!.android!.imageUrl!,
        "avatar_local_notification",
      );

      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(icon),
        // largeIcon: FilePathAndroidBitmap(avatar),
        // contentTitle: 'Titolo della notifica',
        // summaryText: 'Testo della notifica',
      );
    }

    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: 'launch_background',
          largeIcon: FilePathAndroidBitmap(icon),
          // styleInformation: styleInformation,
        ),
      ),
    );
  }
}

Future<void> initFirebaseFCM() async {
  // Configura le notifiche locali per il foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("NOTIFICA RICEVUTO IN FOREGROUND");
    _showLocalNotification(message);
  });

  // Configura le notifiche in background
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await _setupFlutterNotifications();
}
