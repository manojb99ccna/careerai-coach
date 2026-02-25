
import sys
from pathlib import Path
# Add current directory to path so we can import app
sys.path.append(str(Path(__file__).parent))

from app.database import SessionLocal, engine
from sqlalchemy import text

def update_schema():
    db = SessionLocal()
    try:
        # Check if column exists
        result = db.execute(text("SHOW COLUMNS FROM master_milestones LIKE 'is_content_generated'"))
        column = result.fetchone()
        
        if not column:
            print("Adding is_content_generated column to master_milestones table...")
            db.execute(text("ALTER TABLE master_milestones ADD COLUMN is_content_generated BOOLEAN NOT NULL DEFAULT 0"))
            db.commit()
            print("Column added successfully.")
        else:
            print("Column is_content_generated already exists.")

    except Exception as e:
        print(f"Error: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    update_schema()
