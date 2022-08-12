import 'dart:convert';
import 'package:secp256k1/secp256k1.dart';
import 'package:crypto/crypto.dart';

String createToken(String privKey) {
  var privateKey =
      PrivateKey.fromHex(privKey); // Private key adapted to library
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
      latin1.encode(payloadStr); // Makes a list of bits from the string

  var payloadAsBase64 = base64.encode(btoaPhase1); // btoa(payloadStr)

  // Signable array requires the function sha256

  var msgBuffer = utf8.encode(payloadAsBase64);

  var signableArray = sha256
      .convert(msgBuffer)
      .bytes; // signableArray = await sha256(payloadAsBase64)

  var acceptedSignableArray =
      signableArray.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  var signature = privateKey.signature(acceptedSignableArray);

  Map token = {
    "payload": payloadAsBase64,
    "signature": signature.toRawHex()
  };

  String jsonStringifyToken = json.encode(token);
  var usableBase64Stringify = utf8.encode(jsonStringifyToken);
  String b64Token = base64.encode(usableBase64Stringify);

  
  return b64Token;
}