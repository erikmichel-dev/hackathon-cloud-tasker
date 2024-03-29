# Hackathon Cloud Tasker
## Overview
This repository is developed for deploying the solution to the Nuwe hackathon "Cloud TaskAPI by Servlesstech Solutions: Efficient Automation".


- **Developed** following industry-standard best practices in both Python and Terraform code. The Terraform code is structured according to recommended conventions, promoting scalability and ease of management. 

- **Designed** to fulfill its requirements effectively while minimizing unnecessary overhead and complexity. Every component and feature has been crafted with a focus on efficiency, ensuring that the system operates smoothly and reliably.

The Terraform code is divided into four modules:
- **st_api:** Establishes "TaskAPI" on AWS API Gateway with "createtask" and "listtask" endpoints, integrating with AWS Lambda functions and deploying to the target environment.
- **st_events:** Creates a CloudWatch event rule called "every-minute" that triggers the "ExecuteScheduledTask" Lambda function every minute. It also sets up the necessary permissions for CloudWatch Events to invoke the Lambda function.
- **st_functions:** Creates three AWS Lambda functions, each for a specific task (createScheduledTask, listScheduledTask, and executeScheduledTask). The code packages the Python scripts into ZIP files and sets up the Lambda functions with associated permissions and environment variables. Additionally, it defines IAM roles and policies for each Lambda function, granting access to CloudWatch Logs, DynamoDB, and S3 buckets as needed.
- **st_storage:** Creates a DynamoDB table named "ScheduledTasks" and an S3 bucket named "taskstorage". The DynamoDB table utilizes pay-per-request billing mode and includes a global secondary index for querying tasks. Both resources are tagged for identification by project name and environment.

For further information about the endpoints and lambda functions requests and responses, please check the ./Infrastructure/lambda/README.md 

## How to deploy
The project is prepared with the intention of being deployed using LocalStack; however, it is also possible to deploy it in a real AWS environment with some consideration.
### Requirements
- Download and install: `docker`, `localstacks`, `terraform`.
- Launch localstack container with:
```sh
localstack start
```
#### LocalStack Deploy
- Once localstack container is up and running, locate to "./Infrastructure/Terraform" and run:
```sh
terraform init
terraform apply
terraform output --json > output-values.json 
```

#### AWS Deploy
- Follow the same steps but having the following considerations:
**Warning:** For hackathon requirement purposes, the bucket used in this project is simply named "taskstorage". This will most probably not work in real AWS scenario due to bucket unique name requirements. In the `main.tf` file of `st_storage` module you can find commented the following code: 
```terraform
# resource "random_id" "this" {
#   byte_length = 8
# }
```
Uncomment it and add update the following to the S3 bucket resource:
```terraform
resource "aws_s3_bucket" "scheduled_tasks" {
  bucket        = "taskstorage-${random_id.this.hex}"
  force_destroy = true

  tags = {
    Name        = "ScheduledTasks"
    Project     = var.project_name
    Environment = var.infra_env
  }
}
```

## Testing
For localstack testing use the following url template: (Values can be find in output-values.json file)
```sh
https://{api_rest_api_id}.execute-api.localhost.localstack.cloud:4566/prod
```

For AWS testing:
```sh
https://{api_rest_api_id}.execute-api.us-east-1.amazonaws.com/prod (Or directl output value "api_invoke_url")
```

For further testing check the AWS CLI documentation and add the following flag for localstack command use:
```sh
--endpoint-url=http://localhost:4566
```



# Original statement of the hackathon challenge (NUWE Hack - CLOUD - TERRAFORM)
- **Nombre**: ServlessTasker
- **Categoría**: Cloud AWS - Terraform
- **Dificultad**: Medium
- **IaC**: Terraform
- **Descripción**: el objetivo de este challenge es crear un sistema de almacenamiento de task y una scheduled task, gestionado a través de una API llamada **TaskAPI**. Para ello se han de crear varios endpoints en la API:
    - /createtask: 
        1. El endpoint invoca una lambda llamada **createScheduledTask** que se encarga de insertar la task en DynamoDB. Esta lambda debe recibir a través de la API en formato JSON los campos: **task_name** y **cron_expression**. Además, crear un nuevo campo llamado **task_id** e insertar todo en DynamoDB.
        2. POST request.
    - /listtask:
        1. El endpoint invoca una lambda llamada **listScheduledTask** que se encarga de obtener la información que contiene DynamoDB y mostrarla.
        2. GET request.

- De forma paralela, habrá que crear una tercera lambda que se ejecute cada minuto usando **EventBridge**. Esta lambda debe llamarse **executeScheduledTask** y el evento **every-minute**. El objetivo de esta lambda es crear un item, a elección del usuario, en un bucket S3 llamado **taskstorage**.
- La corrección del challenge se realiza de forma automatizada, por lo que cumplir con los objetivos es crucial. Se han dado una serie de nombres y guía de funcionamiento, esto debe respetarse para que se pueda testear el correcto funcionamiento de la infraestructura.
- Entorno de desarrollo: Localstack. Para que pueda llevarse a cabo la corrección, será necesario desarrollar todo para localstack, puesto que no requiere de claves personales de ningún tipo. Algunos datos a tener en cuenta:
    - Región: us-east-1
    - access_key: test
    - secret_key: test
- Información adicional: es importante respetar las pautas y guías que se han aportado, puesto que la corrección automática testea el correcto funcionamiento de la infraestructura, dividiendo este funcionamiento en objetivos, desde el más simple hasta el más complejo.

## Objetivos

1. El archivo main.tf funciona y está listo para `apply`.
2. Desplegar todos los recursos propuestos.
3. Hacer API y lambdas completamente funcionales.
4. EventBridge y tercera lambda completamente funcionales.

## Estructura básica del repositorio
```bash
nuwehack-terraform-tasker/
├── Infraestructure
│   ├── lambda
│   │   ├── lambdasample2.py
│   │   ├── lambdasample.py
│   │   └── README.md
│   └── Terraform
│       ├── main.tf
│       └── policy.json
├── README.md
└── requirements.txt
```
Debe seguirse siempre la estructura predefinida en el challenge para el correcto funcionamiento de la corrección automática. Esta estructura y los nombres de las lambdas pueden variar, pero siempre seguirá un estándar que no puede ser modificado por el participante.

## Puntuación

La puntuación final se dará en función de si se han cumplido los objetivos o no.

En este caso, el reto estará evaluado sobre 900 puntos que se reparten de la siguiente forma:

- Objetivo 1: 225 puntos
- Objetivo 2: 225 puntos
- Objetivo 3: 225 puntos
- Objetivo 4: 225 puntos

