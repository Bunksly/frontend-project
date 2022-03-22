class Foodbank {
  final String imagePath;
  final String name;
  final String address;
  final String items;//might not need this, was thinking about putting location/radius
  final bool isDarkMode;

  const Foodbank ({
   required this.imagePath,
   required this.name,
   required this.address,
   required this.items,//might not need this
   required this.isDarkMode,
  });
}


