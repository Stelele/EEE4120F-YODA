"""
This module collects running statistics of the lut.cpp for generating varying numbers of random numbers

NOTE: script must be run for Python 3.5 or greater

"""

import os
import subprocess

if __name__ == "__main__":
    #compile c++ program
    os.system("make")

    # output results file name
    fileName = "testresult.txt"

    with open(fileName, 'w') as results:

        for i in range(10, 400, 40):
            results.write(f"Numbers Generated: {i}\n")

            for j in range(3):
                results.write(f"---------Iteration {j+1} ----------------\n")
                lutCall = subprocess.run(["./wire"], stdout=subprocess.PIPE, text=True, input=f"{i}")
                results.write(lutCall.stdout + "\n")

            
            results.write("\n===============================\n")

    # clean up unnecessary binary file
    os.system("make clean")

