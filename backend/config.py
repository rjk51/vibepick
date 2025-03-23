from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    SERPER_API_KEY: str
    GROQ_API_KEY: str
    MONGO_URI: str
    GEMINI_API_KEY: str
    VIBEPICK:str

    class Config:
        env_file = ".env"

settings = Settings()
