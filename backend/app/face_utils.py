from typing import List

import numpy as np


def serialize_encoding(encoding: List[float]) -> str:
    array = np.array(encoding, dtype=np.float32)
    return ",".join(str(x) for x in array.tolist())


def deserialize_encoding(serialized: str) -> np.ndarray:
    values = [float(x) for x in serialized.split(",") if x]
    return np.array(values, dtype=np.float32)


def calculate_distance(encoding1: List[float], encoding2_serialized: str) -> float:
    array1 = np.array(encoding1, dtype=np.float32)
    array2 = deserialize_encoding(encoding2_serialized)
    if array1.shape != array2.shape:
        min_len = min(array1.shape[0], array2.shape[0])
        array1 = array1[:min_len]
        array2 = array2[:min_len]
    return float(np.linalg.norm(array1 - array2))

