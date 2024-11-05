import 'package:meta/meta.dart';
import 'dart:convert';

class SubscriptionPackages {
    List<Package> packages;

    SubscriptionPackages({
        required this.packages,
    });

    factory SubscriptionPackages.fromRawJson(String str) => SubscriptionPackages.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubscriptionPackages.fromJson(Map<String, dynamic> json) => SubscriptionPackages(
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    };
}

class Package {
    String pid;
    String name;
    List<String> given;
    List<String> missing;
    int price;
    int daysLimit;
    String coverPicture;
    int status;

    Package({
        required this.pid,
        required this.name,
        required this.given,
        required this.missing,
        required this.price,
        required this.daysLimit,
        required this.coverPicture,
        required this.status,
    });

    factory Package.fromRawJson(String str) => Package.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        pid: json["PID"],
        name: json["Name"],
        given:  List<String>.from(jsonDecode(json["Given"])),// List<String>.from(json["Given"].map((x) => x)),
        missing: List<String>.from(jsonDecode(json["Missing"])), //List<String>.from(json["Missing"].map((x) => x)),
        price: json["Price"],
        daysLimit: json["DaysLimit"],
        coverPicture: json["CoverPicture"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "PID": pid,
        "Name": name,
        "Given": List<dynamic>.from(given.map((x) => x)),
        "Missing": List<dynamic>.from(missing.map((x) => x)),
        "Price": price,
        "DaysLimit": daysLimit,
        "CoverPicture": coverPicture,
        "Status": status,
    };
}
