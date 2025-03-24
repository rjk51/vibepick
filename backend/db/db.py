from langchain.schema import Document
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from langchain_mongodb import MongoDBAtlasVectorSearch
from config import settings
from pymongo import MongoClient

def connect_to_mongo():
    try:
      client = MongoClient(settings.MONGO_URI)
      collection = client['mongoVector']['testvector']
      print("Connected to DB get set to use it")
      return collection
    except Exception as e:
      print(e)

def save_to_mongo():
    with open("movies.txt", "r") as file:
        content = file.read()

    movie_entries = content.strip().split("---")

    docs = []
    for entry in movie_entries:
        lines = entry.strip().split("\n")
        movie_dict = {}

        for line in lines:
            if ": " in line:  
                key, value = line.split(": ", 1)  
                movie_dict[key.lower()] = value  

        if "url" in movie_dict and "title" in movie_dict and "genre" in movie_dict:
            text = f"url: {movie_dict['url']}\ntitle: {movie_dict['title']}\ngenre: {movie_dict['genre']}\n"
            if "imdb_rating" in movie_dict:
                text += f"IMDB_Rating: {movie_dict['imdb_rating']}\n"
            if "overview" in movie_dict:
                text += f"overview: {movie_dict['overview']}\n"
            docs.append(Document(page_content=text, metadata={"title": movie_dict["title"]}))

    if not docs:
        print("No valid movie data found!")
        return
    text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=20)
    splits = text_splitter.split_documents(docs)

    embeddings = GoogleGenerativeAIEmbeddings(
        model="models/embedding-001",
        google_api_key=settings.GEMINI_API_KEY,
    )

    client = MongoClient(settings.MONGO_URI)
    collection = client["mongoVector"]["testvector"]
    collection.delete_many({})  

    MongoDBAtlasVectorSearch.from_documents(
        splits, embeddings, collection=collection, index_name="vectorSearch"
    )

    return "done"

def search_mongo(query):
    try:
        print("inside the function")
        print(query)
        embeddings = GoogleGenerativeAIEmbeddings(model="models/embedding-001",google_api_key=settings.GEMINI_API_KEY)
        client = MongoClient(settings.MONGO_URI)
        collection = client['mongoVector']['testvector']
        vectorStore = MongoDBAtlasVectorSearch(collection, embeddings, index_name="vector_index")
        docs = vectorStore.similarity_search(query,k=8)
        print("Vector Search Results:")
        print(len(docs))
        return docs
    except Exception as e:
        print("Database timeout or error:", str(e))