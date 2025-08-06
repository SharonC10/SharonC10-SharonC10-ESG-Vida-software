import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/provider/chat.dart';
import 'package:ESGVida/provider/news.dart';
import 'package:ESGVida/provider/post.dart';
import 'package:ESGVida/provider/shopping/address.dart';
import 'package:ESGVida/provider/shopping/product_order.dart';
import 'package:ESGVida/provider/shopping/shop.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:ESGVida/provider/shopping/shoppingcart.dart';
import 'package:ESGVida/provider/user.dart';
import 'package:ESGVida/provider/shopping/wishlist.dart';
import 'package:ESGVida/view/main/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import "package:flutter_easyloading/flutter_easyloading.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.defaultImportance,
    playSound: true,
    enableLights: true,
    showBadge: true,
    enableVibration: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyA7yXV4e8eLDPWqv-GHVQR3NfH2KOnZO2Q',
    appId: '1:737299795853:android:d64e46debe6e6bbcbff7c4',
    messagingSenderId: '737299795853',
    projectId: 'esg-vida',
    storageBucket: 'esg-vida.appspot.com',
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyA7yXV4e8eLDPWqv-GHVQR3NfH2KOnZO2Q',
    appId: '1:737299795853:android:d64e46debe6e6bbcbff7c4',
    messagingSenderId: '737299795853',
    projectId: 'esg-vida',
    storageBucket: 'esg-vida.appspot.com',
  ));
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  FirebaseMessaging.instance.getInitialMessage();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    if (message.notification != null) {
      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> init() async {
  await GlobalInMemoryData.I.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: () {
        Get.put(UserProvider());
        Get.put(NewsProvider());
        Get.put(PostProvider());
        Get.put(WishListProvider());
        Get.put(ShoppingCartProvider());
        Get.put(ProductProvider());
        Get.put(AddressProvider());
        Get.put(ChatProvider());
        Get.put(ShopProvider());
        Get.put(ProductOrderProvider());
        Get.put(
          CacheManager(
            Config(
              "ESGVidaCacheManager",
              maxNrOfCacheObjects: 100,
            ),
          ),
        );
      },
      translations: Languages(),
      fallbackLocale: LocaleUtils.fromDash(CommonConstant.DEFAULT_LOCALE),
      // locale: LocaleUtils.fromDash(GlobalInMemoryData.I.locale),
      locale: GlobalInMemoryData.I.locale != null
    ? LocaleUtils.fromDash(GlobalInMemoryData.I.locale!)
    : LocaleUtils.fromDash(CommonConstant.DEFAULT_LOCALE),

      title: 'ESG-Vida',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.transparent),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
