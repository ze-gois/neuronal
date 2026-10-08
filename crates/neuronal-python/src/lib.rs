use pyo3::exceptions::PyValueError;
use pyo3::prelude::*;

/// Return sample instants in milliseconds as a Python list.
#[pyfunction]
fn time_axis(py: Python<'_>, samples: usize, dt_ms: f64) -> PyResult<Vec<f64>> {
    py.detach(|| neuronal_core::time_axis(samples, dt_ms))
        .map_err(PyValueError::new_err)
}

/// Time between the first and last samples in milliseconds.
#[pyfunction]
fn sampled_span(samples: usize, dt_ms: f64) -> PyResult<f64> {
    neuronal_core::sampled_span(samples, dt_ms).map_err(PyValueError::new_err)
}

#[pymodule]
fn _native(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add("__version__", env!("CARGO_PKG_VERSION"))?;
    m.add_function(wrap_pyfunction!(time_axis, m)?)?;
    m.add_function(wrap_pyfunction!(sampled_span, m)?)?;
    Ok(())
}
