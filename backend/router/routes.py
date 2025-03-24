from fastapi import APIRouter,HTTPException
from pydantic import BaseModel
from db.db import search_mongo
from service.requestModel import nebiusai
router = APIRouter()

@router.get("/hello")
def say_hello():
    return {"message": "Hello from another route!"}
class TextInput(BaseModel):
    text: str
    mood:str
    
@router.post('/moviesrecommend')
def recommend_movies(input: TextInput):
    try:
        results = search_mongo(input.text)
        modelOutput = nebiusai(results, input.mood)
        return {"message": modelOutput}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))