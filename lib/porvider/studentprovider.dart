
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_firebase/Model/model.dart';
import 'package:student_firebase/Reop/student_repo.dart';

final studentProvider= FutureProvider <List<StudentModel>> ((ref) => StudentRepo().getAllData());