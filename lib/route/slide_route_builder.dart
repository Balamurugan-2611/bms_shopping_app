import 'package:flutter/cupertino.dart';

class SlideRouteBuilder extends PageRouteBuilder {
  final Widget page;

  SlideRouteBuilder({
    required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween<Offset>(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            final slideAnimation = tween.animate(curvedAnimation);

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
}
