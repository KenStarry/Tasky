import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyLottie extends StatefulWidget {
  const EmptyLottie({Key? key}) : super(key: key);

  @override
  State<EmptyLottie> createState() => _EmptyLottieState();
}

class _EmptyLottieState extends State<EmptyLottie>
    with TickerProviderStateMixin {
  //  controller to control our lottie animation
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset("assets/lottie/empty_box_shake.json",
              animate: true,
              reverse: false,
              controller: _lottieController, onLoaded: (composition) {
            _lottieController.duration = composition.duration;
            _lottieController.forward();
          }),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Nothing to see here...",
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
