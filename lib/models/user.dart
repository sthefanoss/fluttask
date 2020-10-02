import 'credentials.dart';
import 'address.dart';

class User {
  final String name;
  final String cpf;
  final Address address;
  final Credentials credentials;
  final DateTime dateOfBirth;

  const User({
    this.name,
    this.cpf,
    this.address,
    this.credentials,
    this.dateOfBirth,
  });
}
