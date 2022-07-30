<div align = center>

![View Counter](https://komarev.com/ghpvc/?username=shop-app&label=View%20Counter&color=red&style=flat) &nbsp; &nbsp; ![Repo Size](https://img.shields.io/github/repo-size/rajput-hemant/shop-app?color=blue)

<img src='assets/images/shop_app.png' width='200'>

# 🛒 Shop App

### A simple Shop App to browse, add your own products, add products to cart and later order them.

<br>

## ![][android] Download APK & Source Code

---

[<kbd> <br> **Universal Release** <br> </kbd>][universal-release]&nbsp;&nbsp;
[<kbd> <br> **arm64** <br> </kbd>][arm64]&nbsp;&nbsp;
[<kbd> <br> **x64** <br> </kbd>][x64]&nbsp;&nbsp;
[<kbd> <br> **armabi** <br> </kbd>][armabi]&nbsp;&nbsp;
[<kbd> <br> **Source Code (zip)** <br> </kbd>][sc-zip]&nbsp;&nbsp;
[<kbd> <br> **Source Code (tar.gz)** <br> </kbd>][sc-tar.gz]

---

## 👨‍🎓 Things I learned through this project

</div>

### State Management

- Working with Providers, listeners and notifiers.
- Using a Provider class in another Provider class.
- Using Consumers for more optimizations i.e. rebuilding only the builder function or a part of widget.
- Using Provider to provide data application-wide or multiple widgets, OR
- Using Stateful Widget instead of Provider when the state only affect a widget or its child widget.

### Working with User Input & Forms

- Handling and validating the User Input.
- Showing dialogs to interact with Users

### Working with HTTP Requests & Error Handling

- Using Http requests like post, get, patch, etc to do CRUD operations.
- Using Future & Asynchronous Fn with async/await.
- Error Handling, using try-catch(-finally) or catcherror.

### Working with User Authentication

- Using Firebase Authentication to Log in/out, sign up, etc.
- Managing Auth token locally using Shared Preferences.
- Using the ProxyProvider & attaching the Token to outgoing HTTP requests.
- Using the FutureBuilder to show different widgets based on the future state.
- Automatically Logging In/Out functionality.

### Animation

- Using built-in animations like Hero Animation, various Transition Animations, etc.
- Using AnimatedBuilder/AnimatedContainer to animate a widget without rebuilding it.
- Implementing Custom Route Transitions.

<div align = center>

## Dependencies Used

---

[<kbd> <br> **http**: ^0.13.4 <br> </kbd>][http]&nbsp;&nbsp;
[<kbd> <br> **intl**: ^3.2.0 <br> </kbd>][intl]&nbsp;&nbsp;
[<kbd> <br> **provider**: ^10.1.0 <br> </kbd>][provider]&nbsp;&nbsp;
[<kbd> <br> **shared_preferences**: ^2.0.15 <br> </kbd>][shared_preferences]

---

## 📱 App UI

<details><summary> Click here to expand </summary>

| _Login/Signup Screen_ |        _Home Screen_         |  _Product Detail Screen_   |
| :-------------------: | :--------------------------: | :------------------------: |
|   ![][login screen]   |       ![][home screen]       | ![][product detail screen] |
|   **_App Drawer_**    |      **_Filter PopUp_**      |     **_Cart Screen_**      |
|    ![][app drawer]    |      ![][filter popup]       |      ![][cart screen]      |
|  **_Orders Screen_**  | **_Manage Products Screen_** | **_Edit Product Screen_**  |
|  ![][orders screen]   | ![][manage products screen]  |  ![][edit product screen]  |

</details>

## Directory Structure

</div>

```
shop_app
|
|-- assets
|   |-- fonts
|   |   |-- Anton-Regular.ttf
|   |   |-- Lato-Bold.ttf
|   |   `-- Lato-Regular.ttf
|   |
|   `-- images
|       |-- background.png
|       |-- clock.png
|       |-- light-1.png
|       |-- light-2.png
|       `-- shop_app.png
|
|-- lib
|   |-- helpers
|   |   `-- custom_route.dart
|   |
|   |-- models
|   |   `-- http_exception.dart
|   |
|   |-- providers
|   |   |-- auth.dart
|   |   |-- cart.dart
|   |   |-- orders.dart
|   |   |-- product.dart
|   |   `-- products.dart
|   |
|   |-- screens
|   |   |-- auth_screen.dart
|   |   |-- cart_screen.dart
|   |   |-- edit_product_screen.dart
|   |   |-- orders_screen.dart
|   |   |-- product_detail_screeen.dart
|   |   |-- products_overview_screen.dart
|   |   |-- splash_screen.dart
|   |   `-- user_products_screen.dart
|   |
|   |-- widgets
|   |   |-- app_drawer.dart
|   |   |-- badge.dart
|   |   |-- cart_item.dart
|   |   |-- order_item.dart
|   |   |-- product_item.dart
|   |   |-- products_grid.dart
|   |   `-- user_product_item.dart
|   |
|   `-- main.dart
|
|-- pubspec.yaml
|
`-- README.md
```

<div align = center>

## Building from Source

</div>

- If you don't have Flutter SDK installed, please visit official [Flutter](https://flutter.dev/) site.
- Fetch latest source code from master branch.

```console
rajput-hemant@arch:~$ git clone https://github.com/rajput-hemant/shop-app
```

- Run the app with Android Studio or VS Code. Or the command line:

```console
rajput-hemant@arch:~$ flutter pub get
rajput-hemant@arch:~$ flutter run
```

<div align = center>

## Contributors:

<a href="https://github.com/rajput-hemant/shop-app/graphs/contributors" target="blank"> <img src="https://contrib.rocks/image?repo=rajput-hemant/shop-app&max=500" /></a>

</div>

<!----------------------------------{ Images }--------------------------------->

[login screen]: https://telegra.ph/file/fa9d24f8b1765f2bdf5a7.jpg
[app drawer]: https://telegra.ph/file/f8655eba246d05ba675e9.jpg
[home screen]: https://telegra.ph/file/6c98682dfa8bc08dc9bef.jpg
[filter popup]: https://telegra.ph/file/5804d2fc365b43418244d.jpg
[product detail screen]: https://telegra.ph/file/456c8e0703c5a456f5322.jpg
[cart screen]: https://telegra.ph/file/c1f189a7b4047b873d3d6.jpg
[orders screen]: https://telegra.ph/file/b2a1cc4599863e558bd96.jpg
[manage products screen]: https://telegra.ph/file/f6cb506efd299f64c1f2c.jpg
[edit product screen]: https://telegra.ph/file/5454bf4c45cfbb66f5a37.jpg
[android]: https://telegra.ph/file/f2f70a74d2d92c3c7f688.png

<!------------------------------------{ apk }----------------------------------->

[universal-release]: https://github.com/rajput-hemant/shop-app/releases/download/v0.1.0/Shop-App-v0.1.0-universal-release.apk
[arm64]: https://github.com/rajput-hemant/shop-app/releases/download/v0.1.0/Shop-App-v0.1.0-arm64.apk
[armabi]: https://github.com/rajput-hemant/shop-app/releases/download/v0.1.0/Shop-App-v0.1.0-armeabi.apk
[x64]: https://github.com/rajput-hemant/shop-app/releases/download/v0.1.0/Shop-App-v0.1.0-x64.apk

<!--------------------------------{ source code }------------------------------->

[sc-zip]: https://github.com/rajput-hemant/shop-app/archive/refs/tags/v0.1.0.zip
[sc-tar.gz]: https://github.com/rajput-hemant/shop-app/archive/refs/tags/v0.1.0.tar.gz

<!-----------------------------{ dependencies used }---------------------------->

[intl]: https://pub.dev/packages/intl
[http]: https://pub.dev/packages/http
[provider]: https://pub.dev/packages/provider
[shared_preferences]: https://pub.dev/packages/shared_preferences
