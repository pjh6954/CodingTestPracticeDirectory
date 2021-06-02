# from Kyu8 import TheWideMouthedFrog
import os
import execute8kyu


def file_execute_kyu_and_filename(kyuNumber, fileList):
    # print(f"{kyuNumber}, {fileList}")
    if len(fileList) == 0:
        print("There is no file list. Please retry.")
        get_kyu_type()
        return
    print("**** File List ****")
    for file in fileList:
        print(f"- {file}")
    print("What kind of file you proceed?")
    inputdata = input("if you want go back, please insert \"back\" or \"b\": ")
    # print(f"Check input data : {inputdata}")
    if inputdata.lower() == "b" or inputdata.lower() == "back":
        get_kyu_type()
    elif inputdata in fileList:
        execute8kyu.execute8kyu(inputdata)
    else:
        print("Please retry.")
        file_execute_kyu_and_filename(kyuNumber, fileList)


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


def get_kyu_type():
    """
        어떤 kyu 를 불러서 이용할지 사용자에게 묻고 해당 값에 따라 다음 플로우로 넘어가서 함수 실행하는 함수.
    """
    print("What kind of kyu did you test?")
    inputData = input("please insert number 1 to 8, if you end this process, insert \"exit\": ")
    if inputData.isnumeric():
        inputData = int(inputData)
        if inputData == 8:
            eight_kyu_proceed()
        else:
            print("There is no that kind of kyu")
            get_kyu_type()
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
