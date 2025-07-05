import 'package:flutter/material.dart';

class SearchableDropdownSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final String selectedItem;
  final Function(String) onItemSelected;

  const SearchableDropdownSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    List<String> filteredList = List.from(items);

    return StatefulBuilder(
      builder: (context, modalSetState) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(title,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
            const SizedBox(height: 6),
            Text(subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 16),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search here...',
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                border: _inputBorder,
                focusedBorder: _focusInputBorder,
                enabledBorder: _inputBorder,
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
                  final title = filteredList[index];
                  final isSelected = title == selectedItem;

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      onItemSelected(title);
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
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          if (isSelected)
                            const Icon(Icons.check_circle,
                                color: Colors.deepPurple),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
              )
                  : const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text("No results found.",
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

OutlineInputBorder _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(width: 1.5, color: Colors.grey),
);

OutlineInputBorder _focusInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
);
