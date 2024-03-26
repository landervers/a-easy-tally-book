import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: TextInputDemo(),
    );
  }
}

const kTextFieldPadding = 16.0;
const kIconSize = 28.0;

class TextInputDemo extends StatefulWidget {
  @override
  State<TextInputDemo> createState() => _TextInputDemoState();
}

class _TextInputDemoState extends State<TextInputDemo> {
  final focusNode = FocusNode();
  var showEmojiKeyboard = false;

  @override
  void initState() {
    focusNode.addListener(_handleFocusChange);

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  void _handleFocusChange() {
    print("focus changed ${focusNode.hasFocus}");
    if (focusNode.hasFocus) {
      setState(() {
        showEmojiKeyboard = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    print("keyboardHeight $keyboardHeight");
    print("bottomPadding $bottomPadding");

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: !showEmojiKeyboard,
          appBar: AppBar(title: const Text('Home')),
          backgroundColor: Colors.orange,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      color: Colors.white38,
                      child: ListView(
                        children: List.generate(
                          30,
                              (i) => ListTile(
                            title: Text("#$i"),
                          ),
                        ).toList(),
                      ),
                    )),
                Stack(
                  children: [
                    TextField(
                      // autofocus: true,
                      focusNode: focusNode,
                      showCursor: true,
                      minLines: 1,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: kTextFieldPadding,
                            horizontal: kIconSize + 2 * kTextFieldPadding),
                        hintText: 'Enter your text here',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: IconButton(
                          onPressed: () {
                            print("face pressed!");
                            setState(() {
                              showEmojiKeyboard = !showEmojiKeyboard;
                            });

                            focusNode.unfocus();
                          },
                          // splashRadius: 1.0,
                          padding: const EdgeInsets.fromLTRB(
                              kTextFieldPadding, 8, 8, kTextFieldPadding),
                          // constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.face_outlined,
                            size: kIconSize,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: IconButton(
                          onPressed: () {
                            print("pressed!");
                          },
                          // splashRadius: 1.0,
                          padding: const EdgeInsets.fromLTRB(
                              8, 8, kTextFieldPadding, kTextFieldPadding),
                          // constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.note_add_outlined,
                            size: kIconSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (showEmojiKeyboard)
                  SizedBox(
                    height: 336 - bottomPadding,
                    child: Container(
                      color: Colors.black,
                    ),
                  )
              ],
            ),
          )),
    );
  }
}