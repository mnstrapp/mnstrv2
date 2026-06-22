// This is a generated file - do not edit.
//
// Generated from users.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'users.pb.dart' as $0;

export 'users.pb.dart';

@$pb.GrpcServiceName('mnstrv2.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.MyUserResponse> myUser(
    $0.MyUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$myUser, request, options: options);
  }

  // method descriptors

  static final _$myUser =
      $grpc.ClientMethod<$0.MyUserRequest, $0.MyUserResponse>(
          '/mnstrv2.UserService/MyUser',
          ($0.MyUserRequest value) => value.writeToBuffer(),
          $0.MyUserResponse.fromBuffer);
}

@$pb.GrpcServiceName('mnstrv2.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'mnstrv2.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MyUserRequest, $0.MyUserResponse>(
        'MyUser',
        myUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MyUserRequest.fromBuffer(value),
        ($0.MyUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.MyUserResponse> myUser_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.MyUserRequest> $request) async {
    return myUser($call, await $request);
  }

  $async.Future<$0.MyUserResponse> myUser(
      $grpc.ServiceCall call, $0.MyUserRequest request);
}
