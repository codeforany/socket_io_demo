import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class AnalyticHelper {
    static final AnalyticHelper sigleton = AnalyticHelper._internal();
  AnalyticHelper._internal();
  
  static AnalyticHelper get shared => sigleton;
  
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static eventLog(String eventName, Map<String,dynamic> data ) async {
      analytics.logEvent(
      name: eventName,
      parameters: data,
    );
  }
  
}