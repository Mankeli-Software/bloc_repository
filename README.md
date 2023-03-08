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
The existing BLoC libraries are amazing for handling state managment in Flutter projects. However, the boundaries for creating `Repositores` is are way too loose. In `package:flutter_bloc`, a `Repository` can literally be any class. This package solves that problem by creating a class, `Repository`, which all the repositories can inherit from.

Another problem is repository-to-repository communication. A repository should be fairly independent of other repositories and their implementations. However, sometimes a repository needs to call a method in another repository. To maintain their 

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


[1]: https://img.shields.io/badge/style-mankeli__analysis-blue
[2]: https://pub.dev/packages/mankeli_analysis
[3]: https://img.shields.io/pub/v/bloc_repository.svg
[4]: https://pub.dev/packages/bloc_repository
[5]: https://img.shields.io/badge/license-BSD%203--clause-blue.svg
[6]: https://opensource.org/licenses/BSD-3-Clause
[7]: https://github.com/Mankeli-Software/bloc_repository/actions/workflows/ci.yaml/badge.svg
[8]: https://pub.dev/packages/bloc_repository


