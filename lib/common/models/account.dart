class Account {
  String username;
  String email;
  String firstName;
  String lastName;
  String? phoneNumber;
  String? address;
  String? avatarUrl;

  Account({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
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
    );
  }

  // default constructor
  Account.empty()
      : username = 'User',
        email = '',
        firstName = 'User',
        lastName = '';
}