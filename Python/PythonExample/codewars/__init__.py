# from Kyu8 import TheWideMouthedFrog
import os
# https://www.debugcn.com/ko/article/3518817.html
# TypeError: 'type' object is not subscriptable 문제 해결용
from typing import List
import execute8kyu


def file_execute_kyu_and_filename(kyuNumber: int, fileList: List[str]):
    # print(f"{kyuNumber}, {fileList}")
    if len(fileList) == 0:
        print("There is no file list. Please retry.")
        get_kyu_type()
        return
    print("\n\n******** File List ********")
    for file in fileList:
        print(f"- {file}")
    print("What kind of file you proceed?")
    inputdata = input("if you want go back, please insert \"back\" or \"b\": ")
    # print(f"Check input data : {inputdata}")
    print("\n\n------ Please Wait... -----\n\n")
    if inputdata.lower() == "b" or inputdata.lower() == "back":
        get_kyu_type()
        return  # don't need... maybe
    else:
        if kyuNumber == 8:
            if inputdata in fileList:
                if execute8kyu.execute8kyu(inputdata):
                    print(f"\n\n------ {inputdata} is executed ------")
                else:
                    print("Not Proceed this file. Please retry.")
            else:
                print(f"Wrong file name : {inputdata}. Please retry")
        else:
            print("Please retry.")
        file_execute_kyu_and_filename(kyuNumber, fileList)

def kyu_proceed(kyuNum: int):
    def retry():
        print("there is no exist kyu. please choose new kyu")
        print("\n\n------ Please Wait... -----\n\n")
        get_kyu_type()

    try:
        name = str(f"./Kyu{kyuNum}/")
        if not os.path.exists(name):
            retry()
        else:
            filenames = os.listdir(name)
            # print(f"CHECK Filenames : {filenames}")
            tempFilesArr = []
            for filename in filenames:
                ext = os.path.splitext(filename)[-1]
                # print(f"EXT : {ext}")
                if ext == ".py":
                    tempFilesArr.append(os.path.splitext(filename)[0])
                    # pass
            if len(tempFilesArr) != 0:
                file_execute_kyu_and_filename(kyuNum, tempFilesArr)
            else:
                retry()

    except PermissionError:
        print("ERROR!")
        pass
"""
def eight_kyu_proceed():
    # inputdata = input("What kind of function you want test?: ")
    try:
        filenames = os.listdir("./Kyu8/")
        # print(f"CHECK Filenames : {filenames}")
        tempFilesArr = []
        for filename in filenames:
            ext = os.path.splitext(filename)[-1]
            # print(f"EXT : {ext}")
            if ext == ".py":
                tempFilesArr.append(os.path.splitext(filename)[0])
                # pass

        if len(tempFilesArr) != 0:
            file_execute_kyu_and_filename(8, tempFilesArr)
        else:
            print("there is no file. please choose new kyu")
            get_kyu_type()

    except PermissionError:
        print("ERROR!")
        pass
"""

def get_kyu_type():
    """
        어떤 kyu 를 불러서 이용할지 사용자에게 묻고 해당 값에 따라 다음 플로우로 넘어가서 함수 실행하는 함수.
    """
    print("What kind of kyu did you test?")
    inputData = input("please insert number 1 to 8, if you end this process, insert \"exit\": ")
    if inputData.isnumeric():
        inputData = int(inputData)
        kyu_proceed(inputData)
        """
        if inputData == 8:
            eight_kyu_proceed()
        else:
            print("There is no that kind of kyu")
            get_kyu_type()
        """

    elif inputData.lower() == "exit":
        print("Thanks to use this test program.")
        exit(0)
    else:
        print("Please input number value")
        get_kyu_type()


if __name__ != '__main__':
    pass
else:
    print(f"Chek name : {__name__}")
    get_kyu_type()
