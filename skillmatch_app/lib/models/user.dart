class User {
  final int id;
  final String name;
  final String email;
  final String location;
  final String mainSkill;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.mainSkill,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      location: json["location"],
      mainSkill: json["main_skill"],
    );
  }
}
