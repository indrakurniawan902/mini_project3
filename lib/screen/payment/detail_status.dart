import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indie_commerce/models/status_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DetailStatusScreen extends StatefulWidget {
  final StatusModel data;
  const DetailStatusScreen({super.key, required this.data});

  @override
  State<DetailStatusScreen> createState() => _DetailStatusScreenState();
}

class _DetailStatusScreenState extends State<DetailStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Order"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(widget.data.items[index]["image"]),
                      title: Text(widget.data.items[index]["title"]),
                      subtitle: Text(
                          "${widget.data.items[index]["quantity"].toString()} Item"),
                    ),
                  ),
                );
              },
              itemCount: widget.data.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  final pdf = pw.Document();
                  pdf.addPage(pw.Page(
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return pw.Table(children: [
                          for (var i = 0; i < widget.data.items.length; i++)
                            pw.TableRow(children: [
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text("Name",
                                        style: const pw.TextStyle(fontSize: 6)),
                                    pw.Divider(thickness: 1),
                                    pw.Text(widget.data.items[i]["title"]),
                                  ]),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text("Quantity",
                                        style: const pw.TextStyle(fontSize: 6)),
                                    pw.Divider(thickness: 1),
                                    pw.Text(widget.data.items[i]["quantity"]
                                        .toString())
                                  ]),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text("Price",
                                        style: const pw.TextStyle(fontSize: 6)),
                                    pw.Divider(thickness: 1),
                                    pw.Text(widget.data.items[i]["price"]
                                        .toString())
                                  ]),
                            ])
                        ]);
                      }));
                  Directory? directory =
                      Directory('/storage/emulated/0/Download');
                  if (!await directory.exists()) {
                    directory = await getExternalStorageDirectory();
                  }
                  final String filePath =
                      "${directory!.path}/Transaction${widget.data.id!}.pdf";
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Downloading file ...")));
                  final file = File(filePath);
                  await file.writeAsBytes(await pdf.save());
                  await OpenFile.open(filePath, type: "pdf");
                },
                child: const Text("Download Transaction"))
          ],
        ));
  }
}
