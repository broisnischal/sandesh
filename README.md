# Sandesh - Flutter Toast

## Installation

```bash
flutter pub add sandesh
```

## Usage

```dart
import 'package:sandesh/sandesh.dart';


 ElevatedButton(
    onPressed: () {
        ToastManager.showToast(
        context,
        message: "Please Enter Correct Password",
        type: ToastType.ERROR,
        title: "Invalid Password",
        // removeonTap: true
        );
    },
child: const Text("Error Toast")
);
```

![](/images/README_2024-08-13-05-46-10.png)

## Configuration

Sandesh Toast is a simple to use plugin that provides a way to display toast messages in your Flutter app.

### Toast Types

Sandesh Toast supports four types of toast messages: default, success, error, and warning.

### Customization

You can customize the look and feel of the toast messages by passing in custom title and message styles.

### Toast Gravity

Sandesh Toast supports 8 different gravity options for the toast messages.

### Handling Tap Events

You can handle tap events on the toast messages by passing in a callback function.

### Vibration on Tap

Sandesh Toast supports vibration on tap for the toast messages.

### Future Work

There are several future improvements that can be made to Sandesh Toast including the addition of a countdown timer and the ability to customize the toast background color.

## Contributing

If you would like to contribute to the development of Sandesh Toast, please fork the repository and submit a pull request.

## License

Sandesh Toast is released under the MIT license. See the LICENSE file for details.
