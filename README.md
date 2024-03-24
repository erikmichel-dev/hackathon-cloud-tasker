# NUWE Hack - CLOUD - TERRAFORM
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

