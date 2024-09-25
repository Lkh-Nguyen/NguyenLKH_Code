import '../model/view.dart';

class Data {
  static List<String> typeView = [
    "Best Nature",
    "Most Viewed",
    "Recommend",
    "Nice Viewed",
    "Highland Viewed",
    "MongoDB SQL",
  ];

  static List<Viewer> views = [
    Viewer(
        id: 1,
        url: "assets/images/eiffel_tower.png",
        name: "Eiffel Tower",
        country: "Paris"),
    Viewer(
        id: 2,
        url: "assets/images/sunrises.png",
        name: "Sunrises Tower",
        country: "Viet Nam"),
    Viewer(
        id: 2,
        url: "assets/images/thebridge.png",
        name: "Thap Doi Marry",
        country: "Singapore"),
    Viewer(
        id: 3,
        url: "assets/images/eiffel_tower.png",
        name: "Makert DaLat",
        country: "Hong kong"),
    Viewer(
        id: 4,
        url: "assets/images/sunrises.png",
        name: "The Way Tower",
        country: "ThaiLamd"),
  ];
}
