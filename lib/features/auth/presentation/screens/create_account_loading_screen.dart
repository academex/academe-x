import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  _AccountCreationScreenState createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Loop

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/account_creation_success');
    });// animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2200F3),
      appBar: AppCustomAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        showCloseButton: true, // Add close button
        onCloseButtonPressed: () {
          // Custom action or Navigator.pop(context)
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24   , vertical: 40   ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
        //   SvgPicture.string(
        //   mySignInRobotSVG,
        //   height: 150   ,
        //   width: 150   ,
        // ),
          20.ph(),
          AppText(
            text:
            context.localizations.accountCreationLoadingTitle,
            fontSize: 26 ,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          13.ph(),
          AppText(
            text:
            context.localizations.accountCreationLoadingSubTitle,
            fontSize: 16 ,
            // fontWeight: FontWeight.n,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
          21.ph(),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                  6.pw(),
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.2, 0.7, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                  6.pw(),
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                  6.pw(),
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                ],
              );
            },
          ),
          const Spacer(),
          AppText(
            text:
            context.localizations.accountPreparationMessage,
            fontSize: 12 ,
            color: Colors.white,
          )
    ])));

  }

  Widget _buildDot() {
    return Container(
      height: 6   ,
      width: 6   ,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
