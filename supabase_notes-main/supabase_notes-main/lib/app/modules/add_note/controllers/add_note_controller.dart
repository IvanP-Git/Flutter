import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  Future<bool> addSubject() async { // Añade un nuevo sujeto a la base de datos
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      List<dynamic> res = await client // Consulta para obtener el id del usuario actual
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = (res).first as Map<String, dynamic>; // Obtiene el primer resultado de la consulta y lo convierte a un mapa
      int id = user["id"]; // Extrae el id del usuario del mapa obtenido
      await client.from("subjects").insert({ // Inserta un nuevo sujeto en la tabla "subjects" con los datos proporcionados
        "user_id": id, // Asocia el sujeto con el id del usuario actual
        "title": titleC.text,
        "description": descC.text,
        "created_at": DateTime.now().toIso8601String(),
      });
      return true;
    } else {
      return false;
    }
  }
}
