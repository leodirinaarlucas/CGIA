# CGIA
Controle Genérico de Instituição Acadêmica

### O sistema deve funcionar a partir dos critérios a seguir:

> **ADMINISTRADOR**  
  - Cada **1** ou **n** administradores para gerir apenas **1** instituição.
  - Administrador dá a permissão aos professores de lançar dados de avaliação e frequência para os seus alunos.
  - Administrador possui acesso aos dados dos alunos e professores por meio dos campos **ALUNOS** e **PROFESSORES** na interface.

> **ALUNO**
  - Cada **1** aluno possui **0** ou **n** notas atribuídas pelo professor.
  - **0** ou **n** alunos fazem parte de **0** ou **n** turmas.
  - **0** ou **n** alunos fazem parte de somente **1** instituição.
  - Os dados pessoais de cada aluno são automaticamente lançados na classe ALUNOS do banco de dados.
  após concluir seu cadastro no aplicativo, no qual a matrícula é feita.
  
> **DISCIPLINA**
  - **0** ou **n** disciplinas pertencem a apenas **1** instituição.
  - Cada **1** disciplina está associada a **0** ou **n** turmas.
  
> **INSTITUIÇÃO**
  - Cada **1** instituição é gerida por **1** ou **n** administradores.
  - Cada **1** instituição possui **0** ou **n** disciplinas.
  - Cada **1** instituição possui **0** ou **n** turmas.
  - Cada **1** instituição possui **0** ou **n** professores.
  - Cada **1** instituição possui **0** ou **n** alunos.
  
> **NOTAS**
  - **0** ou **n** notas são atribuídas para somente cada **1** turma.
  - **0** ou **n** notas são atribuídas para somente cada **1** aluno.
  
> **PERÍODO**
  - Cada **1** período possui **0** ou **n** turmas.
 
> **PROFESSOR**
  - Cada **1** professor é registrado em **0** ou **n** turmas.
  - **0** ou **n** professores para somente **1** instituição de ensino.
  - Professor atribui a nota de avaliação a partir de uma média de notas definidas.
  - Professor atribui número de faltas.
    - Frequência consiste em número de faltas considerando um total de aulas.

> **TURMA**
  - **0** ou **n** turmas estão registradas em cada **1**`disciplina.
  - **0** ou **n** turmas em somente **1** instituição.
  - **0** ou **n** turmas possuem **1** mesmo professor.
  - **0** ou **n** turmas possuem **0** ou **n** alunos.
  - Cada **1** turma possui um conjunto de **0** ou **n** notas atribuídas.
  - **0** ou **n** turmas estão registrados em somente **1** período.
  
> **USUÁRIO**
  - **1** opção designada somente, dentre as seguintes: administrador, aluno ou professor.

### Instituição de Ensino Fundamental, Médio ou Universitário a ser decidido
