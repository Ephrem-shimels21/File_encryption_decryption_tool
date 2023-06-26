class User{
  int? id;
  String? username;
  String  email;
  String password;


  User({
    required this.email,
    this.username,
    this.id,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      
    );
  }

}