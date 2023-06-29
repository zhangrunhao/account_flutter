import 'package:flutter/material.dart';

class BgWidget extends StatelessWidget {
  final Widget child;

  const BgWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 486,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/bg/mask_6.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
