import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/data/categories.dart';
import 'package:shopping/models/category.dart';
import 'package:shopping/models/grocery_item.dart';
import 'package:shopping/widgets/new_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _addItem(BuildContext context) async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) return;
    print(newItem);
    setState(() {
      _groceryItems.add(
        newItem,
      ); // receiving the newItem object sent back from NewItem widget
    });
  }

  void _loadItems() async {
    print('LOAD ITEMS');
    final loadedItems = []; // temporary list
    final url = Uri.parse('http://localhost:3001/api/items');
    final response = await http.get(url);

    final convertedResponse = json.decode(response.body);
    List<GroceryItem> itemsList = [];

    itemsList.addAll(
      convertedResponse.map<GroceryItem>((item) {
        final Category categoryObj = categories.entries
            .firstWhere((ctg) => ctg.value.title == item['category'])
            .value;

        return GroceryItem(
          id: item['id'],
          name: item['name'],
          quantity: item['quantity'],
          category: categoryObj,
        );
      }).toList(),
    );
    setState(() {
      _groceryItems = itemsList;
      _isLoading = false;
    });
  }

  void _removeItem(item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items were added yet'));

    if (_isLoading) {
      content = const Center(
        child: SpinKitPouringHourGlass(color: Colors.white, size: 70.0),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,

        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),

          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 25,
              height: 25,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: content,
    );
  }
}
