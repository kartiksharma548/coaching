class HomeTiles {
  final String? imgPath;
  final String? title;
  final String? tag;
  final String? route;

  HomeTiles({this.imgPath, this.title, this.tag, this.route});

  static List<HomeTiles> tileList = [
    HomeTiles(
        imgPath: "assets/images/cricket.png",
        title: "Skills",
        tag: "skills",
        route: "/skill"),
    HomeTiles(
        imgPath: "assets/images/profile.png",
        title: "Profile",
        tag: "profile",
        route: "/profile"),
    HomeTiles(
        imgPath: "assets/images/findUser.png",
        title: "Find Player",
        tag: "find",
        route: "/searchPlayer"),
    HomeTiles(
        imgPath: "assets/images/addUser.png",
        title: "Add Player",
        tag: "add",
        route: "/addPlayer"),
    HomeTiles(
        imgPath: "assets/images/logout.png",
        title: "Logout",
        tag: "logout",
        route: "/login"),
  ];
}
