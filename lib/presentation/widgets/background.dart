import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool showBottomCircularLoading;

  const Background({
    super.key,
    required this.child,
    this.showBottomCircularLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/tm_background.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        child,
        showBottomCircularLoading
            ? const Positioned.fill(
          bottom: 15,
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Color(0xFF124893),
              ),
            ),
          ),
        )
            : const SizedBox(height: 1)
      ],
    );
  }
}
