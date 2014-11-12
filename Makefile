
CXX = g++
GNUJAVACOMP = gcj
HEADERGEN = gcjh
CFLAGS = -O2
LFLAGS = -lstdc++

src_cpp = \
	src/nat.cpp \
	src/stl.cpp

src_java = \
	src/sample.java

objects_native  = ${src_cpp:.cpp=.o} ${src_java:.class=.o}
objects_java = ${src_java:.java=.class}

sample: $(objects_java) src/sample.h $(objects_native)
	$(GNUJAVACOMP) -o sample $(objects_native) --main=sample $(LFLAGS)

clean:
	rm -f $(objects_native) $(objects_java) sample.h

distclean: clean
	rm -f sample

%.class: %.java
	$(GNUJAVACOMP) -C $<

%.h: %.class
	$(HEADERGEN) $< -o $@

%.o: %.class
	$(GNUJAVACOMP) -c $< -o $@

%.o: %.cpp
	$(CXX) -c $(CFLAGS) $< -o $@
