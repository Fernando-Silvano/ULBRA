import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp()); // Inicia a aplicação Flutter, chamando o widget MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configura as orientações preferenciais da tela como retrato (vertical)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Calculadora de IMC', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor principal do tema como azul
      ),
      home: MyHomePage(), // Define MyHomePage como a tela inicial da aplicação
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController weightController = TextEditingController(); // Controlador para o campo de peso
  TextEditingController heightController = TextEditingController(); // Controlador para o campo de altura
  String result = ''; // Variável para armazenar o resultado do cálculo do IMC
  String classification = 'masculino'; // Define o sexo padrão como masculino

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Calculadora de IMC'), // Título da barra superior
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.info), // Ícone de informação na barra superior
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoScreen()), // Navega para a tela de informações ao pressionar o ícone
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0), // Espaçamento interno do corpo da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)', // Rótulo do campo de peso
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)', // Rótulo do campo de altura
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.male, color: classification == 'masculino' ? Colors.blue : Colors.grey), // Ícone de gênero masculino
                  onPressed: () {
                    setState(() {
                      classification = 'masculino'; // Define a classificação como masculino ao pressionar o ícone
                    });
                  },
                ),
                Text('Masculino'), // Texto indicando gênero masculino
                SizedBox(width: 32.0),
                IconButton(
                  icon: Icon(Icons.female, color: classification == 'feminino' ? Colors.pink : Colors.grey), // Ícone de gênero feminino
                  onPressed: () {
                    setState(() {
                      classification = 'feminino'; // Define a classificação como feminino ao pressionar o ícone
                    });
                  },
                ),
                Text('Feminino'), // Texto indicando gênero feminino
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateIMC(); // Chama a função para calcular o IMC ao pressionar o botão
              },
              child: Text('Calcular'), // Texto do botão de calcular
            ),
            SizedBox(height: 16.0),
            Text(
              result, // Exibe o resultado do cálculo do IMC
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void calculateIMC() {
    double weight = double.parse(weightController.text); // Obtém o peso do campo de texto
    double height = double.parse(heightController.text) / 100; // Obtém a altura e converte para metros
    double imc = weight / (height * height); // Calcula o IMC

    setState(() {
      result = 'Seu IMC: ${imc.toStringAsFixed(1)}\n\n'; // Formata e exibe o resultado do IMC
      result += interpretIMC(imc); // Adiciona a interpretação do resultado do IMC
    });
  }

  String interpretIMC(double imc) {
    if (classification == 'masculino') { // Verifica o gênero masculino
      if (imc < 18.5) {
        return 'Abaixo do peso'; // Retorna a classificação do IMC para masculino
      } else if (imc >= 18.5 && imc < 24.9) {
        return 'Peso normal'; // Retorna a classificação do IMC para masculino
      } else if (imc >= 24.9 && imc < 29.9) {
        return 'Sobrepeso'; // Retorna a classificação do IMC para masculino
      } else {
        return 'Obesidade'; // Retorna a classificação do IMC para masculino
      }
    } else { // Verifica o gênero feminino
      if (imc < 18.5) {
        return 'Abaixo do peso'; // Retorna a classificação do IMC para feminino
      } else if (imc >= 18.5 && imc < 24.9) {
        return 'Peso normal'; // Retorna a classificação do IMC para feminino
      } else if (imc >= 24.9 && imc < 29.9) {
        return 'Sobrepeso'; // Retorna a classificação do IMC para feminino
      } else {
        return 'Obesidade'; // Retorna a classificação do IMC para feminino
      }
    }
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações sobre IMC'), // Título da barra superior na tela de informações
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0), // Espaçamento interno do corpo da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Tabela de Classificação do IMC', // Título da seção de informações
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              '• Abaixo de 18.5: Abaixo do peso\n' // Descrição da tabela de classificação do IMC
                  '• 18.5 - 24.9: Peso normal\n'
                  '• 25.0 - 29.9: Sobrepeso\n'
                  '• 30.0 e acima: Obesidade',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
