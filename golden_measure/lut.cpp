/*******************************************************************************
 * Program simulates the operations of the LUT-SR
 * Uniform random number generator. This particular
 * Implementation produces 32 bit output numbers
 * 
 * 
 * NOTE: rng class obtained from
 *  http://cas.ee.ic.ac.uk/people/dt10/research/thomas-12-lut-sr-journal.pdf
 * 
 * *******************************************************************************/

#include <iostream>
#include <vector>
#include <stdio.h>
#include <set>
#include <fstream>
#include "Timer.h"

int main(void)
{
    using namespace std;

    struct rng{

        static int LCG(uint32_t &s) // Simple LCG RNG
        { return (s=1664525UL*s+1013904223UL)>>16; }

        static void Permute(uint32_t &s, vector<int> &p)
        { for(int j=p.size();j>1;j--) swap(p[j-1],p[LCG(s)%j]); }

        int n, r, t, maxk; // rng parameters
        uint32_t s; // Seed for generator
        vector<set<int> > taps; // connections
        vector<int> cycle; // cycle through bits
        vector<int> perm; // output permutation
        int seedTap; // Entry point to cycle

        rng(int _n, int _r, int _t, int _maxk, uint32_t _s)
        : n(_n), r(_r), t(_t), maxk(_maxk), s(_s)
        , taps(n), cycle(n), perm(r), seedTap(0)
        { // Construct an rng using (n,r,t,maxk,s) tuple
            vector<int> outputs(r), len(r,0); int bit;
            // 1: Create cycle through bits for seed loading
            for(int i=0;i<r;i++){ cycle[i]=perm[i]=(i+1)%r; }

            outputs=perm; // current output of each fifo

            for(int i=r;i<n;i++){ // 2: Extend bit-wide FIFOs
                do{ bit=LCG(_s)%r; }while(len[bit]>=maxk);

                cycle[i]=i; swap(cycle[i], cycle[bit]);
                outputs[bit]=i; len[bit]++;
            }

            //output FIFO Sizes
            /*
            printf("FIFO Sizes\n");
            for(int i = 0; i < len.size(); i++)
            {
                printf("FIFO[%d]=%d\n",i,len[i]);
            }
            */

            for(int i=0;i<n;i++) // 3: Loading connections
            taps[i].insert(cycle[i]);

            for(int j=1;j<t;j++){ // 4: XOR connections
                Permute(_s, outputs);

                for(int i=0;i<r;i++){
                    taps[i].insert(outputs[i]);
                    if(taps[i].size()<taps[seedTap].size())
                    seedTap=i;
                }
            }
            Permute(_s, perm); // 5: Output permutation
        }

        void PrintConnections() const
        { // Dump transition function in "C" format
            for(int i=0;i<n;i++){
                // Create connections for load mode
                if(i==seedTap) printf("ns[%u]=m?s_in:(0", i);
                else printf("ns[%u]=m?cs[%u]:(0",i,cycle[i]);

                // Create XOR tree for RNG mode
                set<int>::iterator it=taps[i].begin();
                while(it!=taps[i].end()) printf("ˆcs[%u]",*it++);
                printf(");\n");
            }

            printf("s_out=cs[%u];\n", cycle[seedTap]);
            for(int i=0;i<r;i++) // output permutation
            printf("ro[%u]=ns[%u];\n", i, perm[i]);
        }

        pair<vector<int>,int> // returns (ro[0:r-1],s_out)
        Step(vector<int> &cs, int m, int s_in) const
        { // Advance state cs[0:n-1] using inputs (m,s_in)
            vector<int> ns(n, 0), ro(n);
            for(int i=0;i<n;i++){ // Do XOR tree and FIFOs
                if(m==0){ // RNG mode
                    std::set<int>::iterator it=taps[i].begin();
                    while(it!=taps[i].end()) ns[i] ^= cs[*it++];
                }else{ // load mode
                    ns[i]= (i==seedTap) ? s_in : cs[cycle[i]];
                } 
            }

            // capture permuted output signals
            int s_out=cs[cycle[seedTap]]; // output of load chain
            cs=ns; // "clock-edge", so FFs toggle
            for(int i=0;i<r;i++) ro[i]=cs[perm[i]];
            for(int i=r;i<n;i++) ro[i]=cs[i];
            return make_pair(ro,s_out);
        }
    };

    //rng(int _n, int _r, int _t, int _maxk, uint32_t _s)
    tic();
    rng random(1024,32, 5, 32, 0x1c48);
    int requestedNumbers;

    cout << "How many number do you want?: " << endl;
    cin >> requestedNumbers;

    vector<pair<vector<int>, int>> results;

    vector<int> startState(random.n,5);
    unsigned int startSeed = 0xD2E0CA;

    //randomly initialize start state with random numbers
    for(int i = 0; i < random.n; i++)
    {
        if(i == 0)
        {
            startState[i] = (1664525UL*startSeed+1013904223UL)>>16;
        }
        else
        {
            startState[i] = (1664525UL*startState[i - 1]+1013904223UL)>>16;
        }
    }
    printf("Initializing Time = %lg ms\n", (double)toc()/1e-3);

    //generate specified number of random numbers
    tic();
    results.push_back(make_pair(startState, startSeed));
    for(int num = 0; num < requestedNumbers; num++)
    {
        results.push_back(random.Step(results[num].first, 0, results[num].second));
    }
    printf("Processing Time = %lg ms\n", (double)toc()/1e-3);

    ofstream resultNums("gen_randout.txt");

    if(resultNums)
    {
        for(int i = 1; i <= requestedNumbers; i++)
        {
            resultNums << hex << results[i].second << endl;
        }
        resultNums.close();
    }

    return 0;
}