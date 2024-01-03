# Memspect-cli
blazingly fast memory debugger in large codebases, a minimal more powerful version of valgrind.

                                            ```ROADMAP```

- [ ] LLVM Module Linking Integration

       - generate per module IR files together and parse functions and variables of program(s)
                     
       - build a module dependency graph for verification of dependencies (optional for now)
                     
       - implement caching mechanisms and other techniques for performance of parsing + adding LLVM optimization passes to improve performance (super optional)
                     
       - makes sure it can support multiple architectures and works the same on multiple os'es (optional / later)


 - [ ] Advanced Points-to Analysis
       
       - design and implement point-to analysis for global by analyzing the LLVM IR code of global variables and determine their points-to relationships using Steensgaard's algorithm

       - extend the point-to analysis to include heap memory allocations by tracking pointers to heap-allocated memory and determine their potential destinations using the same algorithm.

       - aim to determine precise points-to relationships for global variables with varying storage classes and linkage

       - do the same with local variables within each function and consider variable scoping rules and the impact of control flow on points-to relationships using Andersen's algorithm.
 
       - build a constraint graph by collecting all constraints of stack and heap variables from each function, parameters and return values for each call instruction. ( Optional - Perform Context Sensitive Analysis for more precision )

       - use a compressed bloom filter // sparse bit vector to initialize a point-to set for each memory object for efficient set operations.
      

- [ ] Control Flow Graph Generation


      - implement selective pruning strategies during reachability analysis
 
      - perform function-level reachabilty analysis through BFS traversal of initial call graph and prune nodes unreachable from program entry
    
      - add tests to verify the effectiveness of the selective pruning strategies.

      - review existing techniques for constructing CFGs using LLVM IR and plan a strategy for constructing the CFG based on the constraints and points-to information obtained from previous phase.

      - consider the influence of context sensitivity on the precision of the CFG - determine if all possible calls based on points-to Information can be verified on a smaller example as well as generally on a bigger codebase.
    
      - evaluate regularly to ensure that the constructed CFG is both precise and complete. document any discrepancies or missing connections in the CFG.

      - create CFG nodes corresponding to functions, basic blocks, and instructions from the data structure and utilize the constraints collected from previous phase to establish edges between CFG nodes

      - ensure that nodes accurately represent the control flow structure of the program and consider data and control flow constraints for accurate edge construction.

      - improve inter-procedural control flow graph generation for each function from the resulting call graph and per-function IR, collect both definite and possible definitions of variables at each instruction of every reachable function using pointer aliasing

      - adding mechanisms to dynamically adjust the call graph based on observed runtime behavior ( dynamic call graph refinement )

      - include support for exception handling and develop tests for enhanced control flow graph generation to validate the accurate representation of control flow, especially during exception handling.
      

- [ ]  Precise Data Flow Analysis
   

      - based on the inter-procedural control flow graph, compute inter-procedural data dependence by adding transitive edges (actual / formal parameters linkage) among inter-procedural data dependence graphs as referenced in the classical inter-procedural slicing.

      - compute reaching definitions using classical fixed-point iterative data flow analysis and dynamically compute transitive edges in the data dependence graph to build build inter-procedural data dependence graphs (DDGs). write tests to ensure adaptability to different code scenarios.
    
      - introduce a progressive slicing approach to focus on relevant portions and develop tests to validate focus and efficiency.

      - enhance data dependence graph construction with a precise alias analysis and advanced points-to analysis for improving precision on data dependence. develop tests for precise data dependence collection to validate accuracy in the presence of pointer aliasing.
