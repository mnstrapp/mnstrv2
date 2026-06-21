// This is a generated file - do not edit.
//
// Generated from wallets.proto.

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

import 'wallets.pb.dart' as $0;

export 'wallets.pb.dart';

@$pb.GrpcServiceName('mnstrv2.WalletService')
class WalletServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  WalletServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetWalletResponse> getWallet(
    $0.GetWalletRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListWalletsResponse> listWallets(
    $0.ListWalletsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listWallets, request, options: options);
  }

  $grpc.ResponseStream<$0.StreamWalletsResponse> streamWallets(
    $0.StreamWalletsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamWallets, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$getWallet =
      $grpc.ClientMethod<$0.GetWalletRequest, $0.GetWalletResponse>(
          '/mnstrv2.WalletService/GetWallet',
          ($0.GetWalletRequest value) => value.writeToBuffer(),
          $0.GetWalletResponse.fromBuffer);
  static final _$listWallets =
      $grpc.ClientMethod<$0.ListWalletsRequest, $0.ListWalletsResponse>(
          '/mnstrv2.WalletService/ListWallets',
          ($0.ListWalletsRequest value) => value.writeToBuffer(),
          $0.ListWalletsResponse.fromBuffer);
  static final _$streamWallets =
      $grpc.ClientMethod<$0.StreamWalletsRequest, $0.StreamWalletsResponse>(
          '/mnstrv2.WalletService/StreamWallets',
          ($0.StreamWalletsRequest value) => value.writeToBuffer(),
          $0.StreamWalletsResponse.fromBuffer);
}

@$pb.GrpcServiceName('mnstrv2.WalletService')
abstract class WalletServiceBase extends $grpc.Service {
  $core.String get $name => 'mnstrv2.WalletService';

  WalletServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetWalletRequest, $0.GetWalletResponse>(
        'GetWallet',
        getWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetWalletRequest.fromBuffer(value),
        ($0.GetWalletResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListWalletsRequest, $0.ListWalletsResponse>(
            'ListWallets',
            listWallets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListWalletsRequest.fromBuffer(value),
            ($0.ListWalletsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.StreamWalletsRequest, $0.StreamWalletsResponse>(
            'StreamWallets',
            streamWallets_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.StreamWalletsRequest.fromBuffer(value),
            ($0.StreamWalletsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetWalletResponse> getWallet_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetWalletRequest> $request) async {
    return getWallet($call, await $request);
  }

  $async.Future<$0.GetWalletResponse> getWallet(
      $grpc.ServiceCall call, $0.GetWalletRequest request);

  $async.Future<$0.ListWalletsResponse> listWallets_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListWalletsRequest> $request) async {
    return listWallets($call, await $request);
  }

  $async.Future<$0.ListWalletsResponse> listWallets(
      $grpc.ServiceCall call, $0.ListWalletsRequest request);

  $async.Stream<$0.StreamWalletsResponse> streamWallets_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.StreamWalletsRequest> $request) async* {
    yield* streamWallets($call, await $request);
  }

  $async.Stream<$0.StreamWalletsResponse> streamWallets(
      $grpc.ServiceCall call, $0.StreamWalletsRequest request);
}
