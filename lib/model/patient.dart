class Patient {
  String? id;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? department;
  String? status;
  String? phone;
  String? email;
  double? height;
  double? weight;
  String? address;
  String? doctor;
  DateTime birthDate;

  Patient({
    this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.department,
    this.status,
    this.phone,
    this.email,
    this.height,
    this.weight,
    this.doctor,
    this.address,
    required this.birthDate,
  });

  factory Patient.empty() => Patient(
        birthDate: DateTime.now(),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'department': department,
      'status': status,
      'phone': phone,
      'email': email,
      'height': height,
      'weight': weight,
      'address': address,
      'doctor': doctor,
      'birthDate': birthDate.toIso8601String(),
    };
  }
}
