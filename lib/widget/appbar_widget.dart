import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//this is the file using building the AppBar, then link it back to the profile_page.dart


AppBar buildAppBar(BuildContext context) {
   final icon = CupertinoIcons.moon_stars;

  return AppBar(  //Top bar on the top of the page
    leading: BackButton(),    //backbutton on the top left hand corner 
    backgroundColor: Colors.green.shade100,//.transparent,  // make
    elevation: 0, // removing all the shadow from the AppBar
    actions: [
      IconButton(icon: Icon(icon),
                  onPressed: () {},
      ),
    ],
  );
}