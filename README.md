# The Classroom Object-Oriented Language

### Compiler Course Project - University of Tehran (Feb - Aug 2020)

based on [Stanford CS143 course](http://openclassroom.stanford.edu/MainFolder/DocumentPage.php?course=Compilers&doc=docs/slides.html)

In this project, I wrote a compiler for COOL language in main four phases. Lexer, Parser, Semantic Analyzer and Code Generator.

To set up the workspace for compiling these project, you can use the stanford virtual machine by following [this tutorial](http://mmojtahedi.ir/images/courses/compilers/spring-97/Tutorial.pdf). Alternatively, you can use [this docker image](https://github.com/An-Alone-Cow/compiler-project-docker) prepared by [@An-Alone-Cow](https://github.com/An-Alone-Cow) and [@mtp1376](https://github.com/mtp1376). 

### Phase 0 (PA1): Write some cool code

Three codes got implemented in the COOL language to get more familiar with this language. for example [this code](./PA1/1.cl) is the implementation of palindrom checking for a string.

To run cool codes, after setting up the environment, you can run the below command.
```
> coolc 1.cl
> spim 1.s
```

The first command will output a MIPS code which can be run by spim (which is a MIPS simulator).

### Phase 1 (PA2): Lexer

The first part of implementing a compiler is to write a lexer. Lexer will tokenize the code and do a [lexical analysis](https://en.wikipedia.org/wiki/Lexical_analysis) on it.

For this phase, I used [flex](https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_node/flex_19.html) library, which generates a lexer from a .flex file. My flex file for COOL language can be found [here](./PA2/cool.flex). It's easy to read and understand.

To run my code, please copy this file to PA2 folder in assignments folder and run `make lexer` to have the generated lexer code or `make` to have the lexer code linked with other completed part of project.

### Phase 2 (PA3): Parser

The second part of implementing a compiler is to write a parser. [Parser](https://en.wikipedia.org/wiki/Parsing) has the responsibility of checking whether the code structure is correct or not. I used [Bison](https://www.gnu.org/software/bison/manual/html_node/index.html) to generate a parser code.

You can find my parser for COOL language [here](./PA3/cool.y). And to run my code, please copy this file to PA3 folder in assignments folder and run `make parser` to have the generated parser code or `make` to have the parser code linked with other completed part of project.

### Phase 3 (PA4): Semantic Analyzer

The third part of a compiler is a semantic analyzer. (Semantic Analysis)[https://www.tutorialspoint.com/compiler_design/compiler_design_semantic_analysis.htm] is something more than just lexer and parser validations (which are syntactic). In this part compiler desingers try to create rules which prevents to run-time errors or as the name says, they are about semantic of the code. COOL languange has some semantic rules too. For example we can mention its inheritence rules.

This part of code is written purely in C++ and can be found in (PA4)[./PA4] folder of this repository.

To run this part of code, do just like the other parts.

### Phase 4 (PA5): Code Generation

After all validation levels, the most important job of a compiler is to create machine code which can be understand and run by processor. In this phase, I wrote a MIPS [code generator](https://en.wikipedia.org/wiki/Code_generation_(compiler)) with C++ which is available in (PA5)[./PA5] folder.

To run this part of code, do just like the other parts.

### Further phases

This project can be continued by adding [optimization rules](https://www.geeksforgeeks.org/code-optimization-in-compiler-design/) to code generation code. I tried to add some simple optimization rules (such as removing inaccessible variables), but did not push them to this repository as it's not a complete phase.

At last, I appreciate any pull request or getting inspiration for your project. 
 
