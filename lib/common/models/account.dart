class Account {
  String username;
  String email;
  String firstName;
  String lastName;
  String? phoneNumber;
  String? address;
  String? avatarUrl;
  String? backgroundUrl;

  Account({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.backgroundUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      avatarUrl: json['avatarUrl'],
      backgroundUrl: json['backgroundUrl'],
    );
  }

  // default constructor
  Account.empty()
      : username = 'User',
        email = '',
        firstName = 'User',
        lastName = '';

  Object? toJson() {
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'avatarUrl': avatarUrl,
    };
  }
}