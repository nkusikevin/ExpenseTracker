import 'package:expense_tracker/components/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateCategoryDialog extends StatefulWidget {
  const CreateCategoryDialog({Key? key}) : super(key: key);

  @override
  State<CreateCategoryDialog> createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {
  bool isExpanded = false;
  Color pickerColor = Color(0xff443a49);
  IconData selectedIcon = FontAwesomeIcons.question;
  final List<IconData> _allIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.car,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.burger,
    FontAwesomeIcons.mugSaucer,
    FontAwesomeIcons.shirt,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.book,
    FontAwesomeIcons.music,
    FontAwesomeIcons.film,
    FontAwesomeIcons.paintbrush,
    FontAwesomeIcons.camera,
  ];
  late List<IconData> _filteredIcons;

  @override
  void initState() {
    super.initState();
    _filteredIcons = _allIcons;
  }

  void _filterIcons(String query) {
    setState(() {
      _filteredIcons = _allIcons
          .where((icon) =>
              icon.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Category'),
      content: Container(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Name',
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Icon',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(selectedIcon),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                    bottom: Radius.circular(isExpanded ? 0 : 12),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 180 : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _filteredIcons.length,
                        itemBuilder: (context, index) {
                          return IconButton(
                            icon: FaIcon(_filteredIcons[index]),
                            onPressed: () {
                              setState(() {
                                selectedIcon = _filteredIcons[index];
                                isExpanded = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () async {
                final Color? newColor = await showDialog(
                  context: context,
                  builder: (context) =>
                      CategoryColorDialog(initialColor: pickerColor),
                );
                if (newColor != null) {
                  setState(() {
                    pickerColor = newColor;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Color',
                isDense: true,
                filled: true,
                fillColor: pickerColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // TODO: Implement category creation logic
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
