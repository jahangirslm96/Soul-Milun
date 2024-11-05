class AppExeception implements Exception{
  final _message;
  final _prefix;

  AppExeception([this._message, this._prefix]);

  String toString(){
    return '$_prefix$_message';
  }

}

class FetchDataException extends AppExeception{

  FetchDataException([String? message]) : super(message, 'Error during communication');
}

class BadRequestException extends AppExeception{

  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorizedException extends AppExeception{

  UnauthorizedException([String? message]) : super(message, 'Unauthorized Request');
}

class InvalidInputException extends AppExeception{

  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
