# Background

Random numbers have numerous uses in computing. 
From simulations (Monte Carlo), cryptography to sampling large parameter spaces, 
there are many instances in which we would like to have seemingly random behavior being 
present in our system. However, whilst true random number generators do exist, they are rarely 
used in computing due to their underlying reliance on some physical process making them highly 
system dependent. As such, pseudorandom number generators are often used due to the wider applicability 
and significantly faster times [1]. Having said this, generating numerous high quality random numbers can 
prove to be quite a resource intensive process, as such, hardware accelerated implementations will become 
inevitable [2]. Regarding this aspect, FPGAs prove to be the best candidates when it comes to generating 
numerous random numbers at once due to their inherent parallelism and use of bitwise operations [2][3]. 

# File Explanation

This repository contains two key things, the Verilog project that can be loaded into Vivado by loading the 
[EEE4120F-YODA.xpr](EEE4120F-YODA.xpr) project. Aside from this, a C++ golden measure program is also included
that can be located in the [golden_measure](golden_measure) folder. 


# References

[1] I. Foster, “Random Numbers,” 1995. [Online]. Available: https://www.mcs.anl.gov/~itf/dbpp/text/node116.html. [Accessed 25 May 2021]. 

[2] R. Justin, B. K. Mathew and S. Abe, “FPGA Implementation of High Quality Random Number Generator Using LUT Based Shift Registers,” Procedia Technology, vol. 24, pp. 1155-1162, 2016.  

[3] D. B. Thomas and W. Luk, “The lut-sr family of uniform random numbergenerators for fpga architectures,”IEEE transactions on very large scaleintegration (vlsi) systems, vol. 21, no. 4, pp. 761–770, 2012.