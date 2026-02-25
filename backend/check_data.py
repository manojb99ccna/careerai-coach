
import sys
from pathlib import Path
# Add current directory to path so we can import app
sys.path.append(str(Path(__file__).parent))

from app.database import SessionLocal
from app import models

def check_data():
    db = SessionLocal()
    try:
        # Check User
        user_1 = db.query(models.User).filter(models.User.id == 1).first()
        if user_1:
            print(f"User 1 exists: {user_1.name} ({user_1.email})")
        else:
            print("User 1 DOES NOT exist. Creating...")
            new_user = models.User(
                id=1,
                name="Test User",
                email="test@example.com",
                phone="1234567890",
                face_encoding="dummy_encoding"
            )
            db.add(new_user)
            db.commit()
            print("User 1 created.")

        # Check Role
        role_1 = db.query(models.Role).filter(models.Role.id == 1).first()
        if role_1:
             print(f"Role 1 exists: {role_1.name}")
        else:
             print("Role 1 DOES NOT exist. Creating...")
             new_role = models.Role(id=1, name="Frontend Developer")
             db.add(new_role)
             db.commit()
             print("Role 1 created.")

        # Check Experience Level
        level_1 = db.query(models.ExperienceLevel).filter(models.ExperienceLevel.id == 1).first()
        if level_1:
             print(f"ExperienceLevel 1 exists: {level_1.name}")
        else:
             print("ExperienceLevel 1 DOES NOT exist. Creating...")
             new_level = models.ExperienceLevel(id=1, name="Junior")
             db.add(new_level)
             db.commit()
             print("ExperienceLevel 1 created.")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        db.close()

if __name__ == "__main__":
    check_data()
