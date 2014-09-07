# -*- coding: utf-8 -*-
# distutils: language = c++
# distutils: sources = jsonnet/helper/src/static_analysis.cpp jsonnet/helper/src/lexer.cpp jsonnet/helper/src/vm.cpp jsonnet/helper/src/parser.cpp jsonnet/helper/src/libjsonnet.cpp
# distutils: extra_compile_args = -std=c++0x
# distutils: extra_link_args = -std=c++0x -fPIC
# distutils: include_dirs = jsonnet/helper/src

cdef extern from "libjsonnet.h":
    cdef cppclass JsonnetVM:
        JsonnetVM()
    JsonnetVM* jsonnet_make()
    void jsonnet_max_stack(JsonnetVM *vm, unsigned v)
    void jsonnet_gc_min_objects(JsonnetVM* vm, unsigned v)
    void jsonnet_gc_growth_trigger(JsonnetVM* vm, double v)
    void jsonnet_debug_ast(JsonnetVM* vm, int v)
    void jsonnet_max_trace(JsonnetVM* vm, unsigned v)
    void jsonnet_destroy(JsonnetVM* vm)
    void jsonnet_cleanup_string(JsonnetVM* vm, const char*)
    const char* jsonnet_evaluate_file(JsonnetVM* vm, const char* filename, int* error)
    const char* jsonnet_evaluate_snippet(JsonnetVM* vm, const char* filename, const char* snippet, int* error)


def load(filename):
    cdef JsonnetVM* vm
    cdef const char* src
    cdef const char* out
    cdef unsigned max_stack = 500, gc_min_objects = 1000, max_trace = 20
    cdef double gc_growth_trigger = 2
    cdef int debug_ast = 0, error

    vm = jsonnet_make()
    jsonnet_max_stack(vm, max_stack)
    jsonnet_gc_min_objects(vm, gc_min_objects)
    jsonnet_max_trace(vm, max_trace)
    jsonnet_gc_growth_trigger(vm, gc_growth_trigger)
    jsonnet_debug_ast(vm, debug_ast)

    cdef bytes py_bytes = filename.encode()
    cdef const char* c_string = py_bytes

    out = jsonnet_evaluate_file(vm, c_string, &error)
    cdef bytes python_byte_s = out
    jsonnet_cleanup_string(vm, out)
    jsonnet_destroy(vm)

    return python_byte_s


def loads(code):
    cdef JsonnetVM* vm
    cdef const char* filename = "rawcode"
    cdef const char* src
    cdef const char* out
    cdef unsigned max_stack = 500, gc_min_objects = 1000, max_trace = 20
    cdef double gc_growth_trigger = 2
    cdef int debug_ast = 0, error

    vm = jsonnet_make()
    jsonnet_max_stack(vm, max_stack)
    jsonnet_gc_min_objects(vm, gc_min_objects)
    jsonnet_max_trace(vm, max_trace)
    jsonnet_gc_growth_trigger(vm, gc_growth_trigger)
    jsonnet_debug_ast(vm, debug_ast)

    cdef bytes py_bytes = code.encode()
    cdef const char* c_string = py_bytes

    out = jsonnet_evaluate_snippet(vm, filename, c_string, &error)
    cdef bytes python_byte_s = out
    jsonnet_cleanup_string(vm, out)
    jsonnet_destroy(vm)

    return python_byte_s
