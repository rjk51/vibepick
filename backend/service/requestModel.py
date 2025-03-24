import os
from openai import OpenAI
from config import settings

client = OpenAI(
    base_url="https://api.studio.nebius.com/v1/",
    api_key=settings.VIBEPICK
)
#google/gemma-2-9b-it
def nebiusai(query, genre):
    prompt = f"""
    You are a movie recommendation assistant. Below is a list of movies with their genres. 
    Recommend movies that match the requested genre: '{genre}'.
    
    Movie List:
    {query}
    
    Analyze each movie's genre and select only those that match or are very close to the requested genre.
    It's your task to suggest me 5 movies that are relevant to the requested genre even if not then also 5 movies.
    Return your recommendations in JSON format with the following structure for each movie:
    {{
        "title": "movie title",
        "genre": "movie genre",
        "poster_url": "image url"
        "IMDB_rating": "movie rating",
        "overview": "movie overview"
    }}
    
    Only include movies that are relevant to the requested genre.
    """
    
    completion = client.chat.completions.create(
        model="google/gemma-2-9b-it",
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0.6
    )

    print(completion.to_json())
    return completion.to_json()  
    



