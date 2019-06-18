import json
import datetime
import time

class my_number:
    def __init__(self, number):
        self.number = number
        self.date_of_creation = datetime.datetime.now()

if __name__ == "__main__":
    n_1 = my_number(1)
    n_2 = my_number(2)
    n_3 = my_number(3)

    my_list = []
    my_list.append(n_1.__dict__)
    my_list.append(n_2.__dict__)
    my_list.append(n_3.__dict__)

    for i in range(len(my_list)):
        print(f"Variable \"my_list[i]['date_of_creation']\": \"{my_list[i]['date_of_creation']}\"")
        print(f"Variable \"my_list[i]['number']\": \"{my_list[i]['number']}\"")
