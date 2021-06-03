from typing import List


class FilterOutTheGeese:
    """
    Codewars 8Kyu Question
    link : https://www.codewars.com/kata/57ee4a67108d3fd9eb0000e7
    """
    def __fixed_tests(self):
        def basic_test_cases():
            result = self.__goose_filter(["Mallard", "Hook Bill", "African", "Crested", "Pilgrim", "Toulouse", "Blue Swedish"])
            expected = ["Mallard", "Hook Bill", "Crested", "Blue Swedish"]
            print(f'my: {result}, solution: {expected}, result: {result == expected}')

            result = self.__goose_filter(["Mallard", "Barbary", "Hook Bill", "Blue Swedish", "Crested"])
            expected = ["Mallard", "Barbary", "Hook Bill", "Blue Swedish", "Crested"]
            print(f"my: {result}, solution: {expected}, result: {result == expected}")

            result = self.__goose_filter(["African", "Roman Tufted", "Toulouse", "Pilgrim", "Steinbacher"])
            expected = []
            print(f"my: {result}, solution: {expected}, result: {result == expected}")

        basic_test_cases()

    def __random_tests(self):
        from random import randint, random

        failData = []
        sol = lambda b: [e for e in b if e not in ["African", "Roman Tufted", "Toulouse", "Pilgrim", "Steinbacher"]]

        base = ["Mallard", "Roman Tufted", "Steinbacher", "Hook Bill", "African", "Crested", "Pilgrim", "Toulouse",
                "Blue Swedish", "Pippi", "Phoenix", "Tiamat", "Red Dragon", "Wyvern", "Manbat", "Kinto-kun", "Harpy",
                "Roc", "Celestial Eagle", "Infernal Hawk", "Hawkgirl", "Terran Battlecruiser", "Protoss Carrier",
                "Zerg Leviathan"]
        print("Random test case check")
        for _ in range(40):
            g = sorted(base, key=lambda a: random())[:randint(1, len(base) - 1)]
            expected = sol(g)
            def test_case():
                result = self.__goose_filter(g)
                equalCheck = (result == expected)
                print(f"my: {result}, solution: {expected}, result: {equalCheck}")
                if not equalCheck:
                    failData.append((result, expected))
                # test.assert_equals(goose_filter(g), expected)
            test_case()
            print(f"Failed Data is {failData}")

    geese = ["African", "Roman Tufted", "Toulouse", "Pilgrim", "Steinbacher"]

    @staticmethod  # my solution
    def __goose_filter(birds: List[str]):
        for bird in FilterOutTheGeese.geese:
            if bird in birds:
                birds.remove(bird)
        return birds

    def execute(self) -> bool:
        self.__fixed_tests()
        self.__random_tests()
        return True
