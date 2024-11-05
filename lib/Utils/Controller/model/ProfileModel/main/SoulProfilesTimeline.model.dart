import 'package:soul_milan/Utils/Controller/model/ProfileModel/ProfileOverview.model.dart';

class SoulProfilesTimeline {
    List<ProfileOverview>? preferred;
    List<ProfileOverview>? similar;
    List<ProfileOverview>? nearBy;
    List<ProfileOverview>? explore;

    SoulProfilesTimeline({
        this.preferred,
        this.similar,
        this.nearBy,
        this.explore
    });

    factory SoulProfilesTimeline.fromJson(Map<String, dynamic> json) {
      return SoulProfilesTimeline(
          preferred: (json['Preferred'] as List<dynamic>?)
            ?.map((x) => ProfileOverview.fromJson(x))
            .toList(),
          similar: (json['Similar'] as List<dynamic>?)
            ?.map((x) => ProfileOverview.fromJson(x))
            .toList(),
          nearBy: (json['NearBy'] as List<dynamic>?)
            ?.map((x) => ProfileOverview.fromJson(x))
            .toList(),
          explore: [],
      );
    }

      Map<String, List<ProfileOverview>> toMap() {
    return {
      'Preferred': preferred ?? [],
      'Similar': similar ?? [],
      'NearBy': nearBy ?? [],
    };
  }

}
