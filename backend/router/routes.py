from fastapi import APIRouter,HTTPException
from pydantic import BaseModel
from db.db import search_mongo
router = APIRouter()

@router.get("/hello")
def say_hello():
    return {"message": "Hello from another route!"}
class TextInput(BaseModel):
    text: str
    
@router.post('/moviesrecommend')
def recommend_movies(input: TextInput):
    try:
        '''
        search the query in database and return the result -> done
        give these results to vibepick
        get the response from vibepick
        return the response to the user
        '''
        results = search_mongo(input.text)
        return {"message": results}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))