import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cctquake/mainscreen/loading_screen.dart';
import 'package:cctquake/screens/Home/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_background_service/flutter_background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String? lastNotificationTitle;
String? lastNotificationBody;

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
  );
}

// Background service initialization
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Local notifications setup
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'earthquake_alerts',
    'Cctquake Alerts',
    channelDescription:
        'This channel is used for earthquake alert notifications.',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Firestore listener
  StreamSubscription? firestoreListener;
  firestoreListener = FirebaseFirestore.instance
      .collection('earthquake_data')
      .snapshots()
      .listen((QuerySnapshot snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.added) {
        Map<String, dynamic> data =
            docChange.doc.data() as Map<String, dynamic>;

        String? intensity = data['intensity'];
        String? timestamp = data['timestamp'];

        if (intensity != null && timestamp != null) {
          try {
            DateTime parsedTimestamp =
                DateFormat('HH:mm:ss dd/MM/yyyy').parse(timestamp);

            DateTime today = DateTime.now();
            bool isToday = parsedTimestamp.year == today.year &&
                parsedTimestamp.month == today.month &&
                parsedTimestamp.day == today.day;

            if (intensity != "No Earthquake" && isToday) {
              // Format the timestamp as "h:mm a, MMMM d, yyyy"
              String formattedTimestamp =
                  DateFormat('h:mm a, MMMM d, yyyy').format(parsedTimestamp);

              // Local notification
              flutterLocalNotificationsPlugin.show(
                  0,
                  'Earthquake has been detected!',
                  'Intensity: $intensity at $formattedTimestamp',
                  platformChannelSpecifics);

              // OneSignal notification
              _showNotification('Earthquake has been detected!',
                  'Intensity: $intensity at $formattedTimestamp');
            }
          } catch (e) {
            print('Error processing notification: $e');
          }
        }
      }
    }
  });

  // Handle service background/foreground mode
  service.on('stopService').listen((event) {
    firestoreListener?.cancel();
    service.stopSelf();
  });
}

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      initialNotificationTitle: "CCTQuake Background Service",
      initialNotificationContent: "Listening for earthquake alerts",
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onBackground: onIosBackground,
      onForeground: onStart,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}
  try {
    final response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Key $restApiKey',
      },
      body: jsonEncode({
        'app_id': oneSignalAppId, // OneSignal App ID
        'included_segments': ['Subscribed Users'],
        'headings': {'en': title},
        'contents': {'en': body},
      }),
    );

    if (response.statusCode == 200) {
      print('OneSignal notification sent successfully!');
    } else {
      print('Failed to send OneSignal notification: ${response.body}');
    }
  } catch (e) {
    print('Error sending OneSignal notification: $e');
  }
}

// Function to display notifications (Modified)
void _showNotification(String title, String body) async {
  if (title == lastNotificationTitle && body == lastNotificationBody) {
    return;
  }

  lastNotificationTitle = title;
  lastNotificationBody = body;

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'earthquake_alerts', // Channel ID
    'Cctquake Alerts', // Channel Name
    channelDescription:
        'This channel is used for earthquake alert notifications.',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Show local notification
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'Earthquake Alert',
  );

  // Push notification through OneSignal
  await _sendOneSignalNotification(title, body);
}

// Modify your main() function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Lock the orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const CctquakeAlertsApp());
  });
  // Initialize background service
  await initializeBackgroundService();

  // Set up background message handler for Firebase
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      print("Notification Payload: ${response.payload}");
    },
  );

  runApp(const CctquakeAlertsApp());
}

class CctquakeAlertsApp extends StatelessWidget {
  const CctquakeAlertsApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions for iOS (if applicable)
    messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle notification when app is in terminated state
    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _showNotification(
          message.notification?.title ?? 'No Title',
          message.notification?.body ?? 'No Body',
        );
      }
    });

    // Handle notifications when app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
      );
    });

    // Listen to changes in Firestore
    FirebaseFirestore.instance
        .collection('earthquake_data')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      for (var docChange in snapshot.docChanges) {
        if (docChange.type == DocumentChangeType.added) {
          Map<String, dynamic> data =
              docChange.doc.data() as Map<String, dynamic>;
          String? intensity = data['intensity'];
          String? timestamp = data['timestamp'];

          if (intensity != null && timestamp != null) {
            DateTime parsedTimestamp;
            try {
              parsedTimestamp =
                  DateFormat('HH:mm:ss dd/MM/yyyy').parse(timestamp);
            } catch (e) {
              print('Error parsing timestamp: $timestamp');
              continue;
            }

            DateFormat('HH:mm:ss dd/MM/yyyy').format(parsedTimestamp);
            DateTime today = DateTime.now();
            parsedTimestamp.month == today.month &&
                parsedTimestamp.day == today.day;

          } else {
            print('Invalid data: Missing intensity or timestamp.');
          }
        }
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        Home.id: (context) => Home(),
      },
    );
  }
}
