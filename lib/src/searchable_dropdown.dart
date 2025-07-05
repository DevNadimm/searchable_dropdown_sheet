import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(
    BuildContext context, String item, bool isSelected);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef SeparatorBuilder = Widget Function(BuildContext context, int index);

class SearchableDropdownSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onItemSelected;

  // 🔧 Customization Hooks
  final Widget? customSearchField;
  final ItemBuilder? itemBuilder;
  final EmptyBuilder? emptyBuilder;
  final SeparatorBuilder? separatorBuilder;

  // Optional styles
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry padding;

  const SearchableDropdownSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    this.customSearchField,
    this.itemBuilder,
    this.emptyBuilder,
    this.separatorBuilder,
    this.titleStyle,
    this.subtitleStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    List<String> filteredList = List.from(items);

    return StatefulBuilder(
      builder: (context, modalSetState) => Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              title,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: subtitleStyle ??
                  const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // 🔍 Custom or default search field
            customSearchField ??
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    border: _defaultInputBorder,
                    focusedBorder: _defaultFocusBorder,
                    enabledBorder: _defaultInputBorder,
                  ),
                  onChanged: (value) {
                    modalSetState(() {
                      filteredList = items
                          .where((item) =>
                              item.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),

            Expanded(
              child: filteredList.isNotEmpty
                  ? ListView.separated(
                      itemCount: filteredList.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final isSelected = item == selectedItem;

                        // 👇 Use custom builder if provided
                        if (itemBuilder != null) {
                          return InkWell(
                            onTap: () {
                              onItemSelected(item);
                              Navigator.pop(context);
                            },
                            child: itemBuilder!(context, item, isSelected),
                          );
                        }

                        // Default item UI
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            onItemSelected(item);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.deepPurple.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: isSelected ? 2 : 1.5,
                                color: isSelected
                                    ? Colors.deepPurple
                                    : Colors.grey,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle,
                                      color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: separatorBuilder ??
                          (_, __) => const SizedBox(height: 16),
                    )
                  : emptyBuilder?.call(context) ??
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Text(
                            "No results found.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

final _defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(width: 1.5, color: Colors.grey),
);

final _defaultFocusBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
);
