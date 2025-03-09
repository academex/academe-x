import 'package:academe_x/features/college_major/controller/cubit/get_tags_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
    )..repeat();


    context.read<GetTagsCubit>().getTags();

    // context.read<CollegeMajorsCubit>().loadMajors();

    Future.delayed(const Duration(seconds: 4), () {
      context.go('/account_creation_success');
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
      // appBar: AppCustomAppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: const SizedBox(),
      //   showCloseButton: true, // Add close button
      //   onCloseButtonPressed: () {
      //     // Custom action or Navigator.pop(context)
      //   },
      // ),
      body: Stack(
        children: [
          Image.asset(AppAssets.lightUnderContent,width: 812,fit: BoxFit.fill,),

          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Spacer(),
                SvgPicture.string(
                  succesCreationRobotSVG,
                  height: 150   ,
                  width: 150   ,
                ),
                20.ph(),
                AppText(
                  text:
                  context.localizations.accountCreationLoadingTitle,
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                13.ph(),
                AppText(
                  text:
                  context.localizations.accountCreationLoadingSubTitle,
                  textAlign: TextAlign.center,
                  color: Colors.white.withOpacity(0.8799999952316284),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
                // 164.ph(),
                const Spacer(),
                AppText(
                  text:
                  context.localizations.accountPreparationMessage,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                40.ph()
              ]),
          Positioned(
            top: 19,
            right: 21,
            child:  Container(
              alignment: AlignmentDirectional.bottomStart,
              // transformAlignment: ,
              width: 54,
              height: 53.47,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_splash.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 76,
            left: -20,
            child:  Container(
              alignment: AlignmentDirectional.bottomStart,
              // transformAlignment: ,
              width: 54,
              height: 53.47,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_splash.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ));

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
