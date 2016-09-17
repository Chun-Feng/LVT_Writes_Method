# LVT_Writes_Method
/////////////////////////////////////////////////////////////////////////////////////

"Live_Value_Table (LVT-based) techniques designs_descriptions"

First, replicating BRAMs to support multiple reads.

Replication is widely adopted technique to increase read ports. 

And, in output part, it can using multiplexor to choose which one of read port. 

Second, using register table (LVT) to track the correct Block RAMs that store the latest data of an address.

General multi-port memory needs to support multiple reads and writes ports simultaneously.

The LVT techniques combines the method of Replication and LVT to support mRnW (m reads and n writes)

** LVT-write **

The multiple writes are handled by the LVT table, while the multiple reads can be serviced by the duplicate BRAMs.

So, each one of BRAMs using m (read ports variety) building block to compose.

///////////////////////////////////////////////////////////////////////////////////

So, the "LVT-based techniques" advantage and dis-advantages in below:


Pros: Low cost of memory resources.

Cons: frequency (speed) significant decrease, and complexity routing.


///////////////////////////////////////////////////////////////////////////////////

Storage Cost Ratio = (D_total) / (D_actual).

In "LVT-based techniques", the cost ratio = (n*m) / 1 = n * m. 

(In general case - mRnW Multi-ported Memory Module)


///////////////////////////////////////////////////////////////////////////////////

Provide & Connection author "Chun-Feng Neil Chen"

Email: apple51314520@gmail.com 

Other Email: chunfeng8204@gmail.com


If you have anything problem of multi-ported memory designs,

you could send by email to me or leave issues in github.


When I saw it, I'll as soon as possible to resolve problem.

Thanks!!!

//////////////////////////////////////////////////////////////////////////////////////

First, saw "README.md" file; second, saw "Memory_design" file.
