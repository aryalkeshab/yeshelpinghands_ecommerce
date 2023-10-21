import 'package:encrypt/encrypt.dart';

class DecryptUtils {
  static String decrypt(String value) {
    final iv = IV.fromBase64('1245714587458888');
    final key = Key.fromUtf8('1245714587458888');
    final encrypter = Encrypter(AES(key,mode: AESMode.cfb64));
    final decrypted = encrypter.decrypt64(value, iv: iv);
    return decrypted;
  }

}

