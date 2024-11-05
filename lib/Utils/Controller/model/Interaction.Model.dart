class Interaction {
    List<Interact>? interact;

    Interaction({
        this.interact,
    });

    factory Interaction.fromJson(Map<String, dynamic> json) 
    {
        return Interaction(
        interact: json["interact"] == null ? [] : List<Interact>.from(json["interact"]!.map((x) => Interact.fromJson(x))),
    );
    }

    Map<String, dynamic> toJson() => {
        "interact": interact == null ? [] : List<dynamic>.from(interact!.map((x) => x.toJson())),
    };
}

class Interact {
    String? name;
    String? details;
    String? image;
    List<InteractWith>? interactWith;

    Interact({
        this.name,
        this.details,
        this.image,
        this.interactWith,
    });

    factory Interact.fromJson(Map<String, dynamic> json) => Interact(
        name: json["Name"],
        details: json["details"],
        image: json["image"],
        interactWith: json["InteractWith"] == null ? [] : List<InteractWith>.from(json["InteractWith"]!.map((x) => InteractWith.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "details": details,
        "image": image,
        "InteractWith": interactWith == null ? [] : List<dynamic>.from(interactWith!.map((x) => x.toJson())),
    };
}

class InteractWith {
    String? uId;
    String? category;
    String? name;
    String? profilePicture;
    int? age;
    String? profession;
    String? city;

    InteractWith({
        this.uId,
        this.category,
        this.name,
        this.profilePicture,
        this.age,
        this.profession,
        this.city,
    });

    factory InteractWith.fromJson(Map<String, dynamic> json) => InteractWith(
        uId: json["uID"],
        category: json["category"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        age: json["age"],
        profession: json["profession"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "uID": uId,
        "category": category,
        "name": name,
        "profilePicture": profilePicture,
        "age": age,
        "profession": profession,
        "city": city,
    };
}
