
import sys
from pathlib import Path
# Add current directory to path so we can import app
sys.path.append(str(Path(__file__).parent))

from app.database import SessionLocal
from app import models

def check_users():
    db = SessionLocal()
    try:
        users = db.query(models.User).all()
        print(f"Total users: {len(users)}")
        for user in users:
            print(f"User ID: {user.id}, Email: {user.email}")
        
        user_1 = db.query(models.User).filter(models.User.id == 1).first()
        if user_1:
            print("User with ID 1 exists.")
        else:
            print("User with ID 1 DOES NOT exist.")
            # Create user 1 if missing for testing purposes
            new_user = models.User(
                email="test@example.com",
                hashed_password="hashedpassword123", # Dummy hash
                full_name="Test User",
                is_active=True
            )
            # Try to set ID explicitly if possible, or just add and see
            # SQLAlchemy might ignore id if autoincrement
            # But usually we rely on auto-increment.
            # If the table is empty, it should start at 1.
            # If not empty and 1 is missing, we might need to force it or just use the existing user.
            
            db.add(new_user)
            db.commit()
            db.refresh(new_user)
            print(f"Created new user with ID: {new_user.id}")

    except Exception as e:
        print(f"Error: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    check_users()
