'''
esempio file: students.csv
name,score
Alice,78
Bob,55
Charlie,92
Diana,60
Eve,48

'''

# pipeline_generators.py

def extract_lines(filename):
    with open(filename) as f:
        next(f)  # skip header
        for line in f:
            yield line.strip()

def parse_lines(lines):
    for line in lines:
        name, score = line.split(",")
        yield {"name": name, "score": int(score)}

def filter_passed(records, threshold=60):
    for record in records:
        if record["score"] >= threshold:
            yield record

def load(records):
    for record in records:
        print(f"{record['name']} passed with score {record['score']}")

if __name__ == "__main__":
    filename = "students.csv"

    lines = extract_lines(filename)
    parsed = parse_lines(lines)
    passed = filter_passed(parsed, threshold=60)
    load(passed)
