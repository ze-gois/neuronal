import math

import pytest
import neuronal


def test_native_time_axis():
    assert neuronal.time_axis(5, 0.1) == pytest.approx([0, 0.1, 0.2, 0.3, 0.4])
    assert neuronal.time_axis(0, 0.1) == []


@pytest.mark.parametrize("dt_ms", [0, -1, math.nan, math.inf])
def test_invalid_step(dt_ms):
    with pytest.raises(ValueError):
        neuronal.time_axis(5, dt_ms)
