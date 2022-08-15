@Timeout(Duration(seconds: 120))
import 'package:depositapp/crypto_functions.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'package:elliptic/elliptic.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Token gets created correctly', () async {
    for (var i = 0; i < 50; i++) {
      var privateKeyHex = "2ea029a07b085d75ebfdef7318ec848ef0f6d8bef4506f363f433672f1e57f41";
      var token = createToken(privateKeyHex);
      var tokenJsonB = base64.decode(token);
      var tokenJsonS = utf8.decode(tokenJsonB);
      var tokenJson = json.decode(tokenJsonS);

      var payloadBase64 = tokenJson["payload"];
      var payloadJsonB = base64.decode(payloadBase64);
      var payloadJsonS = utf8.decode(payloadJsonB);
      var payloadJson = json.decode(payloadJsonS);
      var publicKeyHex = payloadJson["pubKey"];
      expect(publicKeyHex, "037826a25a8b897e5b8eebc2a59ed17839c24099371bba2983198dd5544351aad2");

      var ec = getS256();
      var privateKey = PrivateKey.fromHex(ec, privateKeyHex);
      var publicKey = privateKey.publicKey;
      expect(publicKeyHex, publicKey.toCompressedHex());

      var signatureHex = tokenJson["signature"];
      var sig = Signature.fromCompactHex(signatureHex);
      var msgBuffer = utf8.encode(payloadBase64);
      var hash = sha256.convert(msgBuffer).bytes;
      expect(verify(publicKey, hash, sig), true);

      String currentToken = "Bearer $token";

      final response = await http.get(
          Uri.parse('https://staging-deposit-pqu2.encr.app/tmp.AuthTest'),
          headers: {"Authorization": currentToken});

      expect(response.statusCode, 200);
      var responseBodyJson = json.decode(response.body);
      expect(responseBodyJson["pubKey"], publicKeyHex);
    }
  });
}