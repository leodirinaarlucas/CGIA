# CGIA - Controle Genérico de Instituição Acadêmica :+1:

### O sistema deve funcionar a partir dos critérios a seguir:

> **ADMINISTRADOR**  
  - **1** ou **n** administradores para gerir apenas **1** instituição de ensino
  - Administrador dá a permissão aos professores de lançar dados de avaliação e frequência para os seus alunos
  - Administrador possui acesso aos dados dos alunos e professores por meio dos campos **ALUNOS** e **PROFESSORES** na interface

> **PROFESSOR**
  - **1** professor para **0** ou **n** turmas.
  - Professor atribui a nota de avaliação a partir de uma média de notas definidas
  - Professor atribui número de faltas
    - Frequência consiste em número de faltas considerando um total de aulas

> **ALUNO**
  - Os dados pessoais de cada aluno são automaticamente lançados na classe ALUNOS do banco de dados
  após concluir seu cadastro no aplicativo, no qual a matrícula é feita.

> Talvez seja melhor decidir por instituição de Ensino Fundamental ou Médio, visto que podemos consideradar menos disciplinas e são iguais     em todos os anos e turmas?
