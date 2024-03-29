from botocore.exceptions import ClientError
import json
import boto3
import os
import uuid

bucket_name = os.environ["SCHEDULED_TASK_BUCKET_NAME"]

session = boto3.Session(region_name=os.environ['REGION'])
s3_client = session.client('s3')

def lambda_handler(event, context):

    try:
        file_name = str(uuid.uuid4()) + '.txt'
        file_content = f'Content for {file_name} file'.encode("utf-8")

        s3_client.put_object(
            Bucket=bucket_name,
            Key=file_name, 
            Body=file_content
        )
    except ClientError as e:
        print(f'ERROR: {e}')
        return {
            'statusCode': 500,
            'body': { 'Error': f'Internal server error: {e}'}
        }

    print(f'File uploaded: {file_name}')
    return {
        'statusCode': 200,
        'body': { 'Message': 'Task successfully executed'}
    }