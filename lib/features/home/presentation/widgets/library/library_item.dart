import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryItem extends StatelessWidget {
  final LibraryEntity file;


  const LibraryItem({
    required this.file,
    super.key,
  });

  Future<void> _launchURL(String fileUrl) async {
    final Uri url = Uri.parse(fileUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE2E2E2)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async{
                // await _launchURL(file.url!);
                await showFileDetails(context);

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: file.name!,
                      fontSize: 14.01,
                      color: Color(0xff0F172A),
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      text:  file.description! ?? '',
                      fontSize: 12.01,
                      color: Color(0xff64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () async{
                  await _launchURL(file.url!);
                },
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    'assets/icons/download_file.png',
                    height: 24.02,
                    width: 24.02,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showFileDetails(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx){
        return Container(
          height: 659,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              16.ph(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE7E8EA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),

                ],
              ),
              16.ph(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        AppText(
                          text: 'تفاصيل الكتاب',
                          fontSize: 16,
                          color: Color(0xff0F172A),
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.close))
                      ],
                    ),
                    20.ph(),
                    Container(
                      width: 327,
                      height: 148,
                      decoration: ShapeDecoration(
                        color: Colors.grey,
                        // image: DecorationImage(
                        //   image: NetworkImage("https://placehold.co/327x148"),
                        //   fit: BoxFit.cover,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    16.ph(),

                    Row(
                      children: [
                        AppText(
                          text: file.name!,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.star, color: file.isStared! ? Color(0xffFFC107) :Colors.grey.shade200 , size: 25,),padding: EdgeInsets.zero,),
                            4.pw(),
                            AppText(
                              text: file.stars.toString(),
                              fontSize: 12,
                              color: Color(0xff64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        )

                      ],
                    ),
                    10.ph(),
                    Row(
                      children: [
                        AppText(
                          text: file.subject!,
                          fontSize: 12,
                          color: Color(0xff64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    20.ph(),
                    CustomButton(widget: AppText(text: 'تنزيل', color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      ), onPressed: () async{
                      //I want to download file not open it in browser
                      await _launchURL(file.url!);

                    },   backgraoundColor: const Color(0xFF0077FF),),

                    // AppText(
                    //   text: 'Uploaded By',
                    //   fontSize: 12.01,
                    //   color: Color(0xff64748B),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // 8.ph(),
                    // AppText(
                    //   text: '${file.user!.firstName} ${file.user!.lastName}',
                    //   fontSize: 12.01,
                    //   color: Color(0xff64748B),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // 16.ph(),
                    // AppText(
                    //   text: 'Uploaded On',
                    //   fontSize: 12.01,
                    //   color: Color(0xff64748B),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // 8.ph(),
                    // AppText(
                    //   text: file.createdAt!,
                    //   fontSize: 12.01,
                    //   color: Color(0xff64748B),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // 16.ph(),
                    // AppText(
                    //   text: 'Download',
                    //   fontSize: 12.01,
                    //   color: Color(0xff64748B),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // 8.ph(),
                    // GestureDetector(
                    //   onTap: () async{
                    //     await _launchURL(file.url!);
                    //   },
                    //   child: AppText(
                    //     text: file.url!,
                    //     fontSize: 12.01,
                    //     color: Color(0xff64748B),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),

                  ],
                ),
              )
            ],
        ));
      }

    );
  }
}
