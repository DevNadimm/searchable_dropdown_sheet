# searchable_dropdown_sheet

A customizable, searchable dropdown modal sheet for Flutter. Built using the `modal_bottom_sheet` package.

## Features

- Searchable list
- Selectable items
- Beautiful modal UI
- Easy integration

## Usage

```dart
import 'package:searchable_dropdown_sheet/searchable_dropdown_sheet.dart';

// Inside your widget:
showBarModalBottomSheet(
  context: context,
  builder: (_) => SearchableDropdownSheet(
    title: 'Choose Fruit',
    subtitle: 'Search or scroll',
    items: ['Apple', 'Banana', 'Mango'],
    selectedItem: _controller.text,
    onItemSelected: (value) {
      setState(() => _controller.text = value);
    },
  ),
);
