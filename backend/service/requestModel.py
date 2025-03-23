import os
from openai import OpenAI
from config import settings

client = OpenAI(
    base_url="https://api.studio.nebius.com/v1/",
    api_key=settings.VIBEPICK
)
#google/gemma-2-9b-it

completion = client.chat.completions.create(
  model="google/gemma-2-9b-it",
  messages=[
    {
        "role": "user",
        "content": """Hello!"""
    }
  ],
  temperature=0.6
)

print(completion.to_json())
    



