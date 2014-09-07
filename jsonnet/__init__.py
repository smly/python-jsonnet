# -*- coding: utf-8 -*-
"""
Jsonnet <http://google.github.io/jsonnet/doc/> is a domanin specific
configuration language that helps you defin eJSON data.

Converting from Jsonnet into JSON::

    >>> import jsonnet
    >>> jsonnet.loads('\\"foo\\bar"') == u'"foo\x08ar'
    True

"""
from .helper.jsonnet_helper import loads as _loads
from .helper.jsonnet_helper import load as _load


def loads(s):
    """
    Convert ``s`` (a ``s`` instance containing a Jsonnet document) to a JSON
    data.
    """
    return _loads(s)


def load(filename):
    return _load(filename)


__all__ = ['loads']

__author__ = 'Kohei Ozaki <i@ho.lc>'

__version__ = '0.0.1'
