'''
Expressivity ideal of various NN architectures.
'''

import os
import subprocess
import time


TIMEOUT = 3600 # in seconds
N_VALS = [2, 3, 4, 5, 6]
R_VALS = [2, 3, 4, 5, 6]
D_VALS = [2, 3, 4, 5]

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SRC_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '..', 'src'))
OUT_DIR = os.path.join(SCRIPT_DIR, 'out')
os.makedirs(OUT_DIR, exist_ok=True)
LOG_FILE = os.path.join(OUT_DIR, f"expressivities_{TIMEOUT}.txt")

print(f"{'n':<3} | {'r':<3} | {'d':<3} | {'Status':<12} | {'Time (s)'}")
print("-" * 50)

with open(LOG_FILE, "w") as f:
    f.write(f"Timeout threshold: {TIMEOUT} seconds\n\n")

arch_count = 1
for d in D_VALS:
    for n in N_VALS:
        for r in R_VALS:
            cmd = ["M2", "--script", "eval_ideal.m2", str(n), str(r), str(d)]
            
            time0 = time.time()
            try:
                result = subprocess.run(
                    cmd, 
                    cwd=SRC_DIR, 
                    capture_output=True, 
                    text=True, 
                    timeout=TIMEOUT
                )
                elapsed = time.time() - time0
                
                if result.returncode == 0:
                    status = "Success"
                    time_str = f"{elapsed:.2f}"
                    
                    with open(LOG_FILE, "a") as f:
                        f.write(f"Architecture {arch_count}: n={n}, r={r}, d={d} [{time_str}s]\n")
                        f.write(result.stdout)
                        f.write("\n\n")
                else:
                    status = "Error"
                    time_str = f"{elapsed:.2f}"
                    with open(LOG_FILE, "a") as f:
                        f.write(f"Architecture {arch_count}: n={n}, r={r}, d={d} [ERROR]\n")
                        f.write(result.stderr)
                        f.write("\n\n")
                        
            except subprocess.TimeoutExpired:
                status = "Timeout"
                time_str = f"> {TIMEOUT}"
                with open(LOG_FILE, "a") as f:
                    f.write(f"Architecture {arch_count}: n={n}, r={r}, d={d} [TIMEOUT]\n")
                    f.write(f"Terminated after {TIMEOUT} seconds.\n\n")

            print(f"{n:<3} | {r:<3} | {d:<3} | {status:<12} | {time_str}")
            arch_count += 1