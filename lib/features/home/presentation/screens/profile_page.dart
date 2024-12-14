import 'package:academe_x/core/widgets/widgets.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        CustomButton(widget: AppText(text: 'Logout', fontSize: 16), onPressed:() async{
        await  context.read<LoginCubit>().logout();

        }, backgraoundColor: Colors.blue)
      ],
    );
  }
}
