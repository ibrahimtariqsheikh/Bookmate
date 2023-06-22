import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
final int age;
  final String email;
  final String? profilePicture;

  const User({
    required this.id,
    required this.name,
required this.age,
    required this.email,
    this.profilePicture,
  });

  factory User.initial() {
    return const User(
      id: '',
      name: '',
age:0,
      email: '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
'age':age,
      'email': email,
      'profilePicture': profilePicture,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
age:json['age'] as int,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String?,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
age,
      email,
      profilePicture ?? '',
    ];
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
age:age,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  bool get stringify => true;
}
