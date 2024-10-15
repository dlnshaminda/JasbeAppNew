class Venue {
  final String name;
  final String detail;
  final String peroid;
  final String location;
  final String address;
  final String phone;

  const Venue({
    required this.name,
    required this.detail,
    required this.peroid,
    required this.location,
    required this.address,
    required this.phone,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json["name"] ?? "Unknown",
      detail: json["detail"] ?? "Detail",
      peroid: json["peroid"] ?? "...",
      location: json["location"] ?? "Unknown",
      phone: json["phone"] ?? "Unknown",
      address: json["address"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "detail": detail,
      "peroid": peroid,
      "location": location,
      "address": address,
      "phone": phone,
    };
  }
}
