import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'firebase_options.dart' as prod;
import 'firebase_options_dev.dart' as dev;

enum Flavor {
  prod,
  dev,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'FamXpense';
      case Flavor.dev:
        return 'FamXpense Dev';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (appFlavor) {
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
