# bloc_repository

[![style: mankeli analysis][1]][2]


[![pub package][3]][4]
[![License][5]][6]
!['[CI]'][7]



[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/mankeli)


An additional layer of abstraction for creating repositories following the BLoC pattern architecture


## Platform support

| Android | iOS | macOS | Web | Linux | Windows |
|---------|-----|-------|-----|-------|---------|
| ✔       | ✔   | ✔     | ✔   | ✔     | ✔       |

## Motivation
The existing BLoC libraries are amazing for handling state managment in Flutter projects. However, there are a few issues regarding `Repository`s, which this package aims to fix.

1. The boundaries for creating `Repositores` is are way too loose. In `package:flutter_bloc`, a `Repository` can literally be any class. This package solves that problem by creating a class, `Repository`, which all the repositories can inherit from.
2. Having all the repositories extend the same class makes it possible to create methods that all the classes have. For instance, `initialize` and `dispose` methods. When all the repositories have these methods, its easier to initialize and dispose multiple repositories in bulk.
3. Repository-to-repository communication is hard to implement. A repository should be independent of other repositories and their implementations. However, sometimes a repository needs to call a method in another repository, or some method defined elsewhere outside the repository. To decouple repositories from each other, this package contains a `RepositoryChannel` which can be used to communicate back and forth to repositories.
   

## Getting started
1. Create a `RepositoryChannel`
   ```dart
    class MyRepositoryChannel extends RepositoryChannel{
        // Add your custom repository events here

        MyRepositoryChannel({
             required super.log, 
             required this.myCustomCallback,
        });

        final void Function() myCustomCallback;
    }
   ```

2. Create `Repository` and use the channel
    ```dart
    class MyRepository extends Repository<MyRepositoryChannel>{
        MyRepository({
            required MyRepositoryChannel channel,
        }) super(channel);

    /// You can override the `initialize` and `dispose` methods, like so
    @override
    FutureOr<void> initialize(){
        // Do own initialization
        super.initialize();
    }

     Future<void> doSomething() async {
        channel.log('Starting to do something!');

        // Do something

        channel.myCustomCallback();

        channel.log('Finished doing something!');
     }
    }
    ```
3. Use the repository
    ```dart
    Widget build(BuildContext context){
        return RepositoryProvider<MyRepository>(
            create: (_) => MyRepository(
                channel: MyRepositoryChannel(
                    log: (value) => print(value),
                    myCustomCallback: () {},
                );
            );
        );
    }
    ```

## Mocking for test
Creating mocks for the `RepositoryChannel` function calls is easy with [package:mocktail][9]. 

1. For each function call you want to mock, create a mock class that extends `Mock`. The class should contain only a single method, `call`. The method should not contain method body, and it should have the same return type and parameters as the method being mocked.
    ```dart
    class MockLog extends Mock {
        void call(String v);
    }
    ```
2. Construct the class as you would normally, but instead of the actual function, pass `RepositoryChannel` the mocked function.
    ```dart
    final log = MockLog();

    channel = MyRepositoryChannel(
        log: log,
    );

    // Now you can do you basic mocktail stuff

    // Register calls
    when(() => log(any<String>())).thenAnswer((_) {});

    // Check for calls
    verify(() => log('test')).called(1);
    ```


[1]: https://img.shields.io/badge/style-mankeli__analysis-blue
[2]: https://pub.dev/packages/mankeli_analysis
[3]: https://img.shields.io/pub/v/bloc_repository.svg
[4]: https://pub.dev/packages/bloc_repository
[5]: https://img.shields.io/badge/license-BSD%203--clause-blue.svg
[6]: https://opensource.org/licenses/BSD-3-Clause
[7]: https://github.com/Mankeli-Software/bloc_repository/actions/workflows/ci.yaml/badge.svg
[8]: https://pub.dev/packages/bloc_repository
[9]: https://pub.dev/packages/mocktail


