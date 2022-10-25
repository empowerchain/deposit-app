import 'dart:convert';
import 'package:alan/alan.dart';
import 'package:depositapp/classes/user_simple_preferences.dart';
import 'package:elliptic/elliptic.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:crypto/crypto.dart';
// import 'package:rsa_encrypt/rsa_encrypt.dart';
// import 'package:pointycastle/api.dart' as crypto;

String createToken(String privKey) {
  var ec = getS256();
  var privateKey =
      PrivateKey.fromHex(ec, privKey); // Private key adapted to library
  String pubKeyHex =
      privateKey.publicKey.toCompressedHex(); // Public key in Hex

  // Until here everything identical
  var payloadJson = {
    "pubKey": pubKeyHex,
    "client": "empower-deposit-app",
    "timestamp": 1656943301
  };

  // Becomes a string
  String payloadStr =
      json.encode(payloadJson); // payloadStr = JSON.stringify(payloadJson)

  // payload as bits
  var btoaPhase1 =
      utf8.encode(payloadStr); // Makes a list of bits from the string
  var payloadAsBase64 = base64.encode(btoaPhase1); // btoa(payloadStr)

  var msgBuffer = utf8.encode(payloadAsBase64);
  var hash = sha256.convert(msgBuffer).bytes;
  var sig = signature(privateKey, hash);

  Map token = {"payload": payloadAsBase64, "signature": sig.toCompactHex()};

  String jsonStringifyToken = json.encode(token);
  var usableBase64Stringify = utf8.encode(jsonStringifyToken);
  String b64Token = base64.encode(usableBase64Stringify);

  return b64Token;
}

// String RSAEncrypt(String message, String publicKey, String privateKey) {
//   //Future to hold our KeyPair
//   Future<crypto.AsymmetricKeyPair> futureKeyPair;

//   //to store the KeyPair once we get data from our future
//   crypto.AsymmetricKeyPair keyPair;

//   Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
//     getKeyPair() {
//     var helper = RsaKeyHelper();
//     return helper.computeRSAKeyPair(helper.getSecureRandom());
//   }

//   return "";
// }

String empowerAddress(List<String> mnemonic) {
  final networkInfo = NetworkInfo.fromSingleHost(
    bech32Hrp: 'empower',
    host: 'localhost',
  );

  try{
    final wallet = Wallet.derive(mnemonic, networkInfo);
    UserSimplePreferences.setAddress(wallet.bech32Address);
    

    return wallet.bech32Address;
  }
  catch(Exception){
    return "";
  }
}
