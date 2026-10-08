__version__: str

def time_axis(samples: int, dt_ms: float) -> list[float]:
    """Return samples instants t[i] = i * dt_ms; dt_ms must be positive and finite."""
    ...

def sampled_span(samples: int, dt_ms: float) -> float:
    """Time between first and last samples in milliseconds."""
    ...
