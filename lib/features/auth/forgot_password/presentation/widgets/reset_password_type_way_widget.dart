import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/app_text.dart';

class ResetPasswordTypeWayWidget extends StatelessWidget {
  ResetPasswordTypeWayWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.isSelect
  });


  String title;
  IconData icon;
  String subtitle;
  bool isSelect;



  @override
  Widget build(BuildContext context) {
    return Container(
        height: 146.h,
        width: 327.w,
        decoration: BoxDecoration(
          color:isSelect? const Color(0xFF0077FF): const Color(0xFFF9F9F9),
          border: Border.all(
            color: const Color(0x38D9D9D9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: isSelect? const Color(0xFF5A73F9) : const Color(0xFFF1F5F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    child:  Icon(
                      icon,
                      color:isSelect? Colors.white :Colors.blue ,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20.h,
                    width: 20.w,
                    child: isSelect? Icon(Icons.check,color: Colors.blue,size: 18,) : null  ,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white
                      // color: isSelect? const Color(0xFF5A73F9) : const Color(0xFFF1F5F9),
                    ),
                  )
                ],
              ),
              AppText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isSelect? Colors.white : Colors.black,
              ),
              AppText(
                text: subtitle ,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: isSelect? Colors.white : Colors.black,
              ),
            ],
          ),
        ));
  }
}
