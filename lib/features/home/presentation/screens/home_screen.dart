import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/home/bottom_nav_cubit.dart';
import 'package:academe_x/features/home/presentation/screens/community_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_bottom_nav_bar.dart';
import 'library_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => BottomNavCubit(),
        child: BlocBuilder<BottomNavCubit, int>(
          builder: (context, currentIndex) {
            return Scaffold(
              floatingActionButton:currentIndex==1 ?
               SizedBox(
                width: 60.0,
                height: 60.0,
                 child: Image.asset('assets/icons/upload_file.png'),
                // child:
              )
                    : 0.ph(),
                bottomNavigationBar: const CustomBottomNavBar(),
                body: IndexedStack(
                  index: currentIndex,
                  children: const [CommunityPage(),LibraryPage(), Text('2'), Text('3')],
                ));
          },
        ));
  }
}
