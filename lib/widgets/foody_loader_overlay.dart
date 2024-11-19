import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodyLoaderOverlay extends StatefulWidget {
  const FoodyLoaderOverlay({
    super.key,
    required this.child,
    this.canGoBack = true,
  });

  final Widget child;
  final bool canGoBack;

  static _FoodyLoaderOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<_FoodyLoaderOverlayState>()!;
  }

  @override
  State<FoodyLoaderOverlay> createState() => _FoodyLoaderOverlayState();
}

class _FoodyLoaderOverlayState extends State<FoodyLoaderOverlay> {
  bool _isLoading = false;

  void show() {
    if (!_isLoading) setState(() => _isLoading = true);
  }

  void hide() {
    if (_isLoading) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(opacity: animation, child: child),
          child: _isLoading
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    PopScope(
                      canPop: widget.canGoBack,
                      child: SizedBox.expand(
                        child: ColoredBox(color: Colors.grey.withOpacity(0.4)),
                      ),
                    ),
                    Lottie.asset(
                      "assets/lottie/loading.json",
                      height: 200,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
