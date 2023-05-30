import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyLottie extends StatefulWidget {
  final String title;
  final String lottie;

  const EmptyLottie({Key? key, required this.title, required this.lottie})
      : super(key: key);

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
      animationBehavior: AnimationBehavior.preserve,
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
          SizedBox(
            child: Lottie.asset(widget.lottie,
                animate: true,
                reverse: false,
                controller: _lottieController, onLoaded: (composition) {
              _lottieController.duration = composition.duration;
              _lottieController.forward();
            }),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
