import 'dart:typed_data';

import 'package:depositapp/crypto/encryption.dart';
import 'package:encrypt/encrypt.dart' as c;
import "package:pointycastle/export.dart";
import 'package:pointycastle/src/platform_check/platform_check.dart';
import 'package:test/test.dart';

const testPrivateKeyPem = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCJNC3G5mcI/tEciFVmDo5+cx6ISPsG8eacKtgzYeSTPbRg+/oCuef11iRe3v4D0KITde6t5pPN24/deFoc6nKWIFA6A/ZLG4Zbvv6yjTzSqp7eYmqO62kAoSSiP28v1TWpeTlCZcfHKzNVk6XoY5XIRUkNsIK2Tv4S+pPj83DdP6T4386zOPzhTame65i+FllH/lHyb+knT0Q0fs/rj52RHU6l0oKFM6wF1J6R5DCQWKFYw8OTEzGxf0YthRuHzgeSp23cWgczceYGDqYGz0vhHXTEv8eBB1DjYbSDTS/YvMX/2JlXL4ydeeydwXtT7i88kg0TM1F70l7IYJUH/zt3AgMBAAECggEAB9+vtNdqGFEPTRTh2b6CHO2cVfPiPA7LzjCDQcefZ3fGDz7GpTtn/WqxoaQoba2eb4F4FhDCcLDl+665dSlbNBRcpket7beBqWg3k6WZVPmnrll1hggqeXfF822ygss4jiY/y/itU1e+VW3ouoJkiR64x4lWpwG3gP1SWWWSF5BGvCaMFtqAiHCjJSzTCVmH5BGbMxs+VbA86+rssVgChnnoXQp+gSNNL2VNxpdRbhZIFszzHfy3t1PDJr6fYGmhlw2YGjotxNTSsxfo792pQBvInri1vttRVnP3zZiKUZ/CCApuGsuCxTx3H4xTIs1npUkeEA9mxHymRULjbObNiQKBgQDX+UIZFbjek+xl3teue+rzU9J/cDu5LmEHTn19AxgvBeiol/kIWaZps18HFULOHy7tNuRR1yKAzL8Tja6hnNWoLrr9Qjzbr2aCXS7OzepYGsml19WVwjk7U7DAWpFPAXhqLsEB/HP5R2hSaL3uHctjU5LojZFYrlCpVYMzUHcP2wKBgQCiobuBpyAvhvP6LsG+aVZmdR/TAS/NE16knznYkspYqUMFjjvMAv8/0wEvfNQGY0v/VzwWzQlIizXI8yrNkd62D6TkDkkBYbLMSMpUWDuGivh7Gb+e4uBQHVFeyB+aLRgjeJLZxcKdsxmtiYXJCKFe40uO5g1TRXr8lbRKYl1TlQKBgBRbIPi+TGNmK9TaMRf4BAgVMXTjfi2RCoImyrsarI/aDbi+QjGgSYgS6PUA8v/8fm7LSq/QCCd9pNDR/NCsuJKWfPdb4+KM4KuO3teNHvZY6AKimjX4TW6jD7jBkIqSx+eyKmzmf4PSUCncR3KHCmF9Qg57MWTbYSzkq24NunsbAoGAOt6GjFEd4nZcXISOV0m0H9Rn166HShmn2blVbCL+ogdrHli1Jo0zLjxIIpNyAHnzKZO/SZWgtaTGrF3xcYZK8uZIztCo9poR6cazjsJ9kZ8+gPj6Fx6TCg0Cxmd0oQ+PvE9KARCH+SO6uMmeJv47w6hNUoXN7wWolkPuhjqDA90CgYEA1phXwgn+0HduJuw+5e7vlVnemBKtGywIDaOPY3vnA9tX2qw2MLrLkLrkdmEA7SOI6Q7O2NM+Af0wh5mJlERJI4oNgjMZM8FYoPcXT1WmEZ1nBxhHAZ/mnXrbe7qbg/hu9jSDnJpeutp7wVbsWn53aw7miaiLYai9o7Qd1IJ8wSc=
-----END PRIVATE KEY-----""";
const testPublicKeyPem = """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiTQtxuZnCP7RHIhVZg6OfnMeiEj7BvHmnCrYM2Hkkz20YPv6Arnn9dYkXt7+A9CiE3XureaTzduP3XhaHOpyliBQOgP2SxuGW77+so080qqe3mJqjutpAKEkoj9vL9U1qXk5QmXHxyszVZOl6GOVyEVJDbCCtk7+EvqT4/Nw3T+k+N/Oszj84U2pnuuYvhZZR/5R8m/pJ09ENH7P64+dkR1OpdKChTOsBdSekeQwkFihWMPDkxMxsX9GLYUbh84Hkqdt3FoHM3HmBg6mBs9L4R10xL/HgQdQ42G0g00v2LzF/9iZVy+MnXnsncF7U+4vPJINEzNRe9JeyGCVB/87dwIDAQAB
-----END PUBLIC KEY-----""";

void main() {

  test('Encryption works', () async {
    final keyGen = RSAKeyGenerator();
    final secureRandom = SecureRandom('Fortuna')
      ..seed(KeyParameter(
          Platform.instance.platformEntropySource().getBytes(32)));
    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64), secureRandom)
    );
    final pair = keyGen.generateKeyPair();

    final myPublic = pair.publicKey as RSAPublicKey;
    final myPrivate = pair.privateKey as RSAPrivateKey;
    const data = "This is some data to encrypt";

    final encryptedData = await encryptData(data, encodePublicKeyToPem(myPublic));
    final decryptedData = decryptData(encryptedData, myPrivate);
    expect(decryptedData, data);
  });

  test('Keys from platform', () async {
    const data = "This is some data to encrypt";

    final parser = c.RSAKeyParser();
    final privateKey = parser.parse(testPrivateKeyPem) as RSAPrivateKey;

    final encryptedData = await encryptData(data, testPublicKeyPem);
    final decryptedData = decryptData(encryptedData, privateKey);
    expect(decryptedData, data);
  });
}

String decryptData(String encryptedData, RSAPrivateKey privateKey) {
  final encryptor = c.Encrypter(c.RSA(privateKey: privateKey));
  final encrypted = c.Encrypted.fromBase64(encryptedData);
  
  return encryptor.decrypt(encrypted);
}