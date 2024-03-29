import boto3
import json
import os

table_name = os.environ["SCHEDULED_TASK_TABLE_NAME"]

session = boto3.Session(region_name=os.environ['REGION'])
dynamodb_client = session.client('dynamodb')
scan_limit = 100

def lambda_handler(event, context):
    global scan_limit

    try:
        scan_params = {
            'TableName': table_name
        }

        if event['queryStringParameters'] is not None:
            scan_limit = int(event["queryStringParameters"].get('scanLimit', 100))
            scan_params['Limit'] = scan_limit

            pagination_token = event['queryStringParameters'].get('paginationToken')
            if pagination_token:
                scan_params['ExclusiveStartKey'] = { 'task_id': { 'S': pagination_token } }

        dynamodb_response = dynamodb_client.scan(**scan_params)
        print(f'Scan response: {dynamodb_response}')

        response_data = {
            'items': dynamodb_response['Items']
        }
        
        last_evaluated_key = dynamodb_response.get('LastEvaluatedKey')
        if last_evaluated_key:
            response_data['LastEvaluatedKey'] = last_evaluated_key

        return {
          'statusCode': 200,
          'body': json.dumps(response_data)
        }
    except Exception as e:
        print(f'ERROR: {e}')
        return {
            'statusCode': 500,
            'body': { 'Error': f'Internal server error: {e}'}
        }