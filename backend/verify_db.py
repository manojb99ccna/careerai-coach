from sqlalchemy import inspect
from app.database import engine
from app.models import Base, UserStudyMaterialProgress, UserQuizAttempt

inspector = inspect(engine)
tables = inspector.get_table_names()

print("Tables in database:")
for table in tables:
    print(f"- {table}")

required_tables = ["user_study_material_progress", "user_quiz_attempts"]
missing = [t for t in required_tables if t not in tables]

if missing:
    print(f"\nMissing tables: {missing}")
    # Try to create them
    print("Attempting to create missing tables...")
    Base.metadata.create_all(bind=engine)
    print("Tables created.")
else:
    print("\nAll required tables present.")
