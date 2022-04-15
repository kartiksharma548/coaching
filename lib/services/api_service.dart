import 'dart:convert';
import 'dart:io';

import 'package:coaching/constants.dart';
import 'package:http/http.dart' as http;

class RestUrls {
  static String apiUrl = Constants.url;

  ///register
  static Future<http.Response> register(var obj) async {
    String urlName = apiUrl + "register";
    var url = Uri.parse(urlName);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Accept": "application/json"
    };
    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  ///login
  static Future<http.Response> login(var obj) async {
    String urlName = apiUrl + "login";
    var url = Uri.parse(urlName);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<http.Response> createOrder(var obj) async {
    String urlName = apiUrl + "order";
    var url = Uri.parse(urlName);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }

  static Future<http.Response> getOrders(var obj) async {
    String urlName = apiUrl + "getOrders";
    var url = Uri.parse(urlName);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var jsonBody = json.encode(obj);
    var request = await http.post(url, headers: headers, body: jsonBody);

    return request;
  }
}