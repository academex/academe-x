import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart'; // Import l10n

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _indexPage = 0;

  @override
  Widget build(BuildContext context) {
    // Data localized through AppLocalizations
    Map<String, List<String>> data = {
      'titles': [
        // context.localizations.onboarding_title_1,
        // context.localizations.onboarding_title_2,
        // context.localizations.onboarding_title_3,
      ],
      'descriptions': [
        // context.localizations.onboarding_desc_1,
        // context.localizations.onboarding_desc_2,
        // context.localizations.onboarding_desc_3,
      ],
      'images': [
        'assets/images/on_boarding_1.png',
        'assets/images/on_boarding_2.png',
        'assets/images/on_boarding_3.png',
      ],
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skip button at the top-right
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    context.pushReplacementNamed('/login');
                  },
                  child: Text(
                    'context.localizations.skip',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xffCBAEAE),
                    ),
                  ),
                ),
              ),
            ),
            24.ph(),
            // PageView for onboarding content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (int index) {
                  setState(() {
                    _indexPage = index;
                  });
                },
                itemBuilder: (context, indexPage) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        // Onboarding image with rounded corners
                        Container(
                          height: 335,
                          width: 327,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: AssetImage(data['images']![indexPage]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        20.ph(),
                        // Title text
                        Text(
                          data['titles']![indexPage],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.ph(),
                        // Description text
                        Text(
                          data['descriptions']![indexPage],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff848484),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            24.ph(),
            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 3; j++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: _indexPage != j ? 8.h : 24.h,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _indexPage != j
                          ? const Color(0xffCBD5E1)
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),
            30.ph(),
            // Buttons: Previous, Next, and Start
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  if (_indexPage > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_indexPage > 0) {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'context.localizations.previous',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  if (_indexPage > 0)
                    SizedBox(width: 15), // Spacing between buttons
                  // Next or Start button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_indexPage < 2) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        } else {
                          context.pushReplacementNamed('/login');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _indexPage < 2
                            ? 'context.localizations.next'
                            : 'context.localizations.start_now,',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.ph(),
            // Terms and privacy text at the bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 59),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'context.localizations.terms_and_conditions' + " ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0, 0, 0, 22),
                  ),
                  children: [
                    TextSpan(
                      text: 'context.localizations.privacy_policy',
                      style: TextStyle(
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed('/privacy_policy_page');
                        },
                    ),
                    TextSpan(
                      text: 'context.localizations.privacy_policy_suffix',
                    ),
                  ],
                ),
              ),
            ),
            14.ph(),
          ],
        ),
      ),
    );
  }
}
