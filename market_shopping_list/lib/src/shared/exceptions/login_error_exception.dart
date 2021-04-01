import 'package:market_shopping_list/src/shared/exceptions/base_exception.dart';

class LoginErrorException implements Exception {
  String message;

  LoginErrorException({required this.message});
}
