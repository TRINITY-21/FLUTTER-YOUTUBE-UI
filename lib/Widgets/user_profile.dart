import 'package:Youtube/models/users.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatelessWidget {
  final Users currentUser;
  
  UserProfile({
    this.currentUser
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(backgroundImage: currentUser.image, radius: 30,),
          Text(currentUser.name, style: TextStyle(fontSize: 14, fontFamily: "Helvetica", color: Color(0xFF909090)))
        ],
      ),
    );
  }
}