import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  int currentIndex;
  final int length;

  PageViewIndicator({required this.currentIndex, required this.length}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: _indicator(currentIndex, length));
  }

  List<Widget> _indicator(int currentIndex, int length) {
    List<Widget> _indicators = [];

    for (int i = 0; i < length; i++) {
      bool isActive = currentIndex == i;
      _indicators.add(SizedBox(
        height: 10,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: isActive ? 10 : 8.0,
          width: isActive ? 12 : 8.0,
          decoration: BoxDecoration(
            boxShadow: [
              isActive
                  ? BoxShadow(
                      color: const Color(0XFF2FB7B2).withOpacity(0.71),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                    )
                  : const BoxShadow(
                      color: Colors.transparent,
                    )
            ],
            shape: BoxShape.circle,
            color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
          ),
        ),
      ));
    }

    return _indicators;
  }
}
