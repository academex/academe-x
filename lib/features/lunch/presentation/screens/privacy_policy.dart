import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24   ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close icon at the top-left
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the page
                    },
                  ),
                  Text(
                    'سياسة الخصوصية',
                    style: TextStyle(
                      fontSize: 20  ,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Space to align text center
                ],
              ),
              10.ph(),

              // Image Section
              Center(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16 ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/privecy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              16.ph(),

              // Date of last update
              Text(
                'اخر تحديث: 23/05/2023',
                style: TextStyle(
                  fontSize: 12  ,
                  color: Colors.grey,
                ),
              ),
              16.ph(),
              Text(
                'يرجى قراءة سياسة الخصوصية هذه بعناية قبل استخدام تطبيقنا الذي يتم تشغيله بواسطتنا.',
                style: TextStyle(
                  fontSize: 16  ,
                  height: 1.5, // Line height for better readability
                ),
                textAlign: TextAlign.justify,
              ),
              7.ph(),
              // Privacy Policy Text (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  child:  Text(
                    'يرجى قراءة سياسة الخصوصية هذه بعناية قبل استخدام تطبيقنا الذي تم تشغيله بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باه بواسطة شركتنا. هناك العديد من الأشياء الشائكة المتعلقة باستخدام Lorem Ipsum. على سبيل المثال، قد يؤدي إدخال بعض الكلمات أو الكلمات المجمعة التي لا تبدو حقيقية إلى نشوء نتائج غير متوقعة. إذا كنت مستخدمًا مطبقًا من Lorem Ipsum، فعليك اتخاذ قرار عدم وجود أي كائن صادر عن مصدر معين. في مثل هذه الحالة، يكون Lorem Ipsum فعالًا. المرات التي يمكن أن تصبح Lorem Ipsum سحرية هي أكثر الأوقات تعقيدًا. قد تحتاج أيضًا إلى التأكد من عدم وجود العديد من أدوات النص السحرية في المجال المجاني.',
                    style: TextStyle(
                      fontSize: 16  ,
                      height: 1.5, // Line height for better readability
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              15.ph(),
            ],
          ),
        ),
      ),
    );
  }
}
