import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MessageData> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageItem(
            messageData: messages[index],
            onCheckboxChanged: (value) {
              setState(() {
                messages[index].isChecked = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context);
        },
        tooltip: 'Nuevo Mensaje',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context) async {
    TextEditingController _textEditingController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Mensaje'),
          content: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Mensaje Nuevo'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                setState(() {
                  messages
                      .add(MessageData(message: _textEditingController.text));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MessageData {
  String message;
  bool isChecked;

  MessageData({required this.message, this.isChecked = false});
}

class MessageItem extends StatelessWidget {
  final MessageData messageData;
  final ValueChanged<bool?> onCheckboxChanged;

  MessageItem({required this.messageData, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: messageData.isChecked
                ? Text(
                    'Mensaje: ${messageData.message}',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  )
                : Text(
                    'Mensaje: ${messageData.message}',
                  ),
          ),
          Checkbox(
            value: messageData.isChecked,
            onChanged: onCheckboxChanged,
          ),
        ],
      ),
    );
  }
}
