# docker-android-react-native-builder

> Version: 1.0.0

Sources for Docker image that can be used to build React Native app for Android devices from source code.

## Usage

### Prerequisites

1. App should be able to build with installing only production dependencies.
    > This means you should ie: make
    `metro-react-native-babel-preset` and `@babel/core` a `dependencies`, but you can (and should, to save resources) make
    `eslint` or `react-test-renderer` a `devDependencies`
    
1. App should have defined `package.json` script named `build:release:android` that starts the build process.
    > Usually `cd android && ./gradlew assembleRelease && cd ..` should be fine.

### Notes

1. `yarn`, not `npm` is used to install JS dependencies.
1. If you need to login into npm for your installs use [auth tokens][1].
    > Keep in mind yarn won't use tokens from environmental values.
    > Use `.npmrc` file to specify auth token like that:
    ```
    //registry.npmjs.org/:_authToken=00000000-1111-2222-3333-444444444444
    save-exact=true
    ```
1. Currently there is no feature written for handling app version and internal build number (see [here][2]).
Prepare it before using this image to ensure app can be updated correctly.
1. Currently there is no feature written for handling release keys/signing APK files (see [here][3]).
Make sure everything is right before using this image to ensure app can be installed.

### Volumes

Two volumes are required for this image to work. Third volume is optional.

- `/tmp/app` is where your app should be mounted, you can mount it as read-only
- `/result` is where your app apk file will be stored, keep it writable
- **(optional)** `/home/node/` is where caches are written
> Caches includes yarn and gradle cache, both will improve build time significantly if you keep cache folder alive
between builds.

### Example command

`docker run -v /path/to/your/app:/tmp/app -v /path/to/save/result:/result -v /path/to/caches:/home/node/ dzek69/android-react-native-builder`

[1]: https://docs.npmjs.com/about-authentication-tokens
[2]: https://developer.android.com/studio/publish/versioning
[3]: https://facebook.github.io/react-native/docs/signed-apk-android

## FAQ

> Why Debian is used instead of Alpine for this image?

Builds don't work on Alpine. Not sure why yet. Not a `glibcc` issue.

> Why not at least slim image?

Builds don't work on slim. Installing OpenJDK fails.

> Why these exact versions of SDK are choosen?

Because I need these, but feel free to fork.

## License

MIT
