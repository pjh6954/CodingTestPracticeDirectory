import re


class TheWideMouthedFrog:
    """
    Codewars 8Kyu Question.
    link : https://www.codewars.com/kata/57ec8bd8f670e9a47a000f89
    """
    # __privateTestCase = []

    def __basic_test_cases(self):
        testcase = ["toucan", "ant bear", "alligator"]
        for element in testcase:
            sol = self.__mouth_size_sol(element)
            mysol = self.__mouth_size(element)
            print(f"my: {mysol}, solution: {sol}, result: {sol == mysol}")

    def __random_test_cases(self):
        from random import randint, sample
        print("Random test cases check")
        for i in range(40):
            animal = "".join([letter.upper() if randint(0, 1) else letter for letter in sample(
                ['alligator', 'ant bear', 'toucan', 'tiger', 'lion', 'giraffe', 'longer than an alli'], 1)[0]])

            def test_case():
                sol = self.__mouth_size_sol(animal)
                mysol = self.__mouth_size(animal)
                print(f"my: {mysol}, solution: {sol}, result: {sol == mysol}")
            test_case()

    @staticmethod
    def __mouth_size(animal: str) -> str:
        return "wide" if not animal or str(animal).lower() != "alligator" else "small"

    @staticmethod
    def __mouth_size_sol(animal):
        return 'small' if re.match(animal, 'alligator', re.IGNORECASE) else 'wide'

    def execute(self):
        print(f"result : {self.__mouth_size('TEST! animal')}")
        self.__basic_test_cases()
        self.__random_test_cases()
