// ignore_for_file: prefer_const_constructors, todo, unused_field

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/app/services/database.dart';

/// This class will serve to build a mutable form page that allows user to Edit the job name and rate per hour.
class EditJobPage extends StatefulWidget {
  const EditJobPage({Key? key, required this.database, this.job})
      : super(key: key);

  final Database? database;
  final Job? job;

  static Future<void> show(BuildContext context, {Job? job}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<EditJobPage> createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job?.name;
      _ratePerHour = widget.job?.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database!.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job?.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(
            context,
            title: "Name Already Used",
            content: "Please type a different Job Name",
            defaultActionText: "OK",
          );
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(name: _name!, ratePerHour: _ratePerHour!, id: id);
          await widget.database!.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: "Operation failed",
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? "New Job" : "Edit job"),
        actions: <Widget>[
          TextButton(
            onPressed: _submit,
            child: Text(
              "Save",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        validator: (value) => value!.isNotEmpty ? null : "Name can't be empty",
        decoration: InputDecoration(labelText: "Job name"),
        initialValue: _name,
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        validator: (value) => value!.isNotEmpty ? null : "Please input a rate",
        decoration: InputDecoration(labelText: "Rate per hour"),
        initialValue: _ratePerHour != null ? "$_ratePerHour" : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value!) ?? 0,
      ),
    ];
  }
}
