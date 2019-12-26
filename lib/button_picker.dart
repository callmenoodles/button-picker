library button_picker;

import 'package:flutter/material.dart';

class ButtonPicker extends StatefulWidget {
  // FIXME: Horizontal ButtonPicker has variable width
  // TODO: Support for characters
  // TODO: Press and hold to count faster

  /// Integer or double picker that counts in numeric order
  ButtonPicker({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.initialValue,
    @required this.onChanged,
    this.step = 1,
    this.loop = false,
    this.horizontal = false,
    this.style,
    this.padding = 0.0,
    this.iconUp = Icons.arrow_drop_up,
    this.iconDown = Icons.arrow_drop_down,
    this.iconLeft = Icons.arrow_left,
    this.iconRight = Icons.arrow_right,
    this.iconUpRightColor = Colors.black,
    this.iconDownLeftColor = Colors.black,
    this.disabledOpacity = 0.2,
    this.isUpRightDisabled = false,
    this.isDownLeftDisabled = false,
  }) : assert(minValue != null),
       assert(maxValue != null),
       assert(initialValue != null),
       assert(onChanged != null),
       assert(step != null),
       assert(loop != null),
       assert(padding != null),
       assert(iconUp != null),
       assert(iconDown != null),
       assert(iconLeft != null),
       assert(iconRight != null),
       assert(iconUpRightColor != null),
       assert(iconDownLeftColor != null),
       assert(initialValue >= minValue && initialValue <= maxValue),
       assert(minValue < maxValue);

  final double minValue;
  final double maxValue;
  final double initialValue;
  final ValueChanged<double> onChanged;
  final double step;
  final bool horizontal;
  final bool loop;
  final TextStyle style;

  /// Space between buttons and counter
  final double padding;

  /// Customizable icons for the buttons
  final IconData iconUp;
  final IconData iconDown;
  final IconData iconLeft;
  final IconData iconRight;

  /// Color of upper button or right button when `horizontal == true`
  final Color iconUpRightColor;

  /// Color of bottom button or left button when `horizontal == true`
  final Color iconDownLeftColor;

  bool isUpRightDisabled;
  bool isDownLeftDisabled;
  final double disabledOpacity;

  @override
  State<StatefulWidget> createState() => _ButtonPicker();
}

enum CountDirection { Up, Down }

class _ButtonPicker extends State<ButtonPicker> {
  double _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  /// Calculate next value for the ButtonPicker
  void count(CountDirection countDirection) {
    if (countDirection == CountDirection.Up) {
      /// Make sure you can't go over `maxValue` unless `loop == true`
      if (_counter + widget.step > widget.maxValue) {
        if (widget.loop) {
          setState(() {
            /// Calculate the correct value if you go over maxValue in a loop
            double diff = (_counter + widget.step) - widget.maxValue;
            _counter = diff >= 1 ? widget.minValue + diff - 1 : widget.minValue;
          });
        }
      } else {
        setState(() => _counter += widget.step);
      }
    } else {
      /// Make sure you can't go under `minValue` unless `loop == true`
      if (_counter - widget.step < widget.minValue) {
        if (widget.loop) {
          setState(() {
            /// Calculate the correct value if you go under minValue in a loop
            double diff = widget.minValue - (_counter - widget.step);
            _counter = diff >= 1 ? widget.maxValue - diff + 1 : widget.maxValue;
          });
        }
      } else {
        setState(() => _counter -= widget.step);
      }
    }

    widget.onChanged(_counter);
  }

  /// Remove decimal values if the user entered an integer
  Widget getCount() {
    return Text(
        widget.initialValue % 1 == 0 && widget.step % 1 == 0
            ? _counter.toStringAsFixed(0)
            : _counter.toStringAsFixed(1),
        style: widget.style == null
            ? Theme.of(context).textTheme.headline
            : widget.style);
  }

  /// Return different widgets for a horizontal and vertical BuildPicker
  Widget buildButtonPicker() {
    if (!widget.horizontal) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Opacity(
            opacity: widget.isUpRightDisabled ? widget.disabledOpacity : 1,
            child: IconButton(
              icon: Icon(widget.iconUp),
              padding: EdgeInsets.only(bottom: widget.padding),
              alignment: Alignment.bottomCenter,
              color: widget.iconUpRightColor,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                count(CountDirection.Up);

              },
            ),
          ),
          getCount(),
          Opacity( // TODO: Ternary
            opacity: widget.isDownLeftDisabled ? widget.disabledOpacity : 1,
            child: IconButton(
                icon: Icon(widget.iconDown),
                padding: EdgeInsets.only(top: widget.padding),
                alignment: Alignment.topCenter,
                color: widget.iconDownLeftColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  count(CountDirection.Down);
                }),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              icon: Icon(widget.iconLeft),
              padding: EdgeInsets.only(right: widget.padding),
              alignment: Alignment.center,
              color: widget.iconUpRightColor,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                count(CountDirection.Down);
              }),
          getCount(),
          IconButton(
            icon: Icon(widget.iconRight),
            padding: EdgeInsets.only(left: widget.padding),
            alignment: Alignment.center,
            color: widget.iconDownLeftColor,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              count(CountDirection.Up);
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loop == false) {
      if (_counter + widget.step > widget.maxValue) {
        setState(() => widget.isUpRightDisabled = true);
      } else if (_counter - widget.step < widget.minValue) {
        setState(() => widget.isDownLeftDisabled = true);
      }

      if (_counter + widget.step <= widget.maxValue) {
        setState(() => widget.isUpRightDisabled = false);
      } else if (_counter - widget.step >= widget.minValue) {
        setState(() => widget.isDownLeftDisabled = false);
      }
    }

    return buildButtonPicker();
  }
}
