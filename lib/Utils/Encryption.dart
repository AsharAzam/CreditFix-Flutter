import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption {
  static final _CLIENT_ID = "d8fd1732-582500-44fa-a03c-8d12aacc82de";
  static final _SECRET_KEY = "6fa979f20126cb08aa645a8f495f6d85";
  static final _SEC_IV = "I8zyA4lVhMCaJ5Kg";
  static final _PADDING = "PKCS7";

  static  String encryptData(String plainText) {
    try {
      final key = encrypt.Key.fromUtf8(_SECRET_KEY);
      final iv = encrypt.IV.fromUtf8(_SEC_IV);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: _PADDING));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64.toString();
    } catch (error) {
      throw error;
    }
  }

  static String decryptData(String encrypted) {
    try {
      final key = encrypt.Key.fromUtf8(_SECRET_KEY);
      final iv = encrypt.IV.fromUtf8(_SEC_IV);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: _PADDING));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (error) {
      throw error;
    }
  }

  static String get appToken{
    return encryptData(_CLIENT_ID);
  }
}