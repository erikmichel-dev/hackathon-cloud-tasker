# Lambda functions

## createScheduledTask

### Overview

Lambda function integrated with the /createtask endpoint, designed to handle incoming scheduled tasks. Upon invocation, it validates the task's schema and cron expression to ensure they meet the required standards. If the validation is successful, the function proceeds to store the task in the designated database table.

### Request

JSON Scheduled task schema:

``` JSON
{
    "task_name": string (Required),
    "cron_expression": string (Required)
}
```

example:

``` JSON
{
    "task_name": "InventoryCheck",
    "cron_expression": "0/1 * * * *"
}
```

### Response

Task validated and created successfully:

```JSON
Status code: 201
{
    "Message":"Task successfully created"
}
```

Missing request payload:

```JSON
Status code: 400
{
    "Error":"Missing payload: Please ensure the request body contains a valid payload"
}
```

Task schema validation failed:

```JSON
Status code: 400
{
    "Error":"Invalid type for key: (InvalidKey). Expected (Type), got {KeyTypeReceived}"
}
```
```JSON
Status code: 400
{
    "Error":"Missing key: (key)"
}
```

Task cron expression validation failed:

```JSON
Status code: 400
{
    "Error":"Invalid cron expression: (Cron expression)"
}
```

Server error:
```JSON
Status code: 500
{
    "Error":"Internal server error: (Error)"
}
```

## listScheduledTask

### Overview

Lambda function integrated with the /listtask endpoint, designed scan stored scheduled tasks. If the validation is successful, the function proceeds to store the task in the designated database table. Allows to specify item limit returned, and pagination.

### Request

#### Query Parameters:
- `scanLimit` (optional): Specifies the maximum number of resources to return per page. Default is 100.
- `paginationToken` (optional): Sets the last key evaluated to scan the following.

### Response

Task list retrieval successfull:

```JSON
{
    {
    "items": [
        {
            "task_name": {
                "S": "TaskExample1"
            },
            "cron_expression": {
                "S": "0/1 * * * *"
            },
            "task_id": {
                "S": "efd93468-267f-4f63-b915-cdeb706c12f1"
            }
        },
        {
            "task_name": {
                "S": "TaskExample2"
            },
            "cron_expression": {
                "S": "* * 5 * *"
            },
            "task_id": {
                "S": "691694fc-3a48-4c33-b9e1-37995c4a69b6"
            }
        }
    ],
    "LastEvaluatedKey": {
        "task_id": {
            "S": "691694fc-3a48-4c33-b9e1-37995c4a69b6"
        }
    }
}
}
```

If it is not succesfull, the response will be _500_ code with a JSON body following this structure:

Server error:
```JSON
Status code: 500
{
    "Error":"Internal server error: (Error)"
}
```

## executeScheduledTask

### Overview

Creates and uploads a 'txt' file to an S3 bucket. Triggered by an EventBridge rule set to run once every minute.

### Input

No input.

### Response

Task executed successfully:

```JSON
Status code: 200
{
    "Message":"Task successfully created"
}
```

Server error:

```JSON
Status code: 500
{
    "Error":"Internal server error: (Error)"
}
```