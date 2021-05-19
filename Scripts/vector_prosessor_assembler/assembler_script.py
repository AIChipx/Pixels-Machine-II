# handles for input & output files
input_file = open("assembly.txt", "r")
output_file = open("machine_code.txt", "w")


# this dictionary translate assembly to binary
dict = {"R0":"0000","R1":"0001","R2":"0010", "R3":"0011",
        "ADD":"000", "MUL":"001"}

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
