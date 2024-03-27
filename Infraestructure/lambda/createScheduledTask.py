from botocore.exceptions import ClientError
import boto3
import uuid
import json
import os
import re

scheduled_task_schema = {
    'task_name': str,
    'cron_expression': str 
}

table_name = os.environ["SCHEDULED_TASK_TABLE_NAME"]

session = boto3.Session(region_name=os.environ['REGION'])
dynamodb_client = session.client('dynamodb')

cron_regex = '(@(annually|yearly|monthly|weekly|daily|hourly|reboot))|(@every (\d+(ns|us|µs|ms|s|m|h))+)|((((\d+,)+\d+|(\d+(\/|-)\d+)|\d+|\*) ?){5,7})'

def lambda_handler(event, context):
    print(f'Event: {event}')

    try:
        scheduled_task = retrieve_payload(event)
        validate_schema(scheduled_task, scheduled_task_schema)
        validate_cron_expression(scheduled_task['cron_expression'])
    except Exception as e:
        print(f'ERROR: {e}')
        return {
            'statusCode': 400,
            'body': json.dumps(f'{e}')
        }

    try:
        dynamodb_response = dynamodb_client.put_item(
            TableName=table_name,
            Item={
                "task_id": {
                    "S": str(uuid.uuid4())
                },
                "task_name": {
                    "S": scheduled_task["task_name"]
                },
                "cron_expression": {
                    "S": scheduled_task["cron_expression"]
                }
            }
        )
        print(dynamodb_response)

        return {
            'statusCode': 201,
            'body': json.dumps('Task successfully created')
        }
    
    except ClientError as e:
        print(f'ERROR: {e}')
        return {
            'statusCode': 500,
            'body': json.dumps(f'Internal server error: {e}')
        }

def retrieve_payload(event):
    if event.get("body"):
        scheduled_task = json.loads(event['body'])
        print(f'Body: {scheduled_task}')
    else:
        raise Exception('Missing payload: Please ensure the request body contains a valid payload')
    return scheduled_task

def validate_schema(data, schema):
    for key, expected_type in schema.items():
        if key not in data:
            raise Exception(f"Missing key: {key}")
        if not isinstance(data[key], expected_type):
            raise Exception(f"Invalid type for key: {key}. Expected {expected_type}, got {type(data[key])}")
            
    print("Data schema validated")
    return

def validate_cron_expression(cron_expression):
    x = re.search(cron_regex, cron_expression)
    print('HERE', x)
    if x == None:
        raise Exception(f"Invalid cron expression: {cron_expression}")
        
    print("Cron expression validated")
    return