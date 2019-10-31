# CGIA - Controle Genérico de Instituição Acadêmica :+1:

### O sistema deve funcionar a partir dos critérios a seguir:

> **ADMINISTRADOR**  
  - **1** ou **n** administradores para gerir apenas **1** instituição.
  - Administrador dá a permissão aos professores de lançar dados de avaliação e frequência para os seus alunos.
  - Administrador possui acesso aos dados dos alunos e professores por meio dos campos **ALUNOS** e **PROFESSORES** na interface.

> **ALUNO**
  - **1** aluno possui **0** ou **n** notas atribuídas pelo professor.
  - **0** ou **n** alunos fazem parte de **0** ou **n** turmas.
  - **0** ou **n** alunos fazem parte de somente **1** instituição.
  - Os dados pessoais de cada aluno são automaticamente lançados na classe ALUNOS do banco de dados.
  após concluir seu cadastro no aplicativo, no qual a matrícula é feita.
  
> **DISCIPLINA**
  - **0** ou **n** disciplinas pertencem a apenas **1** instituição.
  - **1** única disciplina está associada a **0** ou **n** turmas.
  
> **INSTITUIÇÃO**
  - **1** única instituição é gerida por **1** ou **n** administradores.
  - **1** única instituição possui **0** ou **n** disciplinas.
  - **1** única instituição possui **0** ou **n** turmas.
  - **1** única instituição possui **0** ou **n** professores.
  - **1** única instituição possui **0** ou **n** alunos.
  
> **PROFESSOR**
  - **1** professor para **0** ou **n** turmas.
  - **0** ou **n** professores para somente **1** instituição de ensino.
  - Professor atribui a nota de avaliação a partir de uma média de notas definidas.
  - Professor atribui número de faltas.
    - Frequência consiste em número de faltas considerando um total de aulas.

### Instituição de Ensino Fundamental ou Médio ou Universitário a ser decidido
