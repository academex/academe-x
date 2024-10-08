import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/const/app_robot.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({Key? key}) : super(key: key);

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

    Future.delayed(Duration(seconds: 4), () {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          IconButton(onPressed:() {
            
            
          },
          icon: Icon(Icons.close,color: Colors.white,),)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          SvgPicture.string(
          mySignInRobotSVG,
          height: 150.h,
          width: 150.w,
        ),
          20.ph(),
          AppText(
            text:
            'جارٍ انشاء حسابك',
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          13.ph(),
          AppText(
            text:
            'يتم الان تجهيز حسابك والمكتبة الخاصة بك حسب مستواك',
            fontSize: 16.sp,
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
                        curve: Interval(0.2, 0.7, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                  6.pw(),
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(0.4, 1.0, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                  6.pw(),
                  ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(0.8, 1.0, curve: Curves.easeInOut),
                      ),
                    ),
                    child: _buildDot(),
                  ),
                ],
              );
            },
          ),
          Spacer(),
          AppText(
            text:
            'سيستغرق تجهيز حسابك بعض الثواني',
            fontSize: 12.sp,
            color: Colors.white,
          )
    ])));

  }

  Widget _buildDot() {
    return Container(
      height: 6.w,
      width: 6.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
