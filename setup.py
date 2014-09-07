#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
    import distribute_setup
    distribute_setup.use_setuptools()
except:
    pass

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup

from Cython.Build import cythonize

import os
import re


with open(os.path.join(os.path.dirname(__file__), 'jsonnet', '__init__.py')) as f:
    version = re.search("__version__ = '([^']+)'", f.read()).group(1)


setup(
    name="jsonnet",
    version=version,
    author='Kohei Ozaki <i@ho.lc>',
    ext_modules=cythonize("jsonnet/helper/jsonnet_helper.pyx"),
    packages=["jsonnet", "jsonnet/helper"],
    classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
)
