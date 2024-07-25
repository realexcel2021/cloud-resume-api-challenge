import json
import boto3


def cors_headers():
    return {
        'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'OPTIONS,POST,GET,HEAD,PUT,DELETE,PATCH'
    }

def responseFormat(Item):
   return {
      "resume" : Item["resume"],
      "basics": {
         "location": Item["basics"]["location"],
         "name": Item["basics"]["name"],
         "phone": Item["basics"]["phone"],
         "summary": Item["basics"]["summary"],
      },
      "workExperience": Item["workExperience"]
   }

def lambda_handler(event: any, context: any):
    body = event.get('body')
    json_param = json.loads(body)

    count = 0
    result = ""
    status_code = 500

    tableName = "records"
    records_table = boto3.resource('dynamodb', endpoint_url="http://dynamo-local:8000/").Table(tableName)

    response = records_table.get_item(Key={
       "resume": "sheriff_resume"
    })

    if "Item" in response:
        try:
            item = response["Item"]
            status_code = 200
            result = responseFormat(Item=item)
        except Exception as error:
            print("failed to get db table " + str(error))
            result = str(error)

    return {
        "statusCode": status_code,
        "body": json.dumps(result)
    }
