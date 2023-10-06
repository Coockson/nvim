import boto3
import json
import subprocess
import argparse
import os

bedrock = boto3.client(
    "bedrock-runtime",
    aws_access_key_id="AKIAVLTH7O725FV6KDWJ",
    aws_secret_access_key="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",
    region_name="us-east-1",
)

parser = argparse.ArgumentParser(
    prog="CommitGenerator",
    description="What the program does",
    epilog="Text at the bottom of help",
)

parser.add_argument("diff", type=str, help="an integer for the accumulator")

args = parser.parse_args()


def commit_message():
    path = args.diff[0][:-1]
    os.chdir(os.path.join(os.path.abspath(path)))
    git_diff = subprocess.run(["git", "diff"], capture_output=True, text=True)
    #     print(git_diff.stdout)
    prompt = f"""
    \n\nHuman: Create a git commit message to the git diff below using conventional commit convention. Dont think outloud, just return the message.
    Description should be as simple as possible
    {git_diff.stdout}
    \n\nAssistant:"""
    body = json.dumps(
        {
            "prompt": prompt,
            "max_tokens_to_sample": 200,
            "temperature": 0.9,
            "stop_sequences": ["\n\nHuman:"],
        }
    )

    modelId = "anthropic.claude-v2"
    accept = "application/json"
    contentType = "application/json"

    response = bedrock.invoke_model(
        body=body, modelId=modelId, accept=accept, contentType=contentType
    )

    response_body = json.loads(response.get("body").read())

    return response_body["completion"]


if __name__ == "__main__":
    result = commit_message()
    print(result)
