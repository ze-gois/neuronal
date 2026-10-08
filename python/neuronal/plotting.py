"""Optional plotting helpers; install neuronal-rs[plot] to use them."""
from ._native import time_axis


def plot_time_axis(samples: int = 100, dt_ms: float = 0.1):
    """Plot sample instants and return the Matplotlib figure and axes."""
    import matplotlib.pyplot as plt

    times = time_axis(samples, dt_ms)
    fig, ax = plt.subplots()
    ax.plot(range(samples), times)
    ax.set_xlabel("Índice da amostra")
    ax.set_ylabel("Tempo (ms)")
    return fig, ax
