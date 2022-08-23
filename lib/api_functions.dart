import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getVouchersForUser(
    String? userPubKey, String? token) async {
  String currentToken = "Bearer $token";
  final body = jsonEncode({"UserPubKey": userPubKey});

  final response = await http.post(
    Uri.parse(
        'https://staging-deposit-pqu2.encr.app/deposit.GetVouchersForUser'),
    headers: {"Authorization": currentToken},
    body: body,
  );
  Map<String, dynamic> vouchers = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> content = vouchers["vouchers"];
    List<dynamic> available = [];
    for (var item in content) {
      var usable = item["voucher"]["invalidated"];
      if (!usable) {
        available.add(item);
      }
    }

    return available;
  } else {
    return [];
  }
}

Future<List<dynamic>> getUsedVouchersForUser(
    String? userPubKey, String? token) async {
  String currentToken = "Bearer $token";
  final body = jsonEncode({"UserPubKey": userPubKey});

  final response = await http.post(
    Uri.parse(
        'https://staging-deposit-pqu2.encr.app/deposit.GetVouchersForUser'),
    headers: {"Authorization": currentToken},
    body: body,
  );
  Map<String, dynamic> vouchers = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> content = vouchers["vouchers"];
    List<dynamic> used = [];
    for (var item in content) {
      var usable = item["voucher"]["invalidated"];
      if (usable) {
        used.add(item);
      }
    }

    return used;
  } else {
    return [];
  }
}

Future<List<dynamic>> getHistory(String? userPubKey, String? token) async {
  String currentToken = "Bearer $token";
  final body = jsonEncode({"UserPubKey": userPubKey});

  final response = await http.post(
    Uri.parse('https://staging-deposit-pqu2.encr.app/deposit.GetHistory'),
    headers: {"Authorization": currentToken},
    body: body,
  );
  Map<String, dynamic> responseBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> history = responseBody["events"];
    return history;
  } else {
    return [];
  }
}

Future<bool> invalidateVoucher(String? voucherID, String? token) async {
  String currentToken = "Bearer $token";
  final body = jsonEncode({"voucherID": voucherID});

  final response = await http.post(
    Uri.parse(
        'https://staging-deposit-pqu2.encr.app/deposit.InvalidateVoucher'),
    headers: {"Authorization": currentToken},
    body: body,
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Map<String, dynamic>> depositClaim(
  String token,
  String publicKey,
  String code,
) async {
  String currentToken = "Bearer $token";

  final Map<String, String> header = {
    "Authorization": currentToken,
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Methods': 'GET, POST',
    "Access-Control-Allow-Headers": "X-Requested-With",
    "content-type": "application/json"
  };

  final body = jsonEncode({"DepositID": code, "UserPubKey": publicKey});

  final response = await http.post(
    Uri.parse('https://staging-deposit-pqu2.encr.app/deposit.Claim'),
    headers: header,
    body: body,
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> content = jsonDecode(response.body);
    return content;
  } else {
    return {};
  }
}

Future<Map<String, String>> getPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') as String;
  final String pubKey = prefs.getString('public-key') as String;
  return {
    "token": token,
    "pubKey": pubKey,
  };
}
