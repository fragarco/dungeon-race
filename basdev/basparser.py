from __future__ import print_function
import sys
import os
import re

def print_help():
    print("")
    print("-------------------------------------------------------------")
    print("AMSTRAD CPC BASIC PARSER")
    print("-------------------------------------------------------------")
    print("Utility to parser a pseudo Locomotive .BAS file adding line")
    print("numbers and replacing ::label by equivalent line numbers")
    print("in GOTO, GOSUB or IF staments.")
    print("This utility also removes lines that start with ' symbol")
    print("and strips spaces at the beginning or end of each line.")
    print("")
    print("USAGE: basparser [INPUT FILE] [OUTPUT FILE] [LINE INCREMENT]")
    print("")
    print("For example: basparser MYFILE.BAS CPCFILE.BAS 10")
    print("will generate CPCFILE.BAS with lines increasing by 10.")
    print("-------------------------------------------------------------")
    print("")

def parse_input(inputfile, increment):
    lines = []
    labels = {}
    linenum = increment
    with open(inputfile, 'r') as f:
        inputline = 0
        for line in f:
            l = line.strip()
            inputline = inputline + 1
            if len(l) > 0 and l[0] != "'":
                if len(l) > 2 and l[0:2] == '::':
                    # label used by GOSUB, GOTO or IF to jump there
                    if l in labels:
                        print("[ Line", inputline, "] ERROR: label", l, "was used previously")
                        sys.exit(1)
                    labels[l] = str(linenum)
                else:
                    l = str(linenum) + ' ' + l
                    lines.append((inputline, l))
                    linenum = linenum + increment
    return lines, labels

def replace_labels(code, labels):
    output = []
    label_pattern = re.compile("(::[A-Za-z0-9_-]*)")
    for scrn, l in code:
        toreplace = label_pattern.findall(l)
        for label in toreplace:
            if label in labels:
                l = l.replace(label, labels[label])
            else:
                print("[ Line", scrn, "] ERROR: uknown label")
                print(">", l)
                sys.exit(1)
        output.append(l + "\r\n")
    return output

def save_output(output, code):
    with open(output, 'w') as f:
        f.writelines(code)

def parse(argv):
    if len(argv) < 4:
        print_help()    
        return 1

    _, input, output, lineinc = sys.argv
    lineinc = int(lineinc)

    if not os.path.isfile(input):
        print("BASPARSER ERROR: cannot access input file", input)
        return 1

    if lineinc < 1:
        print("BASPARSER ERROR: line increment must be a number equal or greater than 1.")
        return 1
    
    code, labels = parse_input(input, lineinc)
    if len(code) == 0:
        print("BASPARSER ERROR: input file couldn't be read or accessed.")
        return 1

    code = replace_labels(code, labels)
    save_output(output, code)
    print("BASPARSER DONE: output saved in file", output)
    return 0

if __name__ == "__main__":
    sys.exit(parse(sys.argv))
