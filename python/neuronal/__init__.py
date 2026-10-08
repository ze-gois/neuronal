"""Neural simulation backed by Rust."""
from ._native import __version__, sampled_span, time_axis

__all__ = ["__version__", "sampled_span", "time_axis"]
