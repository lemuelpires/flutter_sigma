import 'package:flutter/material.dart';

void main() {
  runApp(TesteCadastro());
}

class TesteCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  String _estadoCivil = 'Solteiro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de cadastro"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Digite seu Nome",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              Text(
                "Estado Civil",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  RadioListTile(
                    title: Text("Solteiro"),
                    value: "Solteiro",
                    groupValue: _estadoCivil,
                    onChanged: (value) {
                      setState(() {
                        _estadoCivil = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Casado"),
                    value: "Casado",
                    groupValue: _estadoCivil,
                    onChanged: (value) {
                      setState(() {
                        _estadoCivil = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Viúvo"),
                    value: "Viúvo",
                    groupValue: _estadoCivil,
                    onChanged: (value) {
                      setState(() {
                        _estadoCivil = value.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Insira o cartão de crédito",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card number',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Exp. Date',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Ação de cadastro
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
