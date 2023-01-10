//
// Generated file. Do not edit.
// This file is generated from template in file `flutter_tools/lib/src/flutter_plugins.dart`.
//

// @dart = 2.17

import 'dart:io'; // flutter_ignore: dart_io_import.
import 'package:geolocator_android/geolocator_android.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:google_maps_flutter_ios/google_maps_flutter_ios.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:flutter_keyboard_visibility_linux/flutter_keyboard_visibility_linux.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences_linux/shared_preferences_linux.dart';
import 'package:flutter_keyboard_visibility_macos/flutter_keyboard_visibility_macos.dart';
import 'package:shared_preferences_macos/shared_preferences_macos.dart';
import 'package:flutter_keyboard_visibility_windows/flutter_keyboard_visibility_windows.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

@pragma('vm:entry-point')
class _PluginRegistrant {

  @pragma('vm:entry-point')
  static void register() {
    if (Platform.isAndroid) {
      try {
        GeolocatorAndroid.registerWith();
      } catch (err) {
        print(
          '`geolocator_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        GoogleMapsFlutterAndroid.registerWith();
      } catch (err) {
        print(
          '`google_maps_flutter_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        SharedPreferencesAndroid.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isIOS) {
      try {
        GeolocatorApple.registerWith();
      } catch (err) {
        print(
          '`geolocator_apple` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        GoogleMapsFlutterIOS.registerWith();
      } catch (err) {
        print(
          '`google_maps_flutter_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        SharedPreferencesIOS.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isLinux) {
      try {
        FlutterKeyboardVisibilityPluginLinux.registerWith();
      } catch (err) {
        print(
          '`flutter_keyboard_visibility_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        PackageInfoPlusLinuxPlugin.registerWith();
      } catch (err) {
        print(
          '`package_info_plus` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        SharedPreferencesLinux.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isMacOS) {
      try {
        FlutterKeyboardVisibilityPluginMacos.registerWith();
      } catch (err) {
        print(
          '`flutter_keyboard_visibility_macos` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        SharedPreferencesMacOS.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_macos` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isWindows) {
      try {
        FlutterKeyboardVisibilityPluginWindows.registerWith();
      } catch (err) {
        print(
          '`flutter_keyboard_visibility_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        PackageInfoPlusWindowsPlugin.registerWith();
      } catch (err) {
        print(
          '`package_info_plus` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

      try {
        SharedPreferencesWindows.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    }
  }
}
