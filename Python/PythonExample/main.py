# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.


# def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
#     print(f'Hi, {name}')  # Press ⌘F8 to toggle the breakpoint.


# Press the green button in the gutter to run the script.
# if __name__ == '__main__':
#     print_hi('PyCharm')

# See PyCharm help at https://www.jetbrains.com/help/pycharm/


# import codewars
# codewars.mouth_size("test")

def counting(num = int()):
    cnt = 0
    while True:
        if(num % 5) == 0:
            print(f"Check cnt : {cnt}, {num}, {num // 5}")
            cnt = cnt + (num // 5)
            break
        num = num - 3
        cnt += 1
        if num <= 0:
            break
    return cnt

print(f"test? {123}")
answer = counting(21)
print(answer)