```tree
srcs/
├── main.c                    ● the governor: arguments, context, cleanup; calls pack
│
├── packer/
│   ├── packer.c              ○ pack — orchestrates the whole pipeline
│   └── stub.c                ○ inject_stub — builds the stub buffer, writes key/addresses into it
│
├── elf/
│   ├── parser.c              ● parse_elf — orchestrates the reading, returns the "view"
│   ├── validate.c            ○ validates magic / ELFCLASS64 class / EM_X86_64 machine
│   ├── segment.c             ○ locates the PT_LOAD that holds the entry point
│   └── print.c               ● print_ehdr — inspection tool (not part of the deliverable)
│
├── crypto/
│   ├── cipher.c              ○ encrypt — enciphers the region named by the view
│   └── keygen.c              ○ keygen — generates the random key
│
├── io/
│   └── bin_io.c              ● read_bin (reading); to extend: write_woody (writing)
│
└── utils/
    ├── error.c              ● print_error / fatal
    └── cleaning.c            ● free_ressources
```
