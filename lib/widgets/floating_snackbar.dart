import 'package:flutter/material.dart';

class FloatingSnackBar extends StatefulWidget {
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets margin;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final Color? iconColor;

  const FloatingSnackBar({
    Key? key,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor = const Color(0xFF323232),
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.margin = const EdgeInsets.all(16.0),
    this.onDismiss,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = const Color(0xFF323232),
    Color textColor = Colors.white,
    double borderRadius = 8.0,
    EdgeInsets margin = const EdgeInsets.all(16.0),
    VoidCallback? onDismiss,
    IconData? icon,
    Color? iconColor,
  }) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (BuildContext context) => FloatingSnackBar(
        message: message,
        duration: duration,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        margin: margin,
        onDismiss: onDismiss,
        icon: icon,
        iconColor: iconColor,
      ),
    );

    overlay.insert(entry);
  }

  @override
  State<FloatingSnackBar> createState() => _FloatingSnackBarState();
}

class _FloatingSnackBarState extends State<FloatingSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().whenComplete(() {
          if (mounted) {
            Navigator.of(context).maybePop();
            widget.onDismiss?.call();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: widget.margin,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: widget.iconColor ?? widget.textColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
