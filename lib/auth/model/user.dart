class JasbeUser {
  final String userId;
  String name;
  String email;
  String phone;
  String? profile;

  JasbeUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profile,
  });

  factory JasbeUser.fromJson(Map<String, dynamic> json) {
    return JasbeUser(
      userId: json["userId"],
      name: json["name"] ?? "Unknown",
      email: json["email"] ?? "jasbe@hotmail.com",
      phone: json["phone"] ?? "+00000",
      profile: json["profile"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "profile": profile,
    };
  }

  JasbeUser copyWith({
    String? newName,
    String? newPhone,
    String? newProfile,
  }) {
    return JasbeUser(userId: userId, name: newName ?? name, email: email, phone: newPhone ?? phone, profile: newProfile ?? profile);
  }
}
