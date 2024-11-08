import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RobotIntroScreen extends StatelessWidget {
  const RobotIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppCustomAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24   ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50   ), // Use SizedBox for vertical spacing
            // Load the SVG robot logo
            SvgPicture.string(
              '''<svg width="154" height="154" viewBox="0 0 154 154" fill="none" xmlns="http://www.w3.org/2000/svg">
             <path d="M3.12756 76.6573C3.12756 35.74 36.2973 2.57068 77.2136 2.57068C118.131 2.57068 151.3 35.74 151.3 76.6573C151.3 117.575 118.131 150.743 77.2136 150.743C36.2973 150.743 3.12756 117.575 3.12756 76.6573Z" fill="#E4EDFF"/>
<mask id="mask0_9_30675" style="mask-type:luminance" maskUnits="userSpaceOnUse" x="3" y="2" width="149" height="149">
<path d="M3.12756 76.6573C3.12756 35.74 36.2973 2.57068 77.2136 2.57068C118.131 2.57068 151.3 35.74 151.3 76.6573C151.3 117.575 118.131 150.743 77.2136 150.743C36.2973 150.743 3.12756 117.575 3.12756 76.6573Z" fill="white"/>
</mask>
<g mask="url(#mask0_9_30675)">
<path d="M43.6458 202.248L34.4202 152.071C31.0645 133.817 39.3369 116.672 53.3005 116.672H103.518C117.481 116.672 125.755 133.817 122.399 152.071L113.173 202.248C111.329 212.277 102.822 219.725 94.0969 219.725H62.7223C53.9973 219.725 45.4901 212.277 43.6458 202.248Z" fill="#70A2FF"/>
<path d="M63.4354 116.672H93.6756V107.518H63.4354V116.672Z" fill="#474CA8"/>
<path d="M102.096 107.699H54.6999C43.2521 107.699 33.8859 98.332 33.8859 86.8853V66.1906C33.8859 54.7426 43.2521 45.376 54.6999 45.376H102.096C113.544 45.376 122.911 54.7426 122.911 66.1906V86.8853C122.911 98.332 113.544 107.699 102.096 107.699Z" fill="#70A2FF"/>
<path d="M102.096 107.699H93.6754V107.519H63.4354V107.699H54.7C54.688 107.699 54.677 107.699 54.6656 107.699C54.6636 107.699 54.6614 107.699 54.6588 107.699C54.65 107.699 54.6401 107.699 54.6312 107.699C54.6281 107.699 54.6254 107.699 54.6229 107.699C54.614 107.699 54.6052 107.699 54.5969 107.699C54.5937 107.699 54.5926 107.699 54.5901 107.699C54.5802 107.699 54.5708 107.699 54.5614 107.699C54.5604 107.699 54.5593 107.699 54.5588 107.699C54.5478 107.699 54.5369 107.699 54.526 107.699C48.663 107.649 43.3724 105.132 39.6088 101.156C42.1781 102.165 44.9614 102.741 47.8781 102.741H108.917C111.833 102.741 114.617 102.165 117.187 101.156C113.423 105.132 108.132 107.649 102.27 107.699H102.269C102.258 107.699 102.248 107.699 102.237 107.699C102.236 107.699 102.235 107.699 102.234 107.699C102.224 107.699 102.216 107.699 102.206 107.699C102.203 107.699 102.202 107.699 102.199 107.699C102.19 107.699 102.181 107.699 102.173 107.699C102.17 107.699 102.167 107.699 102.165 107.699C102.155 107.699 102.145 107.699 102.136 107.699C102.134 107.699 102.132 107.699 102.13 107.699C102.119 107.699 102.107 107.699 102.096 107.699Z" fill="#577CE6"/>
<path d="M56.325 100.716C48.3067 100.716 41.7838 94.1921 41.7838 86.1761V66.9001C41.7838 58.8827 48.3067 52.3587 56.325 52.3587H100.472C108.489 52.3587 115.012 58.8827 115.012 66.9001V86.1761C115.012 94.1921 108.489 100.716 100.472 100.716H56.325Z" fill="#474CA8"/>
<path d="M112.265 65.7494C109.569 62.7107 105.54 60.776 101.031 60.776H55.7655C51.2567 60.776 47.227 62.7107 44.5306 65.7494C45.8176 59.6307 51.4968 55.0214 58.3108 55.0214H98.4848C105.299 55.0214 110.979 59.6307 112.265 65.7494Z" fill="#636CDF"/>
<path d="M56.9843 78.7974C56.9843 78.7974 57.1608 78.888 57.4916 79.06C57.8051 79.244 58.3046 79.5014 58.8806 79.792C59.4452 80.0947 60.1917 80.4107 60.9953 80.7694C61.8119 81.1174 62.7197 81.4894 63.7245 81.8227C67.7073 83.24 73.0302 84.2334 78.3978 84.2107C78.9379 84.1907 79.9275 84.2187 80.4608 84.1614C81.0764 84.1267 81.727 84.1067 82.3953 84.0414C83.7083 83.9161 85.0051 83.7747 86.2505 83.5494C87.5051 83.3494 88.701 83.0681 89.8494 82.7867C90.9838 82.4774 92.0806 82.1774 93.066 81.8161C94.0712 81.4814 94.9797 81.1107 95.7963 80.764C96.6021 80.4054 97.3431 80.0947 97.9197 79.7827C98.5067 79.4814 98.9879 79.2427 99.3026 79.06C99.6349 78.888 99.8119 78.7974 99.8119 78.7974C99.8119 78.7974 99.7363 78.9814 99.5958 79.3254C99.44 79.6587 99.2379 80.1867 98.8639 80.7707C98.1723 81.9867 96.9624 83.6414 95.102 85.2374C93.2572 86.8414 90.7729 88.3774 87.8687 89.4214C86.4223 89.9587 84.8759 90.3801 83.2791 90.6454C82.492 90.7801 81.6697 90.9134 80.8015 90.9627C79.8541 91.052 79.3483 91.0387 78.3978 91.0774C76.7572 91.0307 75.1103 90.9521 73.5171 90.6401C71.9218 90.3681 70.3745 89.9547 68.9297 89.4134C66.0265 88.3681 63.5436 86.832 61.6988 85.2294C59.8354 83.6307 58.6348 81.9894 57.927 80.7614C57.542 80.1667 57.3587 79.6587 57.202 79.3254C57.0598 78.9814 56.9843 78.7974 56.9843 78.7974Z" fill="#42F9FF"/>
<path d="M99.812 71.58C93.9136 68.716 88.8098 69.0373 83.1797 71.58C85.4218 63.336 97.274 63.08 99.812 71.58Z" fill="#42F9FF"/>
<path d="M98.8572 99.076H57.939C50.9973 99.076 45.213 94.4654 43.9026 88.3467C46.6483 91.3854 50.753 93.3201 55.3458 93.3201H101.45C106.043 93.3201 110.148 91.3854 112.893 88.3467C111.584 94.4654 105.799 99.076 98.8572 99.076Z" fill="#373A98"/>
<path d="M56.9843 68.9507C56.9843 66.1253 59.275 63.8347 62.1005 63.8347C64.9254 63.8347 67.2166 66.1253 67.2166 68.9507C67.2166 71.776 64.9254 74.0667 62.1005 74.0667C59.275 74.0667 56.9843 71.776 56.9843 68.9507Z" fill="#42F9FF"/>
<path d="M63.4354 112.096H93.6756V107.699H63.4354V112.096Z" fill="#373A98"/>
<path d="M63.4354 107.699H93.6756V107.518H63.4354V107.699Z" fill="#435FCF"/>
<path d="M123.473 88.3467H122.823V66.1907H123.473C129.592 66.1907 134.552 71.1507 134.552 77.2693C134.552 83.388 129.592 88.3467 123.473 88.3467Z" fill="#474CA8"/>
<path d="M131.7 75.1614C131.588 75.1614 131.471 75.1374 131.355 75.088C129.633 74.3414 127.657 73.7254 125.495 73.2734C125.084 73.1867 124.781 72.8307 124.781 72.4107V68.5614C124.781 68.064 125.189 67.6547 125.656 67.6547C125.732 67.6547 125.811 67.6654 125.888 67.6894C128.969 68.6107 131.436 70.9587 132.539 73.96C132.76 74.5654 132.277 75.1614 131.7 75.1614Z" fill="#636CDF"/>
<path d="M123.473 88.348H122.859V88.3467H123.473C123.889 88.3467 124.301 88.324 124.705 88.28C124.301 88.3254 123.891 88.348 123.473 88.348Z" fill="#B0B5E6"/>
<path d="M122.823 88.348H122.859V88.3467H122.823V88.348Z" fill="#577CE6"/>
<path d="M123.473 88.3467H122.823V68.44L124.833 82.868C124.983 83.9333 125.892 84.684 126.915 84.684C127.092 84.684 127.272 84.6613 127.452 84.6147C129.459 84.088 132.231 83.196 133.433 82.0387C131.816 85.4067 128.572 87.848 124.705 88.28C124.301 88.324 123.889 88.3467 123.473 88.3467Z" fill="#373A98"/>
<path d="M33.2343 88.3467H33.8859V66.1907H33.2343C27.1155 66.1907 22.1556 71.1507 22.1556 77.2693C22.1556 83.388 27.1155 88.3467 33.2343 88.3467Z" fill="#474CA8"/>
<path d="M25.0078 75.1614C24.4302 75.1614 23.9478 74.5654 24.1696 73.96C25.2723 70.9587 27.7374 68.6107 30.8196 67.6894C30.8972 67.6654 30.9754 67.6547 31.0515 67.6547C31.5182 67.6547 31.927 68.064 31.927 68.5614V72.4107C31.927 72.8307 31.6239 73.1867 31.2135 73.2734C29.051 73.7254 27.0739 74.3414 25.3535 75.088C25.2374 75.1374 25.1207 75.1614 25.0078 75.1614Z" fill="#636CDF"/>
<path d="M33.8859 88.348H33.2343C32.8177 88.348 32.4062 88.3254 32.0021 88.28C32.4067 88.324 32.8177 88.3467 33.2343 88.3467H33.8859V86.8854V88.348Z" fill="#B0B5E6"/>
<path d="M33.886 88.3467H33.2344C32.8177 88.3467 32.4068 88.324 32.0021 88.28C28.1349 87.848 24.8921 85.4067 23.275 82.0387C24.4781 83.196 27.2494 84.088 29.2557 84.6147C29.436 84.6613 29.6161 84.684 29.7926 84.684C30.815 84.684 31.726 83.9333 31.8745 82.868L33.886 68.44V86.8854V88.3467Z" fill="#373A98"/>
<path d="M61.5426 134.157L55.7983 127.645C55.6635 126.671 55.4505 125.721 55.1655 124.803L62.5969 133.227L61.5426 134.157Z" fill="#5275D9"/>
<path d="M95.2624 134.157L94.2083 133.227L102.299 124.055C101.951 125.027 101.683 126.039 101.504 127.08L95.2624 134.157Z" fill="#5275D9"/>
<path d="M70.4447 130.636H86.351C94.3671 130.636 100.482 137.804 99.2193 145.72L95.9655 166.115C94.9562 172.439 89.5015 177.092 83.0969 177.092H73.6983C67.2947 177.092 61.8401 172.439 60.8306 166.115L57.5765 145.72C56.3139 137.804 62.4291 130.636 70.4447 130.636Z" fill="#474CA8"/>
<path d="M73.7005 173.379C69.0937 173.379 65.224 170.077 64.4978 165.531L61.2448 145.133C60.813 142.437 61.5817 139.699 63.3557 137.623C65.1254 135.543 67.7125 134.351 70.4431 134.351H86.3516C89.0828 134.351 91.665 135.543 93.439 137.62C95.2125 139.699 95.9812 142.437 95.553 145.133L92.3 165.529C91.5708 170.077 87.7005 173.379 83.0973 173.379H73.7005Z" fill="#42F9FF"/>
<path d="M93.7083 127.609H64.2802C63.413 127.609 62.6119 127.145 62.1806 126.393L59.7671 122.181C58.8431 120.568 60.0073 118.559 61.8661 118.559H96.1218C97.9797 118.559 99.1447 120.568 98.2207 122.181L95.8078 126.392C95.377 127.145 94.5754 127.609 93.7083 127.609Z" fill="#84C4FF"/>
<path d="M55.9713 130.152C55.9713 120.18 47.8874 112.096 37.9145 112.096C27.9426 112.096 19.8583 120.18 19.8583 130.152C19.8583 140.125 27.9426 148.209 37.9145 148.209C47.8874 148.209 55.9713 140.125 55.9713 130.152Z" fill="#474CA8"/>
<path d="M48.3322 144.903C52.9541 141.632 55.9713 136.245 55.9713 130.152C55.9713 130.063 55.9707 129.972 55.9693 129.881C55.9707 129.972 55.9718 130.061 55.9718 130.152C55.9718 136.245 52.9546 141.632 48.3322 144.903Z" fill="#577CE6"/>
<path d="M48.3322 144.903C46.4114 144.088 44.5302 143.196 42.6964 142.228C49.5057 140.359 54.6958 134.595 55.7526 127.483C55.8697 128.269 55.9535 129.067 55.9693 129.881C55.9707 129.972 55.9713 130.063 55.9713 130.152C55.9713 136.245 52.9541 141.632 48.3322 144.903Z" fill="#373A98"/>
<path d="M48.9218 122.899C48.7697 122.899 48.6098 122.871 48.4464 122.808C45.3021 121.609 41.7213 120.929 37.9145 120.929C34.1088 120.929 30.5281 121.609 27.3833 122.808C27.2197 122.871 27.0604 122.899 26.9078 122.899C25.8666 122.899 25.1697 121.572 25.9828 120.696C28.9573 117.492 33.1978 115.485 37.9145 115.485C42.6322 115.485 46.8729 117.492 49.8469 120.696C50.6604 121.572 49.9636 122.899 48.9218 122.899Z" fill="#636CDF"/>
<path d="M101.244 130.152C101.244 120.18 109.328 112.096 119.301 112.096C129.273 112.096 137.357 120.18 137.357 130.152C137.357 140.125 129.273 148.209 119.301 148.209C109.328 148.209 101.244 140.125 101.244 130.152Z" fill="#474CA8"/>
<path d="M107.864 144.125C103.823 140.815 101.244 135.784 101.244 130.152C101.244 130.061 101.244 129.972 101.246 129.881C101.245 129.972 101.244 130.063 101.244 130.152C101.244 135.784 103.823 140.815 107.864 144.125Z" fill="#577CE6"/>
<path d="M107.864 144.125C103.823 140.815 101.244 135.784 101.244 130.152C101.244 130.063 101.245 129.972 101.246 129.881C101.261 129.067 101.346 128.269 101.463 127.483C102.428 133.98 106.843 139.352 112.791 141.657C111.184 142.54 109.541 143.363 107.864 144.125Z" fill="#373A98"/>
<path d="M130.308 122.972C130.155 122.972 129.996 122.944 129.832 122.881C126.688 121.684 123.107 121.003 119.301 121.003C115.495 121.003 111.913 121.684 108.769 122.881C108.605 122.944 108.445 122.972 108.293 122.972C107.252 122.972 106.555 121.645 107.368 120.769C110.343 117.565 114.583 115.559 119.301 115.559C124.017 115.559 128.259 117.565 131.232 120.769C132.045 121.645 131.349 122.972 130.308 122.972Z" fill="#636CDF"/>
</g>
<path d="M77.2136 5.14395C37.7802 5.14395 5.69891 37.224 5.69891 76.6573C5.69891 116.091 37.7802 148.172 77.2136 148.172C116.647 148.172 148.728 116.091 148.728 76.6573C148.728 37.224 116.647 5.14395 77.2136 5.14395ZM77.2136 153.316C34.9448 153.316 0.555176 118.927 0.555176 76.6573C0.555176 34.388 34.9448 0 77.2136 0C119.483 0 153.872 34.388 153.872 76.6573C153.872 118.927 119.483 153.316 77.2136 153.316Z" fill="#E4EDFF"/>
              </svg>''',
              height: 150   ,
              width: 150   ,
            ),
        30.ph(), // Vertical spacing
            // Using AppText for the title
            AppText(
              text: context.localizations.robotIntroTitle,
              fontSize: 24  ,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
           20.ph(), // Vertical spacing
            // Using AppText for the description
            AppText(
              text:context.localizations.robotIntroSubTitle,
              fontSize: 16  ,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            40.ph(),// Vertical spacing
            // Using CustomButton for the "Start" button
            CustomButton(
              color: Colors.blueAccent,
              // text: ,
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');

                // Add your navigation logic here for the next step
              }, widget: AppText(text: context.localizations.startButton, fontSize: 16  ,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
