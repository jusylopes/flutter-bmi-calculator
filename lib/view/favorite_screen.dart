import 'package:bmi_calculator/controllers/favorite_controller.dart';
import 'package:bmi_calculator/view/components/empty_results_message.dart';
import 'package:bmi_calculator/view/components/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteController>(context, listen: false).startDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<FavoriteController>(
          builder: (context, favorites, child) {
            return favorites.bmis.isEmpty
                ? const EmptyResultsMessage()
                : ListView.builder(
                    itemCount: favorites.bmis.length,
                    itemBuilder: (_, index) {
                      final favoriteItem = favorites.bmis[index];

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          favorites.deleteBmi(id: favoriteItem.id.toString());
                        },
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          return await _confirmDismissDialog(context);
                        },
                        child: FavoriteCard(favoriteItem: favoriteItem),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

Future<bool?> _confirmDismissDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('Tem certeza que deseja deletar este resultado?'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'DELETE',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'CANCELAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
