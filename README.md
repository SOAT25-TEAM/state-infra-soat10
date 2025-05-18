# `.tfstate` | PosTech 10SOAT • Grupo 47

Este repositório contém os arquivos necessários para configurar um backend para o Terraform usando o Amazon S3 e o DynamoDB. O objetivo é fornecer uma solução robusta e segura para o armazenamento do estado do Terraform e o bloqueio de estado, respectivamente.

## Por que S3 + DynamoDB?

O S3 é usado para armazenar o estado do Terraform, permitindo o versionamento e a criptografia dos arquivos de estado. Isso garante que as mudanças no estado possam ser rastreadas e revertidas se necessário, além de proteger os dados.

O DynamoDB é utilizado para o bloqueio de estado, prevenindo que múltiplas instâncias do Terraform apliquem mudanças ao mesmo tempo, o que poderia levar a estados inconsistentes. A combinação desses serviços oferece uma solução de backend robusta para projetos Terraform de qualquer escala.

## Infraestrutura

A infraestrutura criada por este repositório inclui:

- Um bucket S3 para armazenar o estado do Terraform, com versionamento e criptografia AES256 habilitados para garantir a segurança e a rastreabilidade.
- Uma tabela no DynamoDB para o bloqueio de estado do Terraform, prevenindo a aplicação simultânea de mudanças que poderiam levar a estados inconsistentes.

## Como Utilizar

### Configuração dos Secrets

Certifique-se de ter os seguintes secrets configurados a nível de organização:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`


### Deploy e Destruição Manual via GitHub Actions

O deploy e a destruição do backend são controlados manualmente através de **GitHub Actions**, permitindo uma gestão flexível dos recursos.

- Para *criar* o backend, utilize o workflow `Terraform Backend Deploy`. Este processo configura o bucket S3 e a tabela DynamoDB conforme definido.
- Para *destruir* o backend, utilize o workflow `Terraform Backend Destroy`. Este passo é crucial para remover os recursos e evitar custos desnecessários quando não estão em uso.

### Deploy e Destruição Manual em Ambiente Local

Este repositório inclui um `Makefile` para simplificar o processo de criação e destruição do backend do Terraform.

Para criar o backend, execute o seguinte comando:

```bash
make backend-create
```

Este comando inicializará o Terraform, planejará as alterações necessárias e aplicará a configuração para criar o backend, incluindo o bucket S3 e a tabela DynamoDB.

Para destruir o backend criado, utilize o comando:

```bash
make backend-destroy
```

Este comando inicializará o Terraform e destruirá a infraestrutura gerenciada pelo Terraform, removendo o bucket S3 e a tabela DynamoDB.

## Estrutura do Projeto

- `main.tf`: Define os recursos da AWS para o backend, incluindo o bucket S3 e a tabela DynamoDB.
- `variables.tf`: Variáveis utilizadas na configuração do Terraform.
- `outputs.tf`: Saídas configuradas para fornecer informações úteis após o deploy.
- `.github/workflows/deploy.yml`: Workflow do GitHub Actions para o deploy do backend.
- `.github/workflows/destroy.yml`: Workflow do GitHub Actions para a destruição do backend.
