class HomeTiles {
  final String? imgPath;
  final String? title;
  final String? tag;

  HomeTiles({this.imgPath, this.title, this.tag});

  static List<HomeTiles> tileList = [
    HomeTiles(
        imgPath: "assets/images/cricket.png", title: "Skills", tag: "skills"),
    HomeTiles(
        imgPath: "assets/images/profile.png", title: "Profile", tag: "profile"),
    HomeTiles(
        imgPath: "assets/images/findUser.png",
        title: "Find Players",
        tag: "find")
  ];
}
