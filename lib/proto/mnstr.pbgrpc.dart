// This is a generated file - do not edit.
//
// Generated from mnstr.proto.

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

import 'mnstr.pb.dart' as $0;

export 'mnstr.pb.dart';

@$pb.GrpcServiceName('mnstrv2.MnstrService')
class MnstrServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MnstrServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ListMnstrsResponse> list(
    $0.ListMnstrsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMnstrByQrCodeResponse> getByQrCode(
    $0.GetMnstrByQrCodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getByQrCode, request, options: options);
  }

  $grpc.ResponseFuture<$0.CollectMnstrResponse> collect(
    $0.CollectMnstrRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$collect, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateMnstrResponse> create(
    $0.CreateMnstrRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateMnstrBatchResponse> createBatch(
    $0.CreateMnstrBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createBatch, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMnstrResponse> update(
    $0.UpdateMnstrRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMnstrBatchResponse> updateBatch(
    $0.UpdateMnstrBatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateBatch, request, options: options);
  }

  // method descriptors

  static final _$list =
      $grpc.ClientMethod<$0.ListMnstrsRequest, $0.ListMnstrsResponse>(
          '/mnstrv2.MnstrService/List',
          ($0.ListMnstrsRequest value) => value.writeToBuffer(),
          $0.ListMnstrsResponse.fromBuffer);
  static final _$getByQrCode = $grpc.ClientMethod<$0.GetMnstrByQrCodeRequest,
          $0.GetMnstrByQrCodeResponse>(
      '/mnstrv2.MnstrService/GetByQrCode',
      ($0.GetMnstrByQrCodeRequest value) => value.writeToBuffer(),
      $0.GetMnstrByQrCodeResponse.fromBuffer);
  static final _$collect =
      $grpc.ClientMethod<$0.CollectMnstrRequest, $0.CollectMnstrResponse>(
          '/mnstrv2.MnstrService/Collect',
          ($0.CollectMnstrRequest value) => value.writeToBuffer(),
          $0.CollectMnstrResponse.fromBuffer);
  static final _$create =
      $grpc.ClientMethod<$0.CreateMnstrRequest, $0.CreateMnstrResponse>(
          '/mnstrv2.MnstrService/Create',
          ($0.CreateMnstrRequest value) => value.writeToBuffer(),
          $0.CreateMnstrResponse.fromBuffer);
  static final _$createBatch = $grpc.ClientMethod<$0.CreateMnstrBatchRequest,
          $0.CreateMnstrBatchResponse>(
      '/mnstrv2.MnstrService/CreateBatch',
      ($0.CreateMnstrBatchRequest value) => value.writeToBuffer(),
      $0.CreateMnstrBatchResponse.fromBuffer);
  static final _$update =
      $grpc.ClientMethod<$0.UpdateMnstrRequest, $0.UpdateMnstrResponse>(
          '/mnstrv2.MnstrService/Update',
          ($0.UpdateMnstrRequest value) => value.writeToBuffer(),
          $0.UpdateMnstrResponse.fromBuffer);
  static final _$updateBatch = $grpc.ClientMethod<$0.UpdateMnstrBatchRequest,
          $0.UpdateMnstrBatchResponse>(
      '/mnstrv2.MnstrService/UpdateBatch',
      ($0.UpdateMnstrBatchRequest value) => value.writeToBuffer(),
      $0.UpdateMnstrBatchResponse.fromBuffer);
}

@$pb.GrpcServiceName('mnstrv2.MnstrService')
abstract class MnstrServiceBase extends $grpc.Service {
  $core.String get $name => 'mnstrv2.MnstrService';

  MnstrServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ListMnstrsRequest, $0.ListMnstrsResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListMnstrsRequest.fromBuffer(value),
        ($0.ListMnstrsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMnstrByQrCodeRequest,
            $0.GetMnstrByQrCodeResponse>(
        'GetByQrCode',
        getByQrCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMnstrByQrCodeRequest.fromBuffer(value),
        ($0.GetMnstrByQrCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CollectMnstrRequest, $0.CollectMnstrResponse>(
            'Collect',
            collect_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CollectMnstrRequest.fromBuffer(value),
            ($0.CollectMnstrResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CreateMnstrRequest, $0.CreateMnstrResponse>(
            'Create',
            create_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateMnstrRequest.fromBuffer(value),
            ($0.CreateMnstrResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateMnstrBatchRequest,
            $0.CreateMnstrBatchResponse>(
        'CreateBatch',
        createBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateMnstrBatchRequest.fromBuffer(value),
        ($0.CreateMnstrBatchResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateMnstrRequest, $0.UpdateMnstrResponse>(
            'Update',
            update_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateMnstrRequest.fromBuffer(value),
            ($0.UpdateMnstrResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateMnstrBatchRequest,
            $0.UpdateMnstrBatchResponse>(
        'UpdateBatch',
        updateBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateMnstrBatchRequest.fromBuffer(value),
        ($0.UpdateMnstrBatchResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListMnstrsResponse> list_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListMnstrsRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.ListMnstrsResponse> list(
      $grpc.ServiceCall call, $0.ListMnstrsRequest request);

  $async.Future<$0.GetMnstrByQrCodeResponse> getByQrCode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMnstrByQrCodeRequest> $request) async {
    return getByQrCode($call, await $request);
  }

  $async.Future<$0.GetMnstrByQrCodeResponse> getByQrCode(
      $grpc.ServiceCall call, $0.GetMnstrByQrCodeRequest request);

  $async.Future<$0.CollectMnstrResponse> collect_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CollectMnstrRequest> $request) async {
    return collect($call, await $request);
  }

  $async.Future<$0.CollectMnstrResponse> collect(
      $grpc.ServiceCall call, $0.CollectMnstrRequest request);

  $async.Future<$0.CreateMnstrResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateMnstrRequest> $request) async {
    return create($call, await $request);
  }

  $async.Future<$0.CreateMnstrResponse> create(
      $grpc.ServiceCall call, $0.CreateMnstrRequest request);

  $async.Future<$0.CreateMnstrBatchResponse> createBatch_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateMnstrBatchRequest> $request) async {
    return createBatch($call, await $request);
  }

  $async.Future<$0.CreateMnstrBatchResponse> createBatch(
      $grpc.ServiceCall call, $0.CreateMnstrBatchRequest request);

  $async.Future<$0.UpdateMnstrResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateMnstrRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$0.UpdateMnstrResponse> update(
      $grpc.ServiceCall call, $0.UpdateMnstrRequest request);

  $async.Future<$0.UpdateMnstrBatchResponse> updateBatch_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateMnstrBatchRequest> $request) async {
    return updateBatch($call, await $request);
  }

  $async.Future<$0.UpdateMnstrBatchResponse> updateBatch(
      $grpc.ServiceCall call, $0.UpdateMnstrBatchRequest request);
}
