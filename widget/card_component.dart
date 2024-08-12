import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Color? color;
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const CardComponent({
    Key? key,
    this.color,
    required this.child,
    this.onTap,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color ?? Theme.of(context).cardColor,
      elevation: 4,  // Changed elevation for a more standard card effect
      shadowColor: Colors.black.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor.withOpacity(0.2),  // Adjusted splash color opacity
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),  // Default padding for better spacing
          child: child,
        ),
      ),
    );
  }
}
