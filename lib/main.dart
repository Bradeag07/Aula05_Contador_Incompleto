import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o app e passa o widget ContadorApp como o widget raiz da aplicação
}
class ContadorApp extends StatelessWidget{
  //essa classe é um widget sem estado, ou seja, não tem estado interno que possa mudar ao longo do tempo. Ela é usada para construir a interface do usuário.
  const ContadorApp({super.key});
  //contrutor reapssadno a key para o widget pai
  @override
  Widget build(BuildContext context){
    //monta e devolve a config geral do app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      //titulo interno, acho q aparce no navegador
      home:const TelaContador(),
      //a tela inicial do app e o qidget tela contador definido logo abaixo.
    );
  }
}
class TelaContador extends StatefulWidget{
  //isso e novo em relaçao ao projeto 1, cracha
  //agr a tela precisa lembrar de dados que mudam, a contagem, o nome, o historico, dado digitado.
  //esta classe ainda nao esta gaurdando nada sozinha. mas ela ja declara que existe um state associado a ela
  const TelaContador({super.key});
  @override
    State<TelaContador> createState() => _TelaContadorState();

    class _TelaContadorState extends State<TelaContador> {
      //esta e a classe que efetivamente guarda os dados que podem  mudar durante o uso do app , funciona como um toque? que sobrevive entre uma reconstrucao [...]
      int _pecasAprovadas = 0;
      final _nomeController = TextEditingController();
      //text edit controller e a ponta que o que aprace na tela textfield, e o codigo dart. guarda o texto
      
    }

}