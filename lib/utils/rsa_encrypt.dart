import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
class Encrypt {
  ///  加密
  static encryption(content,String publicKeyString) async {
    final parser = RSAKeyParser();
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(content).base64;
  }

  /// 解密
  static Future<String> decrypt(String decoded) async {
    final parser = RSAKeyParser();
    String privateKeyString = await rootBundle.loadString('assets/rsa_key/rsa_private_key.pem');
    final privateKey = parser.parse(privateKeyString) as RSAPrivateKey;
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(decoded));
  }
}
