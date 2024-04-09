def points(char) -> int:
    if char in "AEIOULNRST":
        return 1
    elif char in "DG":
        return 2
    elif char in "BCMP":
        return 3
    elif char in "FHVWY":
        return 4
    elif char in "K":
        return 5
    elif char in "JX":
        return 8
    elif char in "QZ":
        return 10
    raise ValueError("Invalid character")

def score(word) -> int:
    word = word.upper()
    return sum([points(letter) for letter in word])
