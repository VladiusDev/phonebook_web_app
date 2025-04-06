class Employee {
  final String name;
  final String phoneNumber;
  final String organization;

  Employee(
      {required this.name,
      required this.phoneNumber,
      required this.organization});

  String get phone => phoneNumber.isEmpty ? 'Без номер телефона' : phoneNumber;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['employee'] as String,
      organization: json['organization'] as String,
      phoneNumber: json['tel'] as String,
    );
  }
}
