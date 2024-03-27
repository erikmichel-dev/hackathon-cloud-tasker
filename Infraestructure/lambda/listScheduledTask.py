import boto3
import json
import os

table_name = os.environ["SCHEDULED_TASK_TABLE_NAME"]

session = boto3.Session(region_name=os.environ['REGION'])
dynamodb_client = session.client('dynamodb')

def lambda_handler(event, context):

    try:
        dynamodb_response = dynamodb_client.scan(
            TableName=table_name
        )
        print(f'Scan response: {dynamodb_response}')
        items = dynamodb_response['Items']

        return {
          'statusCode': 200,
          'body': json.dumps(items)
        }
    except Exception as e:
        print(f'ERROR: {e}')
        return {
            'statusCode': 500,
            'body': json.dumps(f'Internal server error: {e}')
        }