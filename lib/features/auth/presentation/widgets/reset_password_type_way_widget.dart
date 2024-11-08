import 'package:flutter/material.dart';

import 'package:academe_x/lib.dart';

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
        height: 146   ,
        width: 327   ,
        decoration: BoxDecoration(
          color:isSelect? const Color(0xFF0077FF): const Color(0xFFF9F9F9),
          border: Border.all(
            color: const Color(0x38D9D9D9),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 20   , vertical: 20   ),
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
                    height: 20   ,
                    width: 20   ,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white
                      // color: isSelect? const Color(0xFF5A73F9) : const Color(0xFFF1F5F9),
                    ),
                    child: isSelect? const Icon(Icons.check,color: Colors.blue,size: 18,) : null  ,
                  )
                ],
              ),
              AppText(
                text: title,
                fontSize: 16  ,
                fontWeight: FontWeight.bold,
                color: isSelect? Colors.white : Colors.black,
              ),
              AppText(
                text: subtitle ,
                fontSize: 12  ,
                fontWeight: FontWeight.bold,
                color: isSelect? Colors.white : Colors.black,
              ),
            ],
          ),
        ));
  }
}
