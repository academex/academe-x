// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/core.dart';
// import '../../home.dart';
// import '../widgets/widget.dart';
// import 'community_page.dart';
// import 'library_page.dart';
//
//
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => BottomNavCubit(),
//         child: BlocBuilder<BottomNavCubit, int>(
//           builder: (context, currentIndex) {
//             return Scaffold(
//               floatingActionButton:currentIndex==1 ?
//                SizedBox(
//                 width: 60.0,
//                 height: 60.0,
//                  child: Image.asset('assets/icons/upload_file.png'),
//                 // child:
//               )
//                     : 0.ph(),
//                 bottomNavigationBar: const CustomBottomNavBar(),
//                 body: IndexedStack(
//                   index: currentIndex,
//                   children:  [CommunityPage(),LibraryPage(), Text('2'), Text('3')],
//                 ));
//           },
//         ));
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:academe_x/lib.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          floatingActionButton: _buildFloatingActionButton(currentIndex),
          bottomNavigationBar: const CustomBottomNavBar(),
          body: _buildBody(currentIndex),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(int currentIndex) {
    if (currentIndex != NavigationIndex.library) return const SizedBox.shrink();
    return SizedBox(
      width: 60.0,
      height: 60.0,
      child: FloatingActionButton(
        elevation: 2,
        backgroundColor: AppColors.primary,
        child: Image.asset(
         AppAssets.upload,
          width: 24,
          height: 24,
        ),
        onPressed: () => _handleUploadFile(),
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    return IndexedStack(
      index: currentIndex,
      children: [
        CommunityPage(),
        const LibraryPage(),
        const Row(),
        const Row()
        // ChatPage(),
        // ProfilePage(),
      ],
    );
  }

  void _handleUploadFile() {
    // Handle file upload logic
  }
}