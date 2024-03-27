from botocore.exceptions import ClientError
import boto3
import json
import os

session = boto3.Session(region_name=os.environ['REGION'])
dynamodb_client = session.client('dynamodb')
table_name = os.environ["SCHEDULED_TASK_TABLE_NAME"]

def lambda_handler(event, context):

    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
    return {
        'statusCode': 200,
        'body': json.dumps(f'Okay')
    }