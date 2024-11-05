class Profiles {
  String id;
  String name;
  String profileImage;
  String location;
  String address;
  String tagline;
  String bio;
  String profession;
  String distance;

  String religion;
  String dob;
  List<String> education;
  String email;
  String phoneNumber;

  int gender;
  int age;

  String height;
  String match;

  int subscribe;
  int followers;

  bool isFavourite = false;

  List<dynamic> images = [];
  var similar;
  var interest;

  Profiles({
    required this.id,
    required this.name,
    required this.age,
    required this.profileImage,
    required this.location,
    required this.similar,
    required this.images,
    required this.subscribe,
    required this.followers,
    required this.gender,
    required this.distance,
    required this.address,
    required this.tagline,
    required this.bio,
    required this.height,
    required this.profession,
    required this.match,
    required this.interest,
    required this.isFavourite,
    required this.religion,
    required this.dob,
    required this.education,
    required this.email,
    required this.phoneNumber,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) {
    var distance = json["distance"] ?? 0;

    distance = distance < 1
        ? "less than 1"
        : distance > 100
            ? "more than 100"
            : distance.toStringAsFixed(0);

    return Profiles(
      id: json['uID'] ?? json['id'],
      name: json['name'] ?? "",
      age: json['age'] ?? 0,
      profileImage:
          json['profilePicture'] ?? json['profileImage'] ?? json["image"] ?? "",
      location: json['location'] ?? "",
      subscribe: json['subscribe'] ?? 0,
      followers: json['followers'] ?? 0,
      gender: json["gender"] ?? 0,
      images: json["images"] ?? json["pictures"] ?? [],
      similar: json["similar"] ?? json["similarInterest"] ?? {},
      address: json["address"] ?? json["city"] ?? "",
      tagline: json["tagline"] ?? json["tagLine"] ?? "",
      bio: json["bio"] ?? "",
      height: json["height"] ?? "0",
      profession: json["profession"] ?? '',
      distance: distance,
      match: (json["match"] ?? 0).toString(),
      interest: json["interest"] ?? {},
      isFavourite: json["isFavourite"] ?? false,
      religion: json["religion"] ?? '',
      dob: json["dob"] ?? '',
      education:
          (json['education'] == null ? [] : json['education'] as List<dynamic>)
              .cast<String>(),
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
    );
  }

  update(data, pic) {
    bio = data["bio"];
    age = int.parse(data["age"]);
    location = data["city"];
    gender = int.parse(data["gender"]);
    profileImage = pic;
  }

   updatePicture(pic) {
    profileImage = pic;
  }

  about() {
    var temp = gender == 0 ? "Male" : "Female";
    var he = height.toString().replaceFirst(".", "'");
    return [
      "Match: $match%",
      "Distance: $distance km",
      "Age: $age",
      "Profession: $profession",
      "Height: $he''",
      "City: $address",
      "Gender: $temp",
    ];
  }
}
