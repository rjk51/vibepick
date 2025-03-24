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
    You are a movie recommendation assistant. Below is a list of movies with the user's current mood. 
    Recommend movies that match the requested mood: '{genre}'.
    
    Movie List:
    {query}
    
    Analyze each movie's genre and select only those that match or are very close to the requested query and mood.
    It's your task to suggest exactly 5 movies that are relevant to the requested mood. If there are not enough matches, recommend other movies to complete the list of 5.
    
    Return your recommendations **only** as a JSON array with the following structure for each movie:
    [
        {{
            "title": "movie title",
            "genre": "movie genre",
            "poster_url": "image url",
            "IMDB_rating": "movie rating",
            "overview": "movie overview"
        }},
        ...
    ]
    
    **Important Instructions:**
    - Do **not** include any additional text, explanations, or markdown (e.g., no ```json markers, no introductory sentences).
    - Return **only** the JSON array (e.g., [{...}, {...}, ...]).
    - Ensure the JSON is valid and contains exactly 5 movies.
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
    



