// To parse this JSON data, do
//
//     final preferredFilter = preferredFilterFromJson(jsonString);

import 'dart:convert';

PreferredFilter preferredFilterFromJson(String str) => PreferredFilter.fromJson(json.decode(str));

String preferredFilterToJson(PreferredFilter data) => json.encode(data.toJson());

class PreferredFilter {
    List<String> marriagePlans = [];
    List<String> relocationPlans = [];
    List<String> familyPlans = [];
    List<String> religiousPractices = [];
    List<String> praying = [];
    List<String> islamicDress = [];

    PreferredFilter({
       required this.marriagePlans,
       required this.relocationPlans,
       required this.familyPlans,
       required this.religiousPractices,
       required this.praying,
       required this.islamicDress,
    });

    factory PreferredFilter.fromJson(Map<String, dynamic> json) => PreferredFilter(
        marriagePlans: List<String>.from(json["marriagePlans"].map((x) => x)),
        relocationPlans: List<String>.from(json["relocationPlans"].map((x) => x)),
        familyPlans: List<String>.from(json["familyPlans"].map((x) => x)),
        religiousPractices: List<String>.from(json["religiousPractices"].map((x) => x)),
        praying: List<String>.from(json["praying"].map((x) => x)),
        islamicDress: List<String>.from(json["islamicDress"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "marriagePlans": List<dynamic>.from(marriagePlans.map((x) => x)),
        "relocationPlans": List<dynamic>.from(relocationPlans.map((x) => x)),
        "familyPlans": List<dynamic>.from(familyPlans.map((x) => x)),
        "religiousPractices": List<dynamic>.from(religiousPractices.map((x) => x)),
        "praying": List<dynamic>.from(praying.map((x) => x)),
        "islamicDress": List<dynamic>.from(islamicDress.map((x) => x)),
    };
}
