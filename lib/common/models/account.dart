class Account {
  String username;
  String email;
  String firstName;
  String lastName;
  String? phoneNumber;
  String? address;
  String? avatarUrl;
  String? backgroundUrl;
  int invoiceCount;
  int commentCount;
  int movieRatedCount;

  Account({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.backgroundUrl,
    this.invoiceCount = 0,
    this.commentCount = 0,
    this.movieRatedCount = 0,
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
      invoiceCount: (json['invoiceCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      movieRatedCount: (json['movieRatedCount'] as num).toInt(),
    );
  }

  // default constructor
  Account.empty()
      : username = 'User',
        email = '',
        firstName = 'User',
        lastName = '',
        invoiceCount = 0,
        commentCount = 0,
        movieRatedCount = 0;

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