import os
import json
import boto3
from botocore.exceptions import ClientError

def get_secret(secret_name, region_name):

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name="secretsmanager",
        region_name=region_name
    )

    try:
        # Fetch the secret
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
        # Parse the secret value
        secret = get_secret_value_response['SecretString']
        return json.loads(secret)
    except ClientError as e:
        # Handle the error (e.g., log it or raise an exception)
        raise e

