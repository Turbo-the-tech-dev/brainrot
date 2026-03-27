import json
import time
import random

def calculate_ohio_risk(load):
    """
    Calculates the Ohio risk based on neural load.
    Validation: load must be a numeric value between 0 and 100.
    """
    if not isinstance(load, (int, float)):
        raise ValueError("Input 'load' must be a numeric value.")
    if not (0 <= load <= 100):
        raise ValueError("Input 'load' must be between 0 and 100.")

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
    # SECURITY: Using telemetry.json to avoid overwriting legacy observations in deadpan-brainrot.json
    with open('telemetry.json', 'w') as f:
        json.dump(data, f, indent=2)
    print(">> [SUCCESS] telemetry.json updated for Terminal View.")
