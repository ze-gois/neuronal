//! Numerical core, independent of Python.

/// Sample instants in milliseconds: t[i] = i * dt_ms.
/// The caller chooses the exact sample count; no endpoint is inferred.
pub fn time_axis(samples: usize, dt_ms: f64) -> Result<Vec<f64>, &'static str> {
    if !dt_ms.is_finite() || dt_ms <= 0.0 {
        return Err("dt_ms must be finite and positive");
    }
    if samples > 0 && !((samples - 1) as f64 * dt_ms).is_finite() {
        return Err("time axis exceeds the finite range");
    }
    let mut times = Vec::new();
    times
        .try_reserve_exact(samples)
        .map_err(|_| "cannot allocate time axis")?;
    times.extend((0..samples).map(|i| i as f64 * dt_ms));
    Ok(times)
}
