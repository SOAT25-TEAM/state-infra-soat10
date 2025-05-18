# `.tfstate` | PosTech 10SOAT • Grupo 47

Este repositório contém os arquivos necessários para configurar um backend para o Terraform usando o Amazon S3 e o MySqlDB. O objetivo é fornecer uma solução robusta e segura para o armazenamento do estado do Terraform e o bloqueio de estado, respectivamente.

## Por que S3 + MySqlDB?

A combinação S3 com MySQLDB no backend do Terraform para AWS é uma prática comum para gerenciar o estado do Terraform de forma colaborativa e segura.
O S3 é utilizado como um "bucket" para armazenar o estado do Terraform, enquanto o MySQLDB é usado para lidar com o bloqueio do estado, garantindo que apenas uma pessoa possa modificar a infraestrutura de cada vez, evitando conflitos.

## Infraestrutura

A infraestrutura criada por este repositório inclui:

- Um bucket S3 para armazenar o estado do Terraform, com versionamento e criptografia AES256 habilitados para garantir a segurança e a rastreabilidade.
- Uma tabela no MySQLDB para o bloqueio de estado do Terraform, prevenindo a aplicação simultânea de mudanças que poderiam levar a estados inconsistentes.

## Como Utilizar

### Configuração dos Secrets

Certifique-se de ter os seguintes secrets configurados a nível de organização:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`


### Deploy e Destruição Manual via GitHub Actions

O deploy e a destruição do backend são controlados manualmente através de **GitHub Actions**, permitindo uma gestão flexível dos recursos.

- Para *criar* o backend, utilize o workflow `Terraform Backend Deploy`. Este processo configura o bucket S3 e a tabela MySqlDB conforme definido.
- Para *destruir* o backend, utilize o workflow `Terraform Backend Destroy`. Este passo é crucial para remover os recursos e evitar custos desnecessários quando não estão em uso.

### Deploy e Destruição Manual em Ambiente Local

Este repositório inclui um `Makefile` para simplificar o processo de criação e destruição do backend do Terraform.

Para criar o backend, execute o seguinte comando:

```bash
make backend-create
```

Este comando inicializará o Terraform, planejará as alterações necessárias e aplicará a configuração para criar o backend, incluindo o bucket S3 e a tabela MySqlDB.

Para destruir o backend criado, utilize o comando:

```bash
make backend-destroy
```

Este comando inicializará o Terraform e destruirá a infraestrutura gerenciada pelo Terraform, removendo o bucket S3 e a tabela MySqlDB.

## Estrutura do Projeto

- `main.tf`: Define os recursos da AWS para o backend, incluindo o bucket S3 e a tabela MySqlDB.
- `variables.tf`: Variáveis utilizadas na configuração do Terraform.
- `outputs.tf`: Saídas configuradas para fornecer informações úteis após o deploy.
- `.github/workflows/deploy.yml`: Workflow do GitHub Actions para o deploy do backend.
- `.github/workflows/destroy.yml`: Workflow do GitHub Actions para a destruição do backend.
