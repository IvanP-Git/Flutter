// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Subject subject = Get.arguments;
  HomeController homeC = Get.find();

  EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = subject.title!;
    controller.descC.text = subject.description!;
    return Scaffold( // Scaffold proporciona la estructura básica de la pantalla
        appBar: AppBar(
          title: const Text('Edit Subject'),
          centerTitle: true,
        ),
        body: ListView( // ListView permite que el contenido sea desplazable si es necesario
          padding: const EdgeInsets.all(20),
          children: [
            TextField( // TextField para el título del Subject
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField( // TextField para la descripción del Subject
              controller: controller.descC,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton( // ElevatedButton para guardar los cambios
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.editSubject(subject.id!);
                    if (res == true) {
                      await homeC.getAllSubjects();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Edit Subject" : "Loading...")))
          ],
        ));
  }
}
