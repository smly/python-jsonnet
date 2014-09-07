from distutils.core import setup
from Cython.Build import cythonize


setup(
    name="helper",
    ext_modules=cythonize("jsonnet_helper.pyx"),
)
