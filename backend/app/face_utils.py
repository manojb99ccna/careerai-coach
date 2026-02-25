from typing import List, Optional

import numpy as np


def serialize_encoding(encoding: List[float]) -> str:
    array = np.array(encoding, dtype=np.float32)
    return ",".join(str(x) for x in array.tolist())


def deserialize_encoding(serialized: str) -> Optional[np.ndarray]:
    try:
        # Check if serialized is just a string description like "dummy_encoding"
        if not serialized or "," not in serialized:
             # Try to see if it's a valid float (single value) but unlikely for face encoding
             # Just fail if it doesn't look like a list
             return None
        values = [float(x) for x in serialized.split(",") if x.strip()]
        if not values:
            return None
        return np.array(values, dtype=np.float32)
    except (ValueError, AttributeError):
        return None


def calculate_distance(encoding1: List[float], encoding2_serialized: str) -> float:
    array1 = np.array(encoding1, dtype=np.float32)
    array2 = deserialize_encoding(encoding2_serialized)
    
    if array2 is None:
        return 100.0  # Return a large distance for invalid encodings

    if array1.shape != array2.shape:
        min_len = min(array1.shape[0], array2.shape[0])
        if min_len == 0:
            return 100.0
        array1 = array1[:min_len]
        array2 = array2[:min_len]
        
    return float(np.linalg.norm(array1 - array2))
