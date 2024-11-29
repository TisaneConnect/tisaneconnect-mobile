import 'package:flutter/cupertino.dart';

class Navigation {
  static final GlobalKey<NavigatorState> _nk = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get nk => _nk;

  goBack<T>({BuildContext? context, T? result}) =>
      Navigator.of(context ?? nk.currentContext!).pop(result);

  Future goReplace(Widget widget, [BuildContext? context]) async =>
      await Navigator.of(context ?? nk.currentContext!).pushReplacement(
        CupertinoPageRoute(
          builder: (_) => widget,
        ),
      );

  Future<T?> goPush<T>(Widget widget, [BuildContext? context]) async =>
      await Navigator.of(context ?? nk.currentContext!).push(
        CupertinoPageRoute(builder: (context) => widget),
      );
  Future goRemove(Widget widget, [BuildContext? context]) async =>
      await Navigator.of(context ?? nk.currentContext!).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => widget),
        (e) {
          return false;
        },
      );
}

Navigation nav = Navigation();
