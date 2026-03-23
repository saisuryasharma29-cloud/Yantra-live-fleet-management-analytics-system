import json
import boto3
import pandas as pd
from io import StringIO

s3 = boto3.client('s3')

def lambda_handler(event, context):
    
    # Extract bucket and file info from event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']
    
    print(f"Processing file: {file_key} from bucket: {bucket_name}")
    
    # Read file from S3
    response = s3.get_object(Bucket=bucket_name, Key=file_key)
    file_content = response['Body'].read().decode('utf-8')
    
    # Load into pandas dataframe
    df = pd.read_csv(StringIO(file_content))
    
    # Fleet analytics calculations
    df['utilization_percentage'] = (
        df['worked_hours'] /
        (df['worked_hours'] + df['idle_hours'])
    ) * 100
    
    df['idle_ratio'] = (
        df['idle_hours'] /
        (df['worked_hours'] + df['idle_hours'])
    ) * 100
    
    # Aggregate equipment-level insights
    summary_df = df.groupby('equipment_id').agg({
        'worked_hours': 'sum',
        'idle_hours': 'sum',
        'fuel_consumed': 'sum'
    }).reset_index()
    
    # Save processed file
    output_buffer = StringIO()
    summary_df.to_csv(output_buffer, index=False)
    
    output_key = f"processed/summary_{file_key}"
    
    s3.put_object(
        Bucket=bucket_name,
        Key=output_key,
        Body=output_buffer.getvalue()
    )
    
    print(f"Processed file saved to: {output_key}")
    
    return {
        'statusCode': 200,
        'body': json.dumps('Fleet analytics processing completed successfully!')
    }
