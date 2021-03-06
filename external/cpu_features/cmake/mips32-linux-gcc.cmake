set(CMAKE_SYSTEM_NAME "Linux")
set(CMAKE_SYSTEM_PROCESSOR "mips32")

if (ENABLE_DSPR2 AND ENABLE_MSA)
  message(FATAL_ERROR "ENABLE_DSPR2 and ENABLE_MSA cannot be combined.")
endif ()

if (ENABLE_DSPR2)
  set(HAVE_DSPR2            1 CACHE BOOL "" FORCE)
  set(MIPS_CFLAGS           "-mdspr2")
  set(MIPS_CXXFLAGS         "-mdspr2")
elseif (ENABLE_MSA)
  set(HAVE_MSA 1 CACHE BOOL "" FORCE)
  set(MIPS_CFLAGS           "-mmsa")
  set(MIPS_CXXFLAGS         "-mmsa")
endif ()

if ("${MIPS_CPU}" STREQUAL "")
  set(MIPS_CFLAGS           "${MIPS_CFLAGS} -mips32r2")
  set(MIPS_CXXFLAGS         "${MIPS_CXXFLAGS} -mips32r2")
elseif ("${MIPS_CPU}" STREQUAL "p5600")
  set(P56_FLAGS             "-mips32r5 -mload-store-pairs -msched-weight -mhard-float -mfp64")
  set(MIPS_CFLAGS           "${MIPS_CFLAGS} ${P56_FLAGS}")
  set(MIPS_CXXFLAGS         "${MIPS_CXXFLAGS} ${P56_FLAGS}")
  set(CMAKE_EXE_LINKER_FLAGS  "-mfp64 ${CMAKE_EXE_LINKER_FLAGS}")
endif ()

set(CMAKE_C_COMPILER        ${CROSS}gcc)
set(CMAKE_CXX_COMPILER      ${CROSS}g++)
set(AS_EXECUTABLE           ${CROSS}as)
set(CMAKE_C_COMPILER_ARG1   "-EL ${MIPS_CFLAGS}")
set(CMAKE_CXX_COMPILER_ARG1 "-EL ${MIPS_CXXFLAGS}")

set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt." FORCE)
