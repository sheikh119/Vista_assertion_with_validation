import json
from pathlib import Path

_ROOT = Path(__file__).resolve().parent.parent
_DATA = _ROOT / "data"
with open(_DATA / "VERT.json") as f, open(_DATA / "VERT.jsonl", "w") as out:
    for line in f:
        line = line.strip()
        if not line: continue
        try:
            json.loads(line)  # validate it's proper JSON
            out.write(line + "\n")
        except:
            pass
print("Wrote data/VERT.jsonl (line-by-line mode)")

