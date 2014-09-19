# Pure Virtual Classes and VCS

It turns out that VCS and Questa have different opinions about what constitutes an error when using pure virtual classes. 

* Questa says that it is OK to write code that could instantiate a pure virtual class as long as no pure virtual class is ever instantiated.

* VCS says that it is not OK to write code that could instantiate a pure virtual class.

Several examples (starting in chapter 13) use a pure virtual class to define a `base_tester` class, but then override that class using the factory.  VCS does not like these examples.

To fix this I've included a file named `vcs_base_tester.svh`.  To use the `vcs_base_tester.svh` file simply copy it over the `base_tester.svh` file in directories where you see it.



