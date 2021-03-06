

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PlayNotification extends Notification {
  final Object id;

  const PlayNotification({this.id});
}


class DragNotification extends Notification {
  final Object id;
  int value;
  bool drop;

  // Need to Add Settings Value to this notification object

  DragNotification({this.id, this.value, this.drop});
}


class TouchNotification extends Notification {
  final Object myID;

  const TouchNotification({this.myID});
}

class ChangeNotification extends Notification {
  final Object myID;

  const ChangeNotification({this.myID});
}

class TimerEndNotification extends Notification {
  final Object myID;

  const TimerEndNotification({this.myID});
}