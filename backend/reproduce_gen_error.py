
import json
import urllib.request
import urllib.error
from datetime import datetime, timedelta
from jose import jwt
import time

SECRET_KEY = "careerai-secret-0001"
ALGORITHM = "HS256"

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=30)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

token = create_access_token({"sub": "1"})
print(f"Token: {token}")

url = "http://localhost:8001/training/plan/generate"
payload = {
    "role_id": 1,
    "experience_level_id": 1,
    "skills": "python, react"
}
data = json.dumps(payload).encode("utf-8")

req = urllib.request.Request(url, data=data, method="POST")
req.add_header("Content-Type", "application/json")
req.add_header("Authorization", f"Bearer {token}")

print(f"Sending request to {url}...")
start_time = time.time()
try:
    # Increased timeout to 600s to match server
    with urllib.request.urlopen(req, timeout=600) as response:
        print(f"Success! Took {time.time() - start_time:.2f} seconds")
        response_data = response.read().decode("utf-8")
        plan = json.loads(response_data)
        
        print("\n--- Plan Summary ---")
        if plan.get("plan"):
            p = plan["plan"]
            print(f"Title: {p.get('title')}")
            print(f"Milestones: {len(p.get('milestones', []))}")
            
            for m in p.get('milestones', []):
                print(f"\nMilestone {m.get('milestone_number')}: {m.get('title')}")
                print(f"Description: {m.get('description')}")
                
                print("  Study Materials:")
                for sm in m.get('study_materials', []):
                    print(f"    - {sm.get('title')}")
                    print(f"      Short Desc: {sm.get('short_description')[:100]}...")
                    print(f"      Content Length: {len(sm.get('content', ''))}")
                
                print("  Quiz Questions:")
                for q in m.get('quiz_questions', []):
                    print(f"    - {q.get('text')[:50]}... (Correct: {q.get('correct_answer')})")
                    opts = q.get('options', [])
                    # Options might be a list of strings if processed by schema, or dict/json string if raw
                    print(f"      Options: {opts}")

        else:
            print("Plan created but empty response structure?")
            print(response_data[:500])

except urllib.error.HTTPError as e:
    print(f"HTTP Error: {e.code}")
    error_body = e.read().decode("utf-8")
    print(f"Body: {error_body}")
except Exception as e:
    print(f"Error: {e}")
