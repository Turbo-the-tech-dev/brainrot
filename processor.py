import json
import time
import random

def calculate_ohio_risk(load):
    """
    Calculates the Ohio Risk factor based on neural load.
    Ensures input is within safe bounds (0-100).
    """
    if not isinstance(load, (int, float)):
        raise ValueError("Neural load must be a numeric value.")
    if load < 0 or load > 100:
        raise ValueError("Neural load must be between 0 and 100.")
    # Logarithmic scaling for critical neural load
    return round((load ** 1.5) / 10, 2)

def generate_telemetry():
    status_options = ["RIZZ_STABLE", "FANUM_TAX_DETECTED", "OHIO_PEAKING", "SIGMA_ENFORCED"]
    
    telemetry = {
        "timestamp": int(time.time()),
        "neural_load": random.randint(70, 99),
        "status": random.choice(status_options),
        "velocity": "ABSOLUTE"
    }
    
    telemetry["risk_factor"] = calculate_ohio_risk(telemetry["neural_load"])
    return telemetry

if __name__ == "__main__":
    data = generate_telemetry()
    print(f">> [SYSTEM] Telemetry calculated: {data['status']}")
    # Use a separate file for telemetry to avoid overwriting existing data files
    with open('telemetry.json', 'w') as f:
        json.dump(data, f, indent=2)
    print(">> [SUCCESS] telemetry.json updated for Terminal View.")
