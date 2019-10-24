# CGIA - Controle Genérico de Instituição Acadêmica :+1:

### O sistema deve funcionar a partir dos critérios a seguir:

- 1 ou mais administradores com permissão para gerir apenas 1 instituição de ensino. <br>
  - Administrador dá a permissão aos professores de lançar dados de avaliação e frequência para os seus alunos.
  - Administrador possui acesso aos dados dos alunos e professores por meio dos campos ALUNOS e PROFESSORES na interface.

- 1 professor para **0** ou **n** turmas.

Nota de avaliação consiste em uma média de notas a serem definidas por pcada professor.

Frequência consiste em número de faltas considerando um total de aulas.

Os dados pessoais de cada aluno são automaticamente lançados na classe ALUNOS do banco de dados <br> 
após concluir seu cadastro no aplicativo, no qual a matrícula é feita.

Talvez seja melhor decidir por instituição de Ensino Fundamental ou Médio, visto que podemos consideradar menos disciplinas e são iguais em todos os anos e turmas?
