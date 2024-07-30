
import 'package:anotacao_firebase/database/databaseOperations.dart';
import 'package:anotacao_firebase/route/appRoutes.dart';
import 'package:flutter/material.dart';

class DetalheNotaBottomSheet extends StatelessWidget {
  final Map<String, dynamic> anotacao;

  const DetalheNotaBottomSheet({super.key, required this.anotacao});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            anotacao['titulo'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            anotacao['corpo'],
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseOperations _anotacoes = DatabaseOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [Icon(Icons.person, color: Colors.white)],
        title: Text(
          'Anotações',
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.novaAnotacao);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _anotacoes.getAnotacao(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os dados.'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final anotacao = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (context, scrollController) {
                                    return SingleChildScrollView(
                                      controller: scrollController,
                                      child: DetalheNotaBottomSheet(
                                        anotacao: anotacao,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: ListTile(
                              title: Center(
                                child: Text(
                                  anotacao['titulo'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  await _anotacoes.excludeAnotacao(anotacao['id']);
                                  setState(() {
                                    // Atualiza a lista após exclusão
                                  });
                                },
                              ),
                            ),
                          ),

                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      anotacao['corpo'],
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),)
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Nenhum dado encontrado.'),
            );
          }
        },
      ),
    );
  }
}

