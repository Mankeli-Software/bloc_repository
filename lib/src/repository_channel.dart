import 'dart:async';

/// {@template repository_channel}
/// [RepositoryChannel] makes it possible to add repository-to-repository
/// communication, while keeping the repositories decoupled from each other.
/// The basic implementation of [RepositoryChannel] has methods for basic
/// communication, but it can be extended to add more methods.
/// {@endtemplate}
class RepositoryChannel {
  /// {@macro repository_channel}
  RepositoryChannel({
    this.log,
    this.logError,
    this.initialized,
    this.disposed,
  });

  /// {@macro repository_channel}
  ///
  /// [log] can be used to send messages, for instance
  /// ```dart
  /// /// Sends a string through the channel
  /// super.channel.log('Hello world!');
  ///
  /// /// Sends a custom event through the channel
  /// super.channel.log(MyCustomEvent());
  /// ```
  final FutureOr<void> Function(Object value)? log;

  /// {@macro repository_channel}
  ///
  /// [logError] can be used to send error messages
  final FutureOr<void> Function(
    Object value, {
    String? message,
    StackTrace? stackTrace,
  })? logError;

  /// {@macro repository_channel}
  ///
  /// [initialized] is called when the repositorys initialize method is called.
  final void Function()? initialized;

  /// {@macro repository_channel}
  ///
  /// [disposed] is called when the repositorys dispose method is called.
  final void Function()? disposed;
}
