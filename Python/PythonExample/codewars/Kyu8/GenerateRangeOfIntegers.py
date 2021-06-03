import random


class GenerateRangeOfIntegers:
    """
    Codewars 8Kyu Question.
    link : https://www.codewars.com/kata/55eca815d0d20962e1000106/python
    """
    def __basic_test_case(self):
        testcase = [(1, 10, 1), (-10, 1, 1)]
        for element in testcase:
            mysol = self.__generate_range(element[0], element[1], element[2])
            sol = self.__initial_solution(element[0], element[1], element[2])
            print(f"my: {mysol}, solution: {sol}, result: {sol == mysol}")

    def __random_tests(self):
        print("Random test case check")
        failData = []

        def do_random_test():
            min = random.randint(0, 100)
            max = min + random.randint(0, 100)
            step = random.randint(1, max + 1)
            # self.__generate_range(min, max, step)
            # initial_solution(min, max, step)
            mysol = self.__generate_range(min, max, step)
            sol = self.__initial_solution(min, max, step)
            result = (sol == mysol)
            print(f"my: {mysol}, solution: {sol}, result: {result}")
            if not result:
                failData.append((mysol, sol))

        def run_random_tests():
            for i in range(100):
                do_random_test()
                # print(f"i: {i}")

        run_random_tests()
        print(f"Failed Data is {failData}")

    @staticmethod  # test case solution
    def __initial_solution(min, max, step):
        return list(range(min, max + 1, step))

    @staticmethod  # my solution
    def __generate_range(min, max, step):
        returnValue = [min]
        current = min
        while current <= max:
            current = current + step
            if current <= max:
                returnValue.append(current)
        return returnValue

    def execute(self) -> bool:
        self.__basic_test_case()
        self.__random_tests()
        return True
