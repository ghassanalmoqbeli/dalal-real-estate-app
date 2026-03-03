import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  //Get Request Method
  final baseURL = "https://dalal.ghassanalmoqbeli.com/api-app/api/";

  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (url == 'null') {
      url = '';
    }
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null && token != 'null') {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.get(
      Uri.parse(
        '$baseURL'
        '$url',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'There is a problem with StatusCode (${response.statusCode})',
      );
    }
  }

  //Post Request Method
  Future<dynamic> post({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (url == 'null') {
      url = '';
    }
    if (token != null && token != 'null') {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.post(
      Uri.parse(
        '$baseURL'
        '$url',
      ),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'There is a problem with StatusCode (${response.statusCode}) with body ${jsonDecode(response.body)} ',
      );
    }
  }

  Future<dynamic> put({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (url == 'null') {
      url = '';
    }
    if (token != null && token != 'null') {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.put(
      Uri.parse(
        '$baseURL'
        '$url',
      ),
      body: body,
      headers: headers,
    );
    debugPrint(
      'YOUR URL IS: '
      '$baseURL'
      '$url'
      ' ::::  YOUR BODY IS: $body  ::::  YOUR TOKEN IS: $token',
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint('YOUR RESPONSE IS: $data');
      return data;
    } else {
      debugPrint(
        "Error ${response.statusCode}: ${response.body}",
      ); // ✅ Print full response
      throw Exception(
        "StatusCode ${response.statusCode} - Response might not be JSON.",
      );
    }
  }

  Future<dynamic> patch({
    required String url,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (url == 'null') {
      url = '';
    }
    if (token != null && token != 'null') {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.patch(
      Uri.parse('$baseURL$url'),
      body: body,
      headers: headers,
    );

    debugPrint('PATCH URL: $baseURL$url ::: BODY: $body ::: TOKEN: $token');

    if (response.statusCode == 200 || response.statusCode == 204) {
      // Some APIs return 204 (No Content) for successful PATCH
      var resp = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      return resp;
      // response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      debugPrint("PATCH Error ${response.statusCode}: ${response.body}");
      throw Exception("PATCH failed with StatusCode ${response.statusCode}");
    }
  }

  Future<dynamic> delete({required String url, @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    // if (url == 'null') {
    //   url = '';
    // }
    if (token != null && token != 'null') {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.delete(
      Uri.parse('$baseURL$url'),
      headers: headers,
    );

    debugPrint('DELETE URL: $baseURL$url ::: TOKEN: $token');

    if (response.statusCode == 200 || response.statusCode == 204) {
      // 204 = No Content, so return empty map
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      debugPrint("DELETE Error ${response.statusCode}: ${response.body}");
      throw Exception("DELETE failed with StatusCode ${response.statusCode}");
    }
  }
}
