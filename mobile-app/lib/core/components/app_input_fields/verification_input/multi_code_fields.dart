import 'package:flutter/material.dart';

class MultiCodeFields extends StatefulWidget {
  final void Function(String)? onCompleted;

  const MultiCodeFields({
    super.key,
    this.onCompleted,
    required this.childBuilder,
    required this.cLen,
  });
  final int cLen;
  final Widget Function(
    Function(String, int) onChanged,
    List<TextEditingController> controller,
    List<FocusNode> fNode,
    int codeLength,
  )
  childBuilder;

  @override
  State<MultiCodeFields> createState() => _MultiCodeFieldsState();
}

class _MultiCodeFieldsState extends State<MultiCodeFields> {
  late int codeLength;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    codeLength = widget.cLen;
    controllers = List.generate(widget.cLen, (_) => TextEditingController());
    focusNodes = List.generate(widget.cLen, (_) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(_onChanged, controllers, focusNodes, codeLength);
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < codeLength - 1) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    final code = controllers.map((c) => c.text).join();
    if (code.length == codeLength && !code.contains('')) {
      widget.onCompleted?.call(code);
    }
  }
}
// class MultiCodeFields extends StatefulWidget {
//   final void Function(String)? onCompleted;

//   const MultiCodeFields({
//     super.key,
//     this.onCompleted,
//     required this.childBuilder,
//     required this.cLen,
//   });
//   final int cLen;
//   final Widget Function(
//     Function(String, int) onChanged,
//     List<TextEditingController> controller,
//     List<FocusNode> fNode,
//     int codeLength,
//   )
//   childBuilder;

//   @override
//   State<MultiCodeFields> createState() => _MultiCodeFieldsState();
// }

// class _MultiCodeFieldsState extends State<MultiCodeFields> {
//   // late TFModel tfModel;
//   late int codeLength;
//   late List<TextEditingController> controllers;
//   late List<FocusNode> focusNodes;

//   @override
//   void initState() {
//     super.initState();
//     codeLength = widget.cLen;
//     controllers = List.generate(widget.cLen, (_) => TextEditingController());
//     focusNodes = List.generate(widget.cLen, (_) => FocusNode());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.childBuilder(_onChanged, controllers, focusNodes, codeLength);
//   }

//   @override
//   void dispose() {
//     for (var c in controllers) {
//       c.dispose();
//     }
//     for (var f in focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   void _onChanged(String value, int index) {
//     if (value.isNotEmpty && index < codeLength - 1) {
//       focusNodes[index + 1].requestFocus();
//     }
//     if (value.isEmpty && index > 0) {
//       focusNodes[index - 1].requestFocus();
//     }

//     final code = controllers.map((c) => c.text).join();
//     debugPrint(
//       'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH',
//     );
//     debugPrint('value is : $value');
//     debugPrint('code is : $code');
//     debugPrint('codeLength is : $codeLength');
//     debugPrint(
//       'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH',
//     );
//     if (code.length == codeLength && !code.contains('')) {
//       widget.onCompleted?.call(code);
//       debugPrint('call in Multi');
//       debugPrint(
//         'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH',
//       );
//     }
//   }
// }
