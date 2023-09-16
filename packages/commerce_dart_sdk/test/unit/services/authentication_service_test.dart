// ignore_for_file: avoid_print

import 'dart:io';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/services/client_service.dart';
import 'package:commerce_dart_sdk/src/services/session_service.dart';

import 'package:test/test.dart';

class MockLocalStorageService implements ILocalStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

class MockSecureStorageService implements ISecureStorageService {
  Map<String, String?> store = {};

  @override
  String? load(String key) => store[key];

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    store[key] = value;
  }
}

void main() {
  ILocalStorageService localStorageService = MockLocalStorageService();
  ISecureStorageService secureStorageService = MockSecureStorageService();

  // used Implementation rather than Interface of clientService
  // to get the cookies
  ClientService clientService = ClientService(
    localStorageService: localStorageService,
    secureStorageService: secureStorageService,
  );

  ISessionService sessionService = SessionService(clientService: clientService);

  IAuthenticationService authService = AuthenticationService(
    clientService: clientService,
    sessionService: sessionService,
  );

  clientService.host = 'https://mobilespire.commerce.insitesandbox.com';
  ClientConfig.hostUrl = 'https://mobilespire.commerce.insitesandbox.com';
  ClientConfig.clientId = 'fluttermobile';
  ClientConfig.clientSecret = 'd66d0479-07f7-47b2-ee1e-0d3a536e6091';

  var userName = 'saif';
  var password = 'tester1';

  group(
    'LoginTest',
    () => {
      test('Login and session', () async {
        authService.logInAsync(userName, password);
        var sessionResponse = await sessionService.getCurrentSession();
        var session = sessionResponse.model;

        if (session == null) {
          print('NULL SESSION!');
          return;
        }

        print(session);
        print(session.toJson());
      }),
      test('Recieved cookies', () async {
        var cookiesList = await clientService.cookies;
        if (cookiesList.isEmpty) return;
        for (Cookie cookie in cookiesList) {
          print('${cookie.name} ${cookie.value}');
        }
      }),
      test('Stored cookies', () async {
        var cookiesStr = localStorageService.load('cookies');
        if (cookiesStr == null) return;

        print(cookiesStr);
      })
    },
  );
}
