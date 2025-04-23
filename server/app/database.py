from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Update to your NEON connection string
SQLALCHEMY_DATABASE_URL = "postgresql://neondb_owner:npg_un0XlFdLDQq9@ep-misty-wind-a17es9xa-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require"

# Set up the database engine
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"sslmode": "require"})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class for ORM models
Base = declarative_base()

# Dependency to get the DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
