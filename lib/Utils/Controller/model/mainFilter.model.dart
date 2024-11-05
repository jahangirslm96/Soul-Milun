import '../../Controller/model/Cities.model.dart';
class MainFilter{
//main filter info
  String minAgeFilter;
  String maxAgeFilter;
  String minHeightFilter;
  String maxHeightFilter;
  String educationFilter;
  CityData cityDataFilter;
//================


  MainFilter({
    required this.minAgeFilter,
    required this.maxAgeFilter,
    required this.minHeightFilter,
    required this.maxHeightFilter,
    required this.educationFilter,
    required this.cityDataFilter,

  });

  factory MainFilter.fromJson(Map<String, dynamic> json) {
    print(json);
    return MainFilter(
      minAgeFilter: json["minAgeFilter"].toString(),
      maxAgeFilter: json["maxAgeFilter"].toString(),
      minHeightFilter: json["minHeightFilter"].toString(),
      maxHeightFilter: json["maxHeightFilter"].toString(),
      educationFilter: json["education"] ?? "High School",
      cityDataFilter: CityData.fromJson(json["CityData"]) ?? CityData(cid: "6b090cf8", nid: "", name: "Karachi", status: 1),
    );
  }

}
