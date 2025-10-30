class CourierModel {
  final String id;
  final String name;
  final String status;
  final double rating;
  final String estimatedTime;
  final List<String> assignedDeliveries; 

  CourierModel({
    required this.id,
    required this.name,
    required this.status,
    this.rating = 0.0,
    this.estimatedTime = '',
    this.assignedDeliveries = const [],
  });

  factory CourierModel.fromMap(Map<String, dynamic> map, String docId) {
    return CourierModel(
      id: docId,
      name: map['name'] ?? '',
      status: map['status'] ?? 'Available',
      rating: (map['rating'] ?? 0).toDouble(),
      estimatedTime: map['estimatedTime'] ?? '',
      assignedDeliveries: List<String>.from(map['assignedDeliveries'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'rating': rating,
      'estimatedTime': estimatedTime,
      'assignedDeliveries': assignedDeliveries,
    };
  }
}
