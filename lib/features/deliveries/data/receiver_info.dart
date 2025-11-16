class ReceiverInfo {
  final String name;
  final String phone;
  final String address;
  final String location;

  ReceiverInfo({
    required this.name,
    required this.phone,
    required this.address,
    required this.location,
  });

  factory ReceiverInfo.fromJson(Map<String, dynamic> json) {
    return ReceiverInfo(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'location': location,
    };
  }
}
