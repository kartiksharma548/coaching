import 'dart:convert';
import 'dart:io';

import 'package:coaching/constants.dart';
import 'package:coaching/services/storage_service.dart';
import 'package:http/http.dart' as http;

class RestUrls {
  static String apiUrl = Constants.url;
  static final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    "Accept": "application/json"
  };

  ///register
  static Future<http.Response> register(var obj) async {
    String urlName = apiUrl + "register";
    var url = Uri.parse(urlName);

    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<dynamic> getToken() async {
    final StorageService _storageService = StorageService();
    return await _storageService.readSecureData("token");
  }

  ///login
  static Future<http.Response> login(var obj) async {
    String urlName = apiUrl + "signin";
    var url = Uri.parse(urlName);

    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<http.Response> createOrder(var obj) async {
    String urlName = apiUrl + "order";
    var url = Uri.parse(urlName);

    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<http.Response> getOrders(var obj) async {
    String urlName = apiUrl + "getOrders";
    var url = Uri.parse(urlName);

    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<http.Response> addPlayer(var obj) async {
    String urlName = apiUrl + "coach/player";
    var url = Uri.parse(urlName);

    var jsonBody = json.encode(obj);
    String token = await getToken();
    var authtoken = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var authheaders = {...headers, ...authtoken};

    var request = await http.post(url, headers: authheaders, body: jsonBody);

    return request;
  }

  static Future<http.Response> getPlayers(int id) async {
    String urlName = apiUrl + "coach/player/" + id.toString();
    var url = Uri.parse(urlName);

    String token = await getToken();
    var authtoken = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var authheaders = {...headers, ...authtoken};

    var request = await http.get(url, headers: authheaders);

    return request;
  }
}
