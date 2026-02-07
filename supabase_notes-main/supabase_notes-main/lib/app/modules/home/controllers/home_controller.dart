import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList allSubjects = <Subject>[].obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllSubjects() async { // Función para obtener todas los Subjects del usuario
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    
    if (res.isEmpty) return;
    final user = res.first as Map<String, dynamic>;
    int userId = user["id"];
    final subjectsRes = await client
        .from("subjects")
        .select()
        .match({"user_id": userId});

    List<Subject> subjects = Subject.fromJsonList(subjectsRes as List); // Convertir la respuesta a una lista de objetos Subject

    allSubjects(subjects);
    allSubjects.refresh();
  }

  Future<void> deleteSubject(int id) async { // Función para eliminar un Subject por su ID
    await client.from("subjects").delete().match({
      "id": id,
    });
    getAllSubjects();
  }
}
