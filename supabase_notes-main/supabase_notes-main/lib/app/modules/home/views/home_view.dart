import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) { // Scaffold proporciona la estructura básica de la pantalla
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
        body: FutureBuilder( // FutureBuilder se utiliza para manejar la carga de datos asíncrona
            future: controller.getAllSubjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Obx(() => controller.allSubjects.isEmpty
                  ? const Center(
                      child: Text("NO DATA"),
                    )
                  : ListView.builder( // ListView.builder se utiliza para construir una lista de elementos de forma eficiente
                      itemCount: controller.allSubjects.length,
                      itemBuilder: (context, index) {
                        Subject note = controller.allSubjects[index];
                        return ListTile(
                          onTap: () => Get.toNamed( // Get.toNamed se utiliza para navegar a otra pantalla pasando argumentos
                            Routes.EDIT_NOTE,
                            arguments: note,
                          ),
                          leading: CircleAvatar( // CircleAvatar se utiliza para mostrar un avatar circular, en este caso con el ID del Subject
                            child: Text("t${note.id}"),
                          ),
                          title: Text("title: ${note.title}"),
                          subtitle: Text("description: ${note.description}"),
                          trailing: IconButton(
                            onPressed: () async =>
                                await controller.deleteSubject(note.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ));
            }),
        floatingActionButton: FloatingActionButton( // FloatingActionButton se utiliza para mostrar un botón flotante en la pantalla
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: const Icon(Icons.add),
        ));
  }
}
