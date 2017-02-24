Kinpira
==================================================

Kinpira is the hardware accelerator, or platform for neural networks.
This project aims for the flexibility and the performance
for various network structures.

Requirements
==================================================

Kinsys is tested on Debian 8.7 and CentOS 6.8.
Each modules and scripts are run using the tools listed below.

* gcc >= 4.9.2
* ruby >= 2.3.1
* Modelsim >= 10.4c
* Vivado >= 2016.4
* Design Compiler >= L-2016.03-SP4

Documentation
==================================================

We have documentations in `doc` directory.
Documentations are written using Sphinx,
so you can build the HTML version of documentations by running:
```
cd doc
make html
```
or by running similar commands for other format
(you can confirm which formats are available by running `make`).

TODOs
==================================================

* Gobou (1D-Coprocessor)
  - Bypass relu module for last layer.
    + usually with identity or softmax
  - Use another mechanism for caching weights.
    + we have just a little BRAM today

* Renkon (2D-Coprocessor)
  - Implement the padding option for conv module.
  - Implement the universal filter-size conv module.
    + with 1 MAC for each module
  - Bypass pool module.
  - Implement the stride option for pool module.
  - Implement the universal filter-size pool module.

* Ninjin (AXI4-Interface)
  - Use DRAM for image memory with Central-DMA.
  - Use memory-mapped AXI4.

* Other parts
  - Provide sufficient documents
    + include in-code comments
  - Synthesis API with simple syntax like major DL frameworks.
    + simple module / pe definition DSL.
    + like MapReduce
  - Integrate DL frameworks
    + weight dumping script (utils/kinpira.py (dump))
    + define API for synthesizable layers
  - Split library
    + dumping weights
    + integrated interface with kinpira

License
==================================================

MIT License (see `LICENSE` file).

