from typing import Optional

class Sentence:
    def __init__(self, lang: str, input: str, output: Optional[str] = None):
        self.lang = lang
        self.input = input
        self.output = output

    def is_valid_lang(self):
        if self.lang not in {"en", "ru"}:
            return False
        return True

    def correct(self):
        return "a sentence that may be correct"
