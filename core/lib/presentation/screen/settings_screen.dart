import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16),
    child: Column(
        children:  [
          const SizedBox(height: 32,),
          const Divider(
            color: kGrey,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/slider');
              },
              child: const Text('Keluar', style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: kRichBlack
              ),
            ),),
          ),
          const Divider(
            color: kGrey,
          )
        ],
      ),
    );
  }

}