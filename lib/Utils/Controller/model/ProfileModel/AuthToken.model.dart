class AuthToken {
    Access? access;
    Access? refresh;

    AuthToken({
        this.access,
        this.refresh,
    });

    factory AuthToken.fromJson(Map<String, dynamic> json) {
      return  AuthToken(
        access: json["access"] == null ? null : Access.fromJson(json["access"]),
        refresh: json["refresh"] == null ? null : Access.fromJson(json["refresh"]),
      );
    }

    Map<String, dynamic> toJson() => {
        "access": access?.toJson(),
        "refresh": refresh?.toJson(),
    };
}

class Access {
    String? token;
    DateTime? expires;

    Access({
        this.token,
        this.expires,
    });

    factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: json["expires"] == null ? null : DateTime.parse(json["expires"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires?.toIso8601String(),
    };
}