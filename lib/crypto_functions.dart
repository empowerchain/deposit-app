import 'dart:convert';
import 'package:elliptic/elliptic.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:crypto/crypto.dart';


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
  var btoaPhase1 = utf8.encode(payloadStr); // Makes a list of bits from the string
  var payloadAsBase64 = base64.encode(btoaPhase1); // btoa(payloadStr)

  var msgBuffer = utf8.encode(payloadAsBase64);
  var hash = sha256.convert(msgBuffer).bytes;
  var sig = signature(privateKey, hash);

  Map token = {
    "payload": payloadAsBase64,
    "signature": sig.toCompactHex()
  };

  String jsonStringifyToken = json.encode(token);
  var usableBase64Stringify = utf8.encode(jsonStringifyToken);
  String b64Token = base64.encode(usableBase64Stringify);

  
  return b64Token;
}