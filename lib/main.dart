import 'package:flutter/material.dart'; // import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o app e passa o widget ContadorApp como o widget raiz da aplicação
}

class ContadorApp extends StatelessWidget {
  //essa classe é um widget sem estado, ou seja, não tem estado interno que possa mudar ao longo do tempo. Ela é usada para construir a interface do usuário.
  const ContadorApp({super.key});
  //contrutor reapssadno a key para o widget pai
  @override
  Widget build(BuildContext context) {
    //monta e devolve a config geral do app
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      //titulo interno, acho q aparce no navegador
      home: TelaContador(),
      //a tela inicial do app e o qidget tela contador definido logo abaixo.
    );
  }
}

class TelaContador extends StatefulWidget {
  //isso e novo em relaçao ao projeto 1, cracha
  //agr a tela precisa lembrar de dados que mudam, a contagem, o nome, o historico, dado digitado.
  //esta classe ainda nao esta gaurdando nada sozinha. mas ela ja declara que existe um state associado a ela
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  //esta e a classe que efetivamente guarda os dados que podem  mudar durante o uso do app , funciona como um toque? que sobrevive entre uma reconstrucao [...]
  int _pecasAprovadas = 0;
  final _nomeController = TextEditingController();
  //text edit controller e a ponta que o que aprace na tela textfield, e o codigo dart. guarda o texto
  
  final List<String> _registros = [];
  //lista que vai guardar os baguhos?

  void _aprovarPeca() {
    //botao chamada toda vez q peca e trocada pelo usuario
    setState(() {
      //alguma coisa state muda, essa alteraçao precisa ocorrer dentro do 
      _pecasAprovadas += 1;
    });
  }

  void _registarEZerar() {
    //funcao chamada qnd o botao registar e zerar e acuionado
    final nome = _nomeController.text.trim().isEmpty
        ? 'sem Nome'
        : _nomeController.text.trim();
    //

    setState(() {
      //dnv toda mudanca de state entra no setstate.
      _registros.add('$nome - $_pecasAprovadas pecas(s) ');
      //monta texto combinand o nome e a contagem atual, interpolação de astrings
      //aadd esse texto mo final da fila de registrs
      _pecasAprovadas = 0;
      //zera o contador para inspetor comecar a contar o proximo lote.
    });
  }

  @override
  void dispose() {
    //dispose é chamado pelo flutter qnd a tela e removida da arvore original e widgets, ou seja qnd o user sai da tela.
    _nomeController.dispose();
    //libera os recursos de controller evita deixar memoria alocado sem uso
    super.dispose();
    //chama a implemantacao original, nativa, do dispose da classe pai
    //deve ser sempre a ultima linha da funcao dispose
  }

  @override
  Widget build(BuildContext context) {
    //aqui monta a arvore de widgets que representa a tela do estado aytual, com os valores atuais de pecas aprovadas
    return Scaffold(
      //esqueleto padrao de uma tela flutter
      appBar: AppBar(
        title: const Text('Inspeção de Peças'),
        //titulo fixo na barra de topo da tela.
      ),
      body: Padding(
        //corpo da tela com espaçamento interno ao redor de todos os elementos
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //organiuza todo o conteudo da tela verticalmente
          children: [
            TextField(
              //campo de texto onde o Inspetor digite o nome 
              controller: _nomeController,
              //liga este campo de controller declarado la em cima?
              decoration: const InputDecoration(
                labelText: 'Nome do Inspetor do Turno',
                border: OutlineInputBorder(),
              ),
              onChanged: (texto) {
                //;..... é chamaado toda vez que o ussuraio apaga um caracter
                setState(() {});
                //chamamos o setsate para com um bloco vazio so prara forccar a tela a redesenhar, o dado em si ja esta dwntro do nome. alguma coisas.
              },
            ),
            const SizedBox(height: 16),
            //espaço vertical entre o campo de texto e a linha de 'responsavel'
            Text(
              _nomeController.text.trim().isEmpty
                  ? 'Responsavel: nao informado'
                  : 'responsavel: ${_nomeController.text.trim()}',
              // se o campo ainda esta vazio msotramos um aviso se n. mostramos o nome do dado
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              '$_pecasAprovadas',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              //deixar grandao
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //deixa os botoes  no mei
              children: [
                FilledButton.icon(
                  onPressed: _aprovarPeca,
                  //qnd tocado o botao chama a funcao aprovar peca. Essa e uma forma curta, abreviado de escrever onpressed, aporovarpeca.
                  icon: const Icon(Icons.add),
                  label: const Text('+1 Peca'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  //boto com apenas controno, sem preenchimento
                  //usado aqui para indicar uma acao secundario (registrar e zerar)
                  onPressed: _registarEZerar,
                  //chama a funcao responsavel
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Registrar e zerar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              //align posciciona seus filhos dentro do espaco disponivel
              //vamos usar aqui para forcar o titulo da lista a ficar alinhado a esquerda, mesmo estando dentro de uma row
              alignment: Alignment.centerLeft,
              child: Text(
                'Historico do Turno',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              //dentro da colum, o expanded foracca o espaco vertical disponivel/restante, e ele que da a altura disponivel 
              child: _registros.isEmpty
                  ? const Center(child: Text('Nenhum registro'))
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            //leading e o icone a esquerda do texto
                            leading: const Icon(Icons.history),
                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}