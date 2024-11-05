class Cities {
  List<CityData> cityList;

  Cities({
    required this.cityList,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      cityList: List<CityData>.from(json['cityList'].map((x) => CityData.fromJson(x))),
    );
  }


  Map<String, dynamic> toJson() => {
        "cityList": List<dynamic>.from(cityList.map((x) => x.toJson())),
      };
}

class CityData {
  String cid;
  String nid;
  String name;
  int status;

  CityData({
    required this.cid,
    required this.nid,
    required this.name,
    required this.status,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        cid: json["CID"],
        nid: json["NID"],
        name: json["Name"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "CID": cid,
        "NID": nid,
        "Name": name,
        "Status": status,
      };
}
