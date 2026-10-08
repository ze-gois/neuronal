# neuronal

Pacote Python com núcleo numérico escrito em Rust. Esqueleto inicial para
simulação neuronal e, posteriormente, geração de registros extracelulares sintéticos.
Ainda não implementa neurônios LIF nem spike sorting.

## Estrutura

- `crates/neuronal-core`: núcleo Rust sem dependência de Python.
- `crates/neuronal-python`: interface PyO3; extensão `neuronal._native`.
- `python/neuronal`: API pública Python e tipos.
- `examples`: exemplos executáveis.
- `tests`: verificação da integração Python–Rust.

## Desenvolvimento

Requisitos: Rust estável (cargo/rustc), Python 3.10+ e compilador/linker do sistema.

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install 'maturin>=1.9,<2' 'pytest>=8'
maturin develop
python examples/time_axis.py
pytest
cargo fmt --all --check
cargo check --workspace
```

Exemplo:

```python
import neuronal

print(neuronal.time_axis(samples=5, dt_ms=0.1))
```

A função retorna uma lista Python; NumPy não é obrigatório nesta primeira etapa.
O número de amostras é explícito: o último instante é `(samples - 1) * dt_ms`.
Zero amostras produz uma lista vazia. O passo deve ser finito e positivo.

## Distribuição local

```bash
maturin build --release --out dist
python -m pip install dist/*.whl
```

O nome `neuronal` é o nome local pretendido; disponibilidade no PyPI não foi
verificada e nenhum pacote foi publicado. Licença de distribuição ainda a definir.

## Próxima entrega

Implementar LIF determinístico no núcleo, validar contra solução analítica e
expor potencial de membrana e tempos de disparo ao Python. Depois: populações,
entradas estocásticas e registros extracelulares com ground truth.
