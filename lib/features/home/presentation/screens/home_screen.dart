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


import 'package:academe_x/features/profile/presentation/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:academe_x/lib.dart';
import '../widgets/lib/flutter_reaction_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {

    // StorageService.getUser()!.user.
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          floatingActionButton: _buildFloatingActionButton(currentIndex),
          bottomNavigationBar: const CustomBottomNavBar(),
          body: _buildBody(currentIndex,context),
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

  Widget _buildBody(int currentIndex,BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: [
        CommunityPage(),
         LibraryPage(),
         Row(),
        Container(
          child: Center(
              child: CustomButton(widget: AppText(text: 'Logout', fontSize: 16), onPressed:() async{
                await  context.read<LoginCubit>().logout();

              }, backgraoundColor: Colors.blue)
          ),
        ),
        ProfilePage(),
      ],
    );
  }
  void _handleUploadFile() {
    // Handle file upload logic
  }
}


// class CoffeeApp extends StatelessWidget {
//   const CoffeeApp ({super.key});
//   int _currentCup = 0;
//
//   final List<Widget> _myCoffees = [
//     EspressoPage(),    // صفحة الفيد تبعك
//     LattePage(),       // صفحة الإشعارات
//     MochaPag(),        // البروفايل
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentCup,
//         children: _myCoffees,    // كل صفحة محتفظة بحالتها متل ما هي!
//       ),
//     );
//   }
// }
