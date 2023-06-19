import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';

import 'checkout/Checkout.dart';

class Prescription_Upload extends StatefulWidget {
  const Prescription_Upload({Key? key}) : super(key: key);

  @override
  State<Prescription_Upload> createState() => _Prescription_UploadState();
}

class _Prescription_UploadState extends State<Prescription_Upload> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future UploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link ${urlDownload}');

    setState(() {
      uploadTask = null ;
    });
  }
  Future SelectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

      setState(() {
        pickedFile = result.files.first ;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        automaticallyImplyLeading: false,
        title: Text(
          'PharmaGlow',
          style: GoogleFonts.dancingScript(
            color: Colors.white,
            textStyle: TextStyle(
              fontSize: 30,
            )
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            if (pickedFile != null)
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.grey[100],
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20,),
            InkWell(
              onTap: SelectFile,
              child: Container(
                width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors:  [
                        Colors.blue[900]!,
                        Colors.greenAccent
                      ],
                    ),
                  ),
                  child: ListTile(
                      leading: Icon(Icons.select_all),
                      title:Text('Select File')
                  )
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: UploadFile,
              child: Container(
                width:300,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue[900]!,
                      Colors.greenAccent,
                    ],
                  ),
                 ),
                  child: ListTile(
                    leading: Icon(Icons.upload_file),
                      title:Text('Upload')
                  )
              ),
            ),
            SizedBox(height: 20,),
            BuildProgress(),
    ],
        ),
      ),
    );
  }
  Widget BuildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context , snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                ListTile(
                  leading: (100 * progress).roundToDouble() == 100
                    ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                )
                    : null,
                        title: Center(
                  child: Text(
                      '${(100*progress).roundToDouble()}%',
                    style: TextStyle( color: Colors.white),
                  ),
                ),),
              ],
            ),
          );
        }
        else{
          return const SizedBox(height: 50,);
        }
      }
  );
}
