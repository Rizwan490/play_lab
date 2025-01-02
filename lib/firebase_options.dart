
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx0rUIO2IqJcsrtRipxpeRfTQfI5LW4VE',
    appId: '1:478780527317:android:354bc924f271095fa3485c',
    messagingSenderId: '478780527317',
    projectId: 'playlab-55c29',
    storageBucket: 'playlab-55c29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4ybp3-BGU1DvjCZNMgXIoaho-Zy-asMY',
    appId: '1:478780527317:ios:a4dd9a516223ecd9a3485c',
    messagingSenderId: '478780527317',
    projectId: 'playlab-55c29',
    storageBucket: 'playlab-55c29.appspot.com',
    androidClientId: '478780527317-m2a9hbrije206h9ergl75tnv6nr7j4kj.apps.googleusercontent.com',
    iosClientId: '478780527317-81sac2ls2klt3n6nnuffjfve26lgic6h.apps.googleusercontent.com',
    iosBundleId: 'dev.vlab.playlab.playLab',
  );

}