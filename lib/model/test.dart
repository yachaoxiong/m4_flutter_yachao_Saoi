class Test {
  String? id;
  String? category;
  String? reading;
  String? patientId;
  bool? isCritical;
  DateTime? createdAt;
  DateTime? updatedAt;

  Test({
    this.id,
    this.category,
    this.reading,
    this.patientId,
    this.isCritical,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'reading': reading,
      'patient': patientId,
      'isCritical': isCritical,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Add this static method to create a Test instance from JSON object
  static Test fromJson(Map<String, dynamic> json) {
    return Test(
      category: json['category'],
      reading: json['reading'],
      patientId: json['patient'],
      isCritical: json['isCritical'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
