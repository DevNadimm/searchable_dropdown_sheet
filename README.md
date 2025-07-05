
# 🧺 searchable_dropdown_sheet

A fully customizable, searchable dropdown modal sheet for Flutter — powered by the [`modal_bottom_sheet`](https://pub.dev/packages/modal_bottom_sheet) package.

Perfect for dropdown selection with search functionality in a beautiful bottom sheet layout.

---

## ✨ Features

- 🔍 **Searchable**: Built-in search field with filtering
- 🎨 **Customizable**: Override item builder, search field, separator, styles, and more
- 📱 **Responsive UI**: Clean modal sheet experience across devices
- 🧩 **Plug & Play**: Just pass a list of items and a callback — you're done!

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  searchable_dropdown_sheet: ^0.0.2
```

Then run:

```bash
flutter pub get
```

---

## 📦 Import

```dart
import 'package:searchable_dropdown_sheet/searchable_dropdown_sheet.dart';
```

---

## 🛠️ Usage

```dart
showBarModalBottomSheet(
  context: context,
  builder: (_) => SearchableDropdownSheet(
    title: 'Choose Fruit',
    subtitle: 'Search or scroll to select',
    items: ['Apple', 'Banana', 'Mango'],
    selectedItem: _controller.text,
    onItemSelected: (value) {
      setState(() => _controller.text = value);
    },
  ),
);
```

---

## 🎯 Advanced Customization

```dart
SearchableDropdownSheet(
  title: 'Pick a Fruit',
  subtitle: 'Search and select',
  items: ['Apple', 'Banana', 'Orange'],
  selectedItem: selected,
  onItemSelected: (value) => setState(() => selected = value),

  // Custom search input
  customSearchField: Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: 'Type to search...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    ),
  ),

  // Custom item display
  itemBuilder: (context, item, isSelected) => ListTile(
    title: Text(item),
    trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
  ),

  // Custom empty result
  emptyBuilder: (context) => Center(
    child: Text('❌ No match found'),
  ),
)
```

---

## 📚 Parameters

| Parameter            | Type                         | Description                                           |
|----------------------|------------------------------|-------------------------------------------------------|
| `title`              | `String`                     | Top title inside the modal                           |
| `subtitle`           | `String`                     | Optional subtitle below the title                    |
| `items`              | `List<String>`               | List of items to display                             |
| `selectedItem`       | `String`                     | Currently selected item                              |
| `onItemSelected`     | `Function(String)`           | Callback when item is tapped                         |
| `customSearchField`  | `Widget?`                    | Provide your own search field widget                 |
| `itemBuilder`        | `Widget Function(...)`       | Custom builder for list items                        |
| `emptyBuilder`       | `Widget Function(BuildContext)` | Widget to show when no results found              |
| `separatorBuilder`   | `Widget Function(...)`       | Customize list separator                             |

---

## 📌 Dependencies

- [`modal_bottom_sheet`](https://pub.dev/packages/modal_bottom_sheet)

---

## 📄 License

This package is licensed under the [MIT License](LICENSE).

---

## 💙 Created by

**Nadim Chowdhury**  
→ [GitHub](https://github.com/DevNadimm)  
→ [LinkedIn](https://www.linkedin.com/in/devnadimm/)

---

> PRs and contributions are welcome!
