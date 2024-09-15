import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung/bloc/auth/auth_bloc.dart';
import 'package:payuung/personal_info_screen.dart';

class ProfileMenuItem {
  final IconData iconData;
  final String name;
  final Function()? onTap;

  ProfileMenuItem(this.iconData, this.name, this.onTap);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? userId;

    final state = context.read<AuthBloc>().state;
    if (state is Authenticated) {
      userId = state.userId;
    }
    final profileMenuList = [
      ProfileMenuItem(
        Icons.person_outline,
        'Informasi Pribadi',
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalInfoScreen(
                  userId: userId,
                ),
              ));
        },
      ),
      ProfileMenuItem(
        Icons.description_outlined,
        'Syarat Dan Ketentuan',
        () {
          // Action untuk syarat dan ketentuan
        },
      ),
      ProfileMenuItem(
        Icons.help_outline,
        'Bantuan',
        () {
          // Action untuk bantuan
        },
      ),
      ProfileMenuItem(
        Icons.privacy_tip_outlined,
        'Kebijakan Privasi',
        () {
          // Action untuk kebijakan privasi
        },
      ),
      ProfileMenuItem(
        Icons.logout,
        'Logout',
        () {
          // Action untuk logout
        },
      ),
      ProfileMenuItem(
        Icons.delete_forever_outlined,
        'Hapus Akun',
        () {
          // Action untuk hapus akun
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey[50],
      ),
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          String? name; 
          if (state is AuthLoading) {
            return const CircularProgressIndicator();
          }

          if (state is Authenticated) {
            name = state.user.fullName;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      child: Text(
                        name?[0] ?? "",
                        style: const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text('Masuk dengan Google')
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileMenuList.length,
                  itemBuilder: (context, index) {
                    return _buildItem(
                        profileMenuList[index].iconData,
                        profileMenuList[index].name,
                        profileMenuList[index].onTap);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container _buildItem(IconData iconData, String name, void Function()? onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Icon(
            iconData,
            color: Colors.black,
          ),
        ),
        title: Text(name),
        onTap: onTap,
      ),
    );
  }
}
