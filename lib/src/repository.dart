// ignore_for_file: avoid-unused-parameters

import 'dart:async';

import 'package:bloc_repository/src/repository_channel.dart';
import 'package:meta/meta.dart';

/// {@template repository}
/// [Repository] is a class for making it easier to create new repositories
/// following the good practices of BLoC pattern. This class exposes
/// `initialize` and `close` methods, as well as a [RepositoryChannel]
/// for communicating between different layers of the application.
///
/// {@macro repository_channel}
/// {@endtemplate}
abstract class Repository<T extends RepositoryChannel> {
  /// {@macro repository}
  Repository([
    this._channel,
  ]);

  final T? _channel;

  /// Returns the current communication channel
  T get channel => _channel == null
      ? throw Exception(
          'Trying to access channel, when no channel is created. You must pass a RepositoryChannel to the repositorys super constructor.',
        )
      : _channel!;

  /// Whether `initialize` is called or not
  bool initialized = false;

  /// Whether `dispose` is called or not
  bool disposed = false;

  /// Called to initialize the repository
  @mustCallSuper
  Future<void> initialize() async {
    initialized = true;
    _channel?.initialized?.call();
  }

  /// Called to dispose the repository and free up the resources
  @mustCallSuper
  Future<void> dispose() async {
    disposed = true;
    _channel?.disposed?.call();
  }
}
