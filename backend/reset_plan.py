
import sys
from pathlib import Path
# Add current directory to path so we can import app
sys.path.append(str(Path(__file__).parent))

from app.database import SessionLocal
from app import models

def reset_all_plans(role_id=1, level_id=1):
    db = SessionLocal()
    try:
        print(f"Deleting user plans for role {role_id}, level {level_id}...")
        
        # Find the global training plan
        tp = db.query(models.TrainingPlan).filter(
            models.TrainingPlan.role_id == role_id,
            models.TrainingPlan.experience_level_id == level_id
        ).first()
        
        if tp:
            print(f"Found TrainingPlan ID: {tp.id}")
            
            # 1. Find all UserTrainingPlans for this global plan
            user_plans = db.query(models.UserTrainingPlan).filter(models.UserTrainingPlan.training_plan_id == tp.id).all()
            user_plan_ids = [up.id for up in user_plans]
            
            if user_plan_ids:
                print(f"Found UserTrainingPlans: {user_plan_ids}")
                
                # 2. Delete UserQuizAttempt (linked to UserMilestoneProgress)
                # Need to find UserMilestoneProgress first
                umps = db.query(models.UserMilestoneProgress).filter(models.UserMilestoneProgress.user_training_plan_id.in_(user_plan_ids)).all()
                ump_ids = [ump.id for ump in umps]
                
                if ump_ids:
                    print(f"Deleting UserQuizAttempts for {len(ump_ids)} progress records...")
                    db.query(models.UserQuizAttempt).filter(models.UserQuizAttempt.user_milestone_progress_id.in_(ump_ids)).delete(synchronize_session=False)
                    
                    print(f"Deleting UserStudyMaterialProgress for {len(ump_ids)} progress records...")
                    db.query(models.UserStudyMaterialProgress).filter(models.UserStudyMaterialProgress.user_milestone_progress_id.in_(ump_ids)).delete(synchronize_session=False)

                    print(f"Deleting UserMilestoneProgress records...")
                    db.query(models.UserMilestoneProgress).filter(models.UserMilestoneProgress.id.in_(ump_ids)).delete(synchronize_session=False)
                
                print(f"Deleting UserTrainingPlans...")
                db.query(models.UserTrainingPlan).filter(models.UserTrainingPlan.id.in_(user_plan_ids)).delete(synchronize_session=False)

            # 3. Now delete Master content
            milestones = db.query(models.MasterMilestone).filter(models.MasterMilestone.training_plan_id == tp.id).all()
            for m in milestones:
                print(f"Cleaning milestone {m.id}...")
                db.query(models.MasterStudyMaterial).filter(models.MasterStudyMaterial.master_milestone_id == m.id).delete(synchronize_session=False)
                db.query(models.MasterQuizQuestion).filter(models.MasterQuizQuestion.master_milestone_id == m.id).delete(synchronize_session=False)
                db.delete(m)
            
            print(f"Deleting TrainingPlan {tp.id}")
            db.delete(tp)
            db.commit()
            print("Reset complete.")
        else:
            print("No TrainingPlan found.")

    except Exception as e:
        print(f"Error: {e}")
        db.rollback()
        import traceback
        traceback.print_exc()
    finally:
        db.close()

if __name__ == "__main__":
    reset_all_plans()
