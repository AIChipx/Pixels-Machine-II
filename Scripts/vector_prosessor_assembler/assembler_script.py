# handles for input & output files
input_file = open("assembly.txt", "r")
output_file = open("machine_code.txt", "w")


# this dictionary translate assembly to binary
dict = {"R0":"0000","R1":"0001","R2":"0010", "R3":"0011",
        "R4":"0100","R5":"0101","R6":"0110","R7":"0111",
        "R8":"1000","R9":"1001","R10":"1010","R11":"1011",
        "R12":"1100","R13":"1101","R14":"1110","R15":"1111",
        "ADD":"000", "MUL":"001","MOV":"110","DPRO":"111",
        "LDR":"100","STR":"101","0":"0000","1":"0001",
        "2":"0010","3":"0011","4":"0100","5":"0101","6":"0110",
        "7":"0111","-1":"1001","-2":"1010","-3":"1011","-4":"1100",
        "-5":"1101","-6":"1110","-7":"1111"
        }

# this function will convert assembly code to binary
def assembler(x):
    strList = x.split()
    for l in strList:
        output_file.write(dict[l])
    output_file.write('\n')

        
# read file line by line
for content in input_file:
    assembler(content)
# close all files
input_file.close()
output_file.close()
