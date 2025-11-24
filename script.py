import json
with open("VERT.json") as f, open("VERT.jsonl","w") as out:
    for line in f:
        line = line.strip()
        if not line: continue
        try:
            json.loads(line)  # validate it's proper JSON
            out.write(line + "\n")
        except:
            pass
print("Wrote VERT.jsonl (line-by-line mode)")

