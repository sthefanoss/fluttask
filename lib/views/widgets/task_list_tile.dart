import 'package:fluttask/data/models/task.dart';
import 'package:fluttask/helpers/date_parser.dart';
import 'package:flutter/material.dart';

class TaskListTile extends StatefulWidget {
  final Task task;
  final void Function() onConcludeClick;
  final void Function() onEditClick;
  final void Function() onDeleteClick;

  TaskListTile({
    this.task,
    this.onConcludeClick,
    this.onEditClick,
    this.onDeleteClick,
  }) : super(key: Key(task.id));

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.name),
      subtitle: Text(_tileSubtitle()),
      onTap: () => setState(() => isCollapsed = !isCollapsed),
      leading: Checkbox(
        onChanged: (_) {
          if (!widget.task.isConcluded) widget.onConcludeClick();
        },
        value: widget.task.isConcluded,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _customIconButton(Icons.delete, widget.onDeleteClick),
          _customIconButton(Icons.edit, widget.onEditClick),
        ],
      ),
    );
  }

  String _tileSubtitle() {
    String _subtitle =
        'Entrega: ${DateTimeFormatter.encode(widget.task.dateOfDelivery)}';
    if (widget.task.dateOfConclusion != null)
      _subtitle +=
          '\nConclusão ${DateTimeFormatter.encode(widget.task.dateOfConclusion)}';
    if (widget.task.description.length > 0 && !isCollapsed)
      _subtitle += '\n\n${widget.task.description}';

    return _subtitle;
  }

  Widget _customIconButton(IconData icon, Function function) {
    return GestureDetector(
      onTap: function,
      child: Container(padding: const EdgeInsets.all(4), child: Icon(icon)),
    );
  }
}
