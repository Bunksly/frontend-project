import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
   final String imagePath;
   final VoidCallback onClicked;

  const ProfileWidget({ 
    Key? key,
    required this.imagePath,
    required this.onClicked,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final colour = Theme.of(context).colorScheme.primary;

  return Center(
    child: buildImage(),
  );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return Ink.image(
      image: image,
      fit: BoxFit.cover,
      width: 220,
      height: 128,
               
    );
  }
}
