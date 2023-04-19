import 'package:contact_scan/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String? url;
  T Function(Response response)? parse;

  Resource({this.url, this.parse});
}

class Webservice {
  var tag = "Webservice----";

  Future<T> loadPostWithoutParam<T>(Resource<T> resource) async {
    final response = await http.post(Uri.parse(resource.url!));
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadGetWithoutParam<T>(Resource<T> resource) async {
    final response = await http.get(Uri.parse(resource.url!));
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadGetWithHeader<T>(Resource<T> resource) async {
    String token = await Utility.getUserAPIKey();
    Map<String, String> headers = {"Authorization": token};
    final response = await http.get(Uri.parse(resource.url!), headers: headers);
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadGetParam<T>(Resource<T> resource) async {
    final response = await http.get(Uri.parse(resource.url!));
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadPost<T>(Resource<T> resource, Object body) async {
    final response = await http.post(Uri.parse(resource.url!), body: body);
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadPostHeaderData<T>(Resource<T> resource, Map body) async {
    final response = await http.post(Uri.parse(resource.url!),
        headers: {
          "content-type": "application/json/multipart/form-data",
          "accept": "application/json",
        },
        body: body);
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadPostJsonData<T>(Resource<T> resource, Object body) async {
    final response = await http.post(Uri.parse(resource.url!),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: body);
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      return resource.parse!(response);
    }
  }

  Future<T> loadPostWithHeaderKey<T>(Resource<T> resource, Object body) async {
    String token = await Utility.getUserAPIKey();
    Map<String, String> headers = {"Authorization": token};
    final response =
        await http.post(Uri.parse(resource.url!), headers: headers, body: body);
    if (kDebugMode) {
      print("response........................." + response.toString());
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
