# ButtonPicker

Customizable Flutter number picker using buttons instead of scroll.

## Getting Started

1. Head to `/pubspec.yaml` and add `button_picker: ^0.1.0` below dependencies like this:
```
dependencies:
  flutter:
    sdk: flutter
  button_picker: ^0.1.0
```
2. Run `flutter packages get` or use the GUI equivalent
3. Now in your code `import 'package:button_picker/button_picker.dart';`
4. You're ready to go!

## Example & Usage
ButtonPicker is designed to be customizable.

```dart
import 'package:flutter/material.dart';
import 'package:button_picker/button_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ButtonPicker(
            minValue: 0,
            maxValue: 99,
            initialValue: 0,
            onChanged: (val) => print(val),
            step: 2.5,
            horizontal: false,
            loop: true,
            padding: 5.0,
            iconUp: Icons.keyboard_arrow_up,
            iconDown: Icons.keyboard_arrow_down,
            iconLeft: Icons.keyboard_arrow_left,
            iconRight: Icons.keyboard_arrow_right,
            iconUpRightColor: Colors.blue,
            iconDownLeftColor: Colors.blue,
            style: TextStyle(
              fontSize: 48.0,
              color: Colors.blue
            ),
          ),
        ),
      ),
    );
  }
}
```
- `minValue` [required] is the minimum value of the ButtonPicker.
- `maxValue` [required] is the maximum value of the ButtonPicker.
- `initialValue` [required] is the value displayed on load.
- `onChanged` [required] returns the current value.
- `step` defines how much the value should increase or decrease on tap.
- `horizontal` renders a horizontal ButtonPicker when set to `true`.
- `loop` lets the ButtonPicker count from the beginning when passing `maxValue` or from the end when passing `minValue` when set to `true`.
- `padding` defines the space between the buttons and the value.
- `iconUp`, `iconDown`, `iconLeft` and `iconRight` are the actual icons.
- `iconUpRightColor` is the color of the upper button when `horizontal == false` and the color of the right button when `horizontal == true`.
- `iconDownLeftColor` is the color of the lower button when `horizontal == false` and the color of the left button when `horizontal == true`.
- `style` is the `TextStyle` of the value.

# License
[MIT](LICENSE)
