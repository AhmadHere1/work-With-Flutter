//Login Exceptions

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}
//register Screen exceptions

class WeakAuthPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class UserDisabledAuthException implements Exception {}

class OperationNotAllowedAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
