import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for Dropdown button
class FormBuilderDropdown<T> extends FormBuilderField<T> {
  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  ///
  /// If [decoration.hint] and variations is non-null and [disabledHint] is null,
  /// the [decoration.hint] widget will be displayed instead.
  final List<DropdownMenuItem<T>> items;

  /// A placeholder widget that is displayed by the dropdown button.
  ///
  /// If [value] is null, this widget is displayed as a placeholder for
  /// the dropdown button's value. This widget is also displayed if the button
  /// is disabled ([items] or [onChanged] is null) and [disabledHint] is null.
  final Widget? hint;

  /// A message to show when the dropdown is disabled.
  ///
  /// Displayed if [items] or [onChanged] is null. If [decoration.hint] and
  /// variations is non-null and [disabledHint] is null, the [decoration.hint]
  /// widget will be displayed instead.
  final Widget? disabledHint;

  /// Called when the dropdown button is tapped.
  ///
  /// This is distinct from [onChanged], which is called when the user
  /// selects an item from the dropdown.
  ///
  /// The callback will not be invoked if the dropdown button is disabled.
  final VoidCallback? onTap;

  /// A builder to customize the dropdown buttons corresponding to the
  /// [DropdownMenuItem]s in [items].
  ///
  /// When a [DropdownMenuItem] is selected, the widget that will be displayed
  /// from the list corresponds to the [DropdownMenuItem] of the same index
  /// in [items].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// This sample shows a `DropdownButton` with a button with [Text] that
  /// corresponds to but is unique from [DropdownMenuItem].
  ///
  /// If this callback is null, the [DropdownMenuItem] from [items]
  /// that matches [value] will be displayed.
  final DropdownButtonBuilder? selectedItemBuilder;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int elevation;

  /// The text style to use for text in the dropdown button and the dropdown
  /// menu that appears when you tap the button.
  ///
  /// To use a separate text style for selected item when it's displayed within
  /// the dropdown button, consider using [selectedItemBuilder].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// This sample shows a `DropdownButton` with a dropdown button text style
  /// that is different than its menu items.
  ///
  /// ```dart
  /// List<String> options = <String>['One', 'Two', 'Free', 'Four'];
  /// String dropdownValue = 'One';
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Container(
  ///     alignment: Alignment.center,
  ///     color: Colors.blue,
  ///     child: DropdownButton<String>(
  ///       value: dropdownValue,
  ///       onChanged: (String newValue) {
  ///         setState(() {
  ///           dropdownValue = newValue;
  ///         });
  ///       },
  ///       style: TextStyle(color: Colors.blue),
  ///       selectedItemBuilder: (BuildContext context) {
  ///         return options.map((String value) {
  ///           return Text(
  ///             dropdownValue,
  ///             style: TextStyle(color: Colors.white),
  ///           );
  ///         }).toList();
  ///       },
  ///       items: options.map<DropdownMenuItem<String>>((String value) {
  ///         return DropdownMenuItem<String>(
  ///           value: value,
  ///           child: Text(value),
  ///         );
  ///       }).toList(),
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// Defaults to the [TextTheme.titleMedium] value of the current
  /// [ThemeData.textTheme] of the current [Theme].
  final TextStyle? style;

  /// The widget to use for the drop-down button's icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget? icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [Colors.grey.shade400] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [Colors.grey.shade700] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Reduce the button's height.
  ///
  /// By default this button's height is the same as its menu items' heights.
  /// If isDense is true, the button's height is reduced by about half. This
  /// can be useful when the button is embedded in a container that adds
  /// its own decorations, like [InputDecorator].
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  ///
  /// By default this button's inner width is the minimum size of its contents.
  /// If [isExpanded] is true, the inner width is expanded to fill its
  /// surrounding container.
  final bool isExpanded;

  /// If null, then the menu item heights will vary according to each menu item's
  /// intrinsic height.
  ///
  /// The default value is [kMinInteractiveDimension], which is also the minimum
  /// height for menu items.
  ///
  /// If this value is null and there isn't enough vertical room for the menu,
  /// then the menu's initial scroll offset may not align the selected item with
  /// the dropdown button. That's because, in this case, the initial scroll
  /// offset is computed as if all of the menu item heights were
  /// [kMinInteractiveDimension].
  final double? itemHeight;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used
  /// instead.
  final Color? dropdownColor;

  final bool allowClear;
  final Widget clearIcon;

  /// The maximum height of the menu.
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? menuMaxHeight;

  final bool shouldRequestFocus;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// By default, platform-specific feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// Defines how the hint or the selected item is positioned within the button.
  ///
  /// This property must not be null. It defaults to [AlignmentDirectional.centerStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// Defines the corner radii of the menu's rounded rectangle shape.
  ///
  /// The radius of the first menu item's top left and right corners are
  /// defined by the corresponding properties of the [borderRadius].
  /// Similarly, the radii of the last menu item's bottom and right corners
  /// are defined by the corresponding properties of the [borderRadius].
  final BorderRadius? borderRadius;

  /// Creates field for Dropdown button
  FormBuilderDropdown({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    required this.items,
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    @Deprecated('Please use decoration.hint and variations to set your desired label')
        this.hint,
    this.style,
    this.disabledHint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    @Deprecated('Please use decoration.suffix to set your desired behavior')
        this.allowClear = false,
    @Deprecated('Please use decoration.suffixIcon to set your desired icon')
        this.clearIcon = const Icon(Icons.close),
    this.onTap,
    this.autofocus = false,
    this.shouldRequestFocus = false,
    this.dropdownColor,
    this.focusColor,
    this.itemHeight,
    this.selectedItemBuilder,
    this.menuMaxHeight,
    this.enableFeedback,
    this.borderRadius,
    this.alignment = AlignmentDirectional.centerStart,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state = field as _FormBuilderDropdownState<T>;

            void changeValue(T? value) {
              if (shouldRequestFocus) {
                state.requestFocus();
              }
              state.didChange(value);
            }

            return DropdownButton<T>(
              isExpanded: isExpanded,
              hint: hint,
              items: items,
              value: field.value,
              style: style,
              isDense: false,
              disabledHint: field.value != null
                  ? (items
                          .firstWhereOrNull((dropDownItem) =>
                              dropDownItem.value == field.value)
                          ?.child ??
                      Text(field.value.toString()))
                  : disabledHint,
              elevation: elevation,
              iconSize: iconSize,
              icon: icon,
              iconDisabledColor: iconDisabledColor,
              iconEnabledColor: iconEnabledColor,
              onChanged:
                  state.enabled ? (value) => changeValue(value) : null,
              onTap: onTap,
              focusNode: state.effectiveFocusNode,
              autofocus: autofocus,
              dropdownColor: dropdownColor,
              focusColor: focusColor,
              itemHeight: itemHeight,
              selectedItemBuilder: selectedItemBuilder,
              menuMaxHeight: menuMaxHeight,
              borderRadius: borderRadius,
              enableFeedback: enableFeedback,
              alignment: alignment,
            );
          },
        );

  @override
  FormBuilderFieldState<FormBuilderDropdown<T>, T> createState() =>
      _FormBuilderDropdownState<T>();
}

class _FormBuilderDropdownState<T>
    extends FormBuilderFieldState<FormBuilderDropdown<T>, T> {}
