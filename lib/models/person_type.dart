class PersonType {
  final int id;
  final String name;

  PersonType({required this.id, required this.name});

  factory PersonType.fromJson(Map<String, dynamic> json) {
    return PersonType(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'PersonType{id: $id, name: $name}';
  }
}