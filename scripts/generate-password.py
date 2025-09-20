#!/usr/bin/env python
import random
import string

DICT_PATH = "/usr/share/dict/words"
SPECIALS = "!@#$%^&*()-_=+[]{};:,.<>?/"

def load_common_words(path=DICT_PATH, max_len=6):
    with open(path, "r") as f:
        # Keep alphabetic words only, max length 6, capitalize
        words = [w.strip().capitalize() for w in f if w.strip().isalpha() and len(w.strip()) <= max_len]
    return words

def generate_string(wordlist):
    words = random.sample(wordlist, 4)
    number = str(random.randint(1, 9999))
    special = random.choice(SPECIALS)
    items = words + [number, special]
    random.shuffle(items)
    return " ".join(items)

if __name__ == "__main__":
    wordlist = load_common_words()
    print(generate_string(wordlist))

